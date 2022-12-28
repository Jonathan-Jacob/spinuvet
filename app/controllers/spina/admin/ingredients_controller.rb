module Spina::Admin
  class IngredientsController < AdminController
    before_action :set_account
    before_action :set_locale
    before_action :set_breadcrumb

    def index
      @ingredients = Spina::Ingredient.order(:id)
      @ingredient = Spina::Ingredient.new
    end

    def create
      @ingredient = Spina::Ingredient.new(json_attributes: {"#{@locale}_content".to_sym => {name: ingredient_params[:name], description: ingredient_params[:description]}})
      if @ingredient.save
        redirect_to admin_ingredients_path(locale: @locale), flash: {success: t("spina.layout.saved")}
      else
        flash.now[:error] = t("spina.layout.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    def update
      @ingredient = Spina::Ingredient.find(params[:id])
      @ingredient.json_attributes["#{@locale}_content".to_sym] = {name: ingredient_params[:name], description: ingredient_params[:description]}
      if @ingredient.save
        redirect_to admin_ingredients_path(locale: @locale), flash: {success: t("spina.layout.saved")}
      else
        flash.now[:error] = t("spina.layout.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    private

    # Permit all attributes when editing your layout
    def ingredient_params
      params.require(:ingredient).permit(:name, :description)
    end

    def set_breadcrumb
      add_breadcrumb t("spina.ingredients.ingredients")
    end

    def set_account
      @account = current_spina_account
    end

    def set_locale
      @locale = params[:locale] || params.include?(:ingredient) ? require(:ingredient).permit(:locale)[:locale] : I18n.default_locale || I18n.default_locale
    end
  end
end
