module Spina::Admin
  class ProductsController < AdminController
    before_action :set_account
    before_action :set_locale
    before_action :set_product, only: [:edit, :edit_draft, :update]
    before_action :set_index_breadcrumb, only: :index
    before_action :set_edit_breadcrumb, only: :edit

    def index
      @products = params[:query].present? ? Spina::Product.where(deleted: false).order(updated_at: :desc).select{|i| i.product_name(@locale).downcase.match(params[:query].downcase)} : Spina::Product.where(deleted: false).order(updated_at: :desc)
      if params[:sort].present?
        if params[:sort].to_s == "sort_az"
          @products = @products.sort_by{|i| i.product_name(@locale).downcase}
        elsif params[:sort].to_s == "sort_za"
          @products = @products.sort_by{|i| i.product_name(@locale).downcase}.reverse!
        elsif params[:sort].to_s == "sort_19"
          @products = @products.sort_by{|i| i.updated_at}
        end
      end
    end

    def show
      redirect_to spina.edit_admin_product_path(params[:id])
    end

    def edit
      @product = Spina::Product.where(deleted: false).find(params[:id])
      if Spina::ProductDraft.where(product_id: @product.id).empty?
        Spina::ProductDraft.create(json_attributes: @product.json_attributes.dup, version_id: 1, product_id: @product.id, ingredients: @product.product_ingredients.order(:rank).map(&:ingredient_id))
      end
    end

    def edit_draft
      render layout: false
    end

    def update
      if product_params[:active_product_draft].present?
        product_draft = Spina::ProductDraft.find(product_params[:active_product_draft])
        @product.json_attributes = product_draft.json_attributes.dup
        @product.version_id = product_draft.version_id
        ingredient_ids = product_draft.ingredients
        @product.product_ingredients.each do |product_ingredient|
          unless ingredient_ids.include?(product_ingredient.ingredient_id)
            product_ingredient.delete
          end
        end

        ingredient_ids.each_with_index do |ingredient_id, index|
          product_ingredient = @product.product_ingredients.find_by(ingredient_id: ingredient_id)
          if product_ingredient.present?
            product_ingredient.update(rank: index + 1)
          else
            Spina::ProductIngredient.create(ingredient_id: ingredient_id, product: @product, rank: index + 1)
          end
        end
      else
        json_attributes = {}
        Spina.locales.each do |locale|
          json_attributes.merge!("#{locale}_content" => {name: product_params["#{locale}_name"], subtitle: product_params["#{locale}_subtitle"], description: product_params["#{locale}_description"], signed_blob_id: product_params["#{locale}_signed_blob_id"], filename: product_params["#{locale}_filename"], image_id: product_params["#{locale}_image_id"]})
        end
        @product.json_attributes = json_attributes
        ingredient_ids = product_params[:product_ingredient_string].split(",").map(&:to_i)
        @product.product_ingredients.each do |product_ingredient|
          unless ingredient_ids.include?(product_ingredient.ingredient_id)
            product_ingredient.delete
          end
        end

        ingredient_ids.each_with_index do |ingredient_id, index|
          product_ingredient = @product.product_ingredients.find_by(ingredient_id: ingredient_id)
          if product_ingredient.present?
            product_ingredient.update(rank: index + 1)
          else
            Spina::ProductIngredient.create(ingredient_id: ingredient_id, product: @product, rank: index + 1)
          end
        end

        @product.json_attributes = json_attributes
        @product.version_counter += 1
        @product.version_id = @product.version_counter
      end

      if @product.save
        Spina::ProductDraft.create(product_id: @product.id, json_attributes: @product.json_attributes.dup, version_id: @product.version_id, ingredients: @product.product_ingredients.order(:rank).map(&:ingredient_id)) unless product_params[:active_product_draft].present?
        redirect_to admin_product_path(product: @product, locale: @locale), flash: {success: t("spina.products.saved")}
      else
        flash.now[:error] = t("spina.products.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    private

    # Permit all attributes when editing your layout
    def product_params
      params.require(:product).permit!
    end

    def set_index_breadcrumb
      add_breadcrumb t("spina.products.products")
    end

    def set_edit_breadcrumb
      add_breadcrumb t("spina.products.products"), spina.admin_products_path, class: 'text-gray-400'
      add_breadcrumb @product.product_name(@locale)
    end

    def set_account
      @account = current_spina_account
    end

    def set_product
      @product = Spina::Product.where(deleted: false).find(params[:id])
    end

    def set_locale
      @locale = params[:locale] || (params.include?(:product) ? params.require(:product).permit(:locale)[:locale] : I18n.default_locale) || I18n.default_locale
    end
  end
end
