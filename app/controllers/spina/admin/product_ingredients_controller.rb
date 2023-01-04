module Spina::Admin
  class ProductIngredientsController < AdminController
    #todo: @product definieren, alle ingredients anzeigen, die nicht in @product.ingredients sind, diese auswählen -> create PI -> spiegelbildlich: destroy PI
    before_action :set_account
    before_action :set_locale
    before_action :set_product
    before_action :set_ingredients

    def index
      @ingredients_az = @ingredients.sort_by{|i| i.ingredient_name}
      @ingredients_az_with_rank = @ingredients_az.each_with_index.map{|v, i| {ingredient: v, rank_az: i + 1}}
      @selected_ingredients = @product.ingredients
      @unselected_ingredients = @ingredients.where.not(id:(@selected_ingredients.map(&:id)))
    end

    private

    def set_product
      @product = Spina::Product.where(deleted: false).find(params[:product_id])
    end

    def set_ingredients
      @ingredients = Spina::Ingredient.where(deleted: false).order(updated_at: :desc)
    end

    def set_account
      @account = current_spina_account
    end

    def set_locale
      @locale = params[:locale] || params.include?(:product) ? params.require(:product).permit(:locale)[:locale] : I18n.default_locale
    end
  end
end
