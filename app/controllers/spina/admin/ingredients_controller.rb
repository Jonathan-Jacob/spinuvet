module Spina::Admin
  class IngredientsController < AdminController
    before_action :set_account
    before_action :set_locale
    before_action :set_index_breadcrumb, only: :index
    before_action :set_new_breadcrumb, only: :new
    before_action :set_edit_breadcrumb, only: :edit

    def index
      @ingredients = Spina::Ingredient.where(deleted: false).order(updated_at: :desc)
      if params[:sort].present?
        if params[:sort].to_s == "sort_az"
          @ingredients = @ingredients.sort_by{|i| i.ingredient_name(@locale).downcase}
        elsif params[:sort].to_s == "sort_za"
          @ingredients = @ingredients.sort_by{|i| i.ingredient_name(@locale).downcase}.reverse!
        elsif params[:sort].to_s == "sort_19"
          @ingredients = @ingredients.sort_by{|i| i.updated_at}
        end
      end
      @ingredients = @ingredients.select{|i| i.json_attributes["#{@locale}_content"]["name"].downcase.match(params[:query].downcase) if i.json_attributes["#{@locale}_content"].present? && i.json_attributes["#{@locale}_content"]["name"].present?} if params[:query].present?
    end

    def show
      redirect_to spina.edit_admin_ingredient_path(params[:id])
    end

    def new
      @ingredient = Spina::Ingredient.new
    end

    def create
      json_attributes = {}
      Spina.locales.each do |locale|
        json_attributes.merge!("#{locale}_content" => {name: ingredient_params["#{locale}_name"], description: ingredient_params["#{locale}_description"]})
      end
      @ingredient = Spina::Ingredient.new(json_attributes: json_attributes)
      if @ingredient.save
        redirect_to admin_ingredients_path(locale: @locale), flash: {success: t("spina.layout.saved")}
      else
        flash.now[:error] = t("spina.layout.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    def edit
      @ingredient = Spina::Ingredient.where(deleted: false).find(params[:id])
    end

    def update
      json_attributes = {}
      Spina.locales.each do |locale|
        json_attributes.merge!("#{locale}_content" => {name: ingredient_params["#{locale}_name"], description: ingredient_params["#{locale}_description"]})
      end
      @ingredient = Spina::Ingredient.where(deleted: false).find(params[:id])
      @ingredient.json_attributes = json_attributes
      if @ingredient.save
        redirect_to admin_ingredients_path(locale: @locale), flash: {success: t("spina.ingredient.saved")}
      else
        flash.now[:error] = t("spina.ingredient.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    def destroy
      @ingredient = Spina::Ingredient.where(deleted: false).find(ingredient_params[:id])
      @ingredient.deleted = true
      raise
      if @ingredient.save
        flash[:info] = t('spina.ingredients.deleted')
        redirect_to spina.admin_ingredients_url
      else
        flash.now[:error] = t("spina.ingredient.couldnt_be_deleted")
        render partial: "error", status: :unprocessable_entity
      end
    end

    private

    # Permit all attributes when editing your layout
    def ingredient_params
      params.require(:ingredient).permit!
    end

    def set_index_breadcrumb
      add_breadcrumb t("spina.ingredients.ingredients")
    end

    def set_new_breadcrumb
      add_breadcrumb t("spina.ingredients.new_ingredient")
    end

    def set_edit_breadcrumb
      add_breadcrumb t("spina.ingredients.edit_ingredient")
    end

    def set_account
      @account = current_spina_account
    end

    def set_locale
      @locale = params[:locale] || (params.include?(:ingredient) ? params.require(:ingredient).permit(:locale)[:locale] : I18n.default_locale) || I18n.default_locale
    end
  end
end
