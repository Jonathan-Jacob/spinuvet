module Spina::Admin
  class ProductIngredientsController < AdminController
    before_action :set_account
    before_action :set_locale
    before_action :set_product
    before_action :set_ingredients

    def index
      @ingredients_az = params[:query].present? ? @ingredients.sort_by{|i| i.ingredient_name(@locale)}.select{|i| i.ingredient_name(@locale).downcase.match(params[:query].downcase)} : @ingredients.sort_by{|i| i.ingredient_name(@locale)}
      @order = params[:product_ingredient_string].split(",").map(&:to_i) if params[:product_ingredient_string].present?
      @selected_ingredients = @order.present? ? @ingredients.select{|i| @order.include?(i.id)}.sort_by{|i| @order.index(i.id)} : @product.product_ingredients.order(:rank).map(&:ingredient)
      raise if @order.present?
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
