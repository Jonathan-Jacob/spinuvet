module Spina::Admin
  class ProductIngredientsController < AdminController
    #todo: @product definieren, alle ingredients anzeigen, die nicht in @product.ingredients sind, diese auswählen -> create PI -> spiegelbildlich: destroy PI
    before_action :set_account
    before_action :set_locale
    before_action :set_product
    before_action :set_ingredients

    def index
      # @selected_ingredients = @ingredients.where()
      # Spina::ProductIngredient.create(product: @product, ingredient: Spina::Ingredient.first)
      raise
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
