module Spina::Admin
  class IngredientsController < ApplicationController
    before_action :set_locale

    def index
      @ingredients = Ingredient.all
    end

    def create
      @ingredient = Ingredient.new(ingredient_params)
      if @ingredient.save
        redirect_to admin_ingredients_path(locale: @locale), flash: {success: t("spina.layout.saved")}
      else
        flash.now[:error] = t("spina.layout.couldnt_be_saved")
        render partial: "error", status: :unprocessable_entity
      end
    end

    def update
      @ingredient = Ingredient.find(params[:id])
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
      params.require(:ingredient).permit(:json_attributes)
    end

    def set_locale
      @locale = params[:locale] || I18n.default_locale
    end
  end
end
