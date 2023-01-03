module Spina::Admin
  class ProductsController < AdminController
    before_action :set_account
    before_action :set_locale
    before_action :set_index_breadcrumb, only: :index
    before_action :set_edit_breadcrumb, only: :edit

    def index
      @products = Spina::Product.where(deleted: false).order(updated_at: :desc)
      if params[:sort].present?
        if params[:sort].to_s == "sort_az"
          @products = @products.sort_by{|i| i.product_name(@locale).downcase}
        elsif params[:sort].to_s == "sort_za"
          @products = @products.sort_by{|i| i.product_name(@locale).downcase}.reverse!
        elsif params[:sort].to_s == "sort_19"
          @products = @products.sort_by{|i| i.updated_at}
        end
      end
      @products = @products.select{|i| i.json_attributes["#{@locale}_content"]["name"].downcase.match(params[:query].downcase) if i.json_attributes["#{@locale}_content"].present? && i.json_attributes["#{@locale}_content"]["name"].present?} if params[:query].present?
    end

    def show
      redirect_to spina.edit_admin_product_path(params[:id])
    end

    def edit
      @product = Spina::Product.where(deleted: false).find(params[:id])
    end

    def update
      json_attributes = {}
      Spina.locales.each do |locale|
        json_attributes.merge!("#{locale}_content" => {name: product_params["#{locale}_name"], description: product_params["#{locale}_description"]})
      end
      @product = Spina::Product.where(deleted: false).find(params[:id])
      @product.json_attributes = json_attributes
      if @product.save
        redirect_to admin_products_path(locale: @locale), flash: {success: t("spina.product.saved")}
      else
        flash.now[:error] = t("spina.product.couldnt_be_saved")
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
      add_breadcrumb t("spina.products.edit_product")
    end

    def set_account
      @account = current_spina_account
    end

    def set_locale
      @locale = params[:locale] || params.include?(:product) ? params.require(:product).permit(:locale)[:locale] : I18n.default_locale
    end
  end
end
