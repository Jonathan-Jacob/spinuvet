module Spina::Admin
  class ProductIngredientsController < AdminController
    #todo: @product definieren, alle ingredients anzeigen, die nicht in @product.ingredients sind, diese auswählen -> create PI -> spiegelbildlich: destroy PI
    def index
      raise
    end

    private

    def set_account
      @account = current_spina_account
    end

    def set_locale
      @locale = params[:locale] || params.include?(:product) ? params.require(:product).permit(:locale)[:locale] : I18n.default_locale
    end
  end
end
