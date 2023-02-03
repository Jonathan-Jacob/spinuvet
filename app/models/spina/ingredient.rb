module Spina
  class Ingredient < ApplicationRecord
    has_many :product_ingredients, dependent: :destroy
    has_many :products, through: :product_ingredients
    has_many :ingredient_drafts, dependent: :destroy

    def ingredient_name(locale)
      return self.json_attributes["#{locale}_content"]["name"] if self.json_attributes["#{locale}_content"].present? && self.json_attributes["#{locale}_content"]["name"].present?

      return self.json_attributes["#{I18n.default_locale}_content"]["name"] if self.json_attributes["#{I18n.default_locale}_content"].present? && self.json_attributes["#{I18n.default_locale}_content"]["name"].present?

      Spina.locales.each do |spina_locale|
        return self.json_attributes["#{spina_locale}_content"]["name"] if self.json_attributes["#{spina_locale}_content"].present? && self.json_attributes["#{spina_locale}_content"]["name"].present?
      end

      "#{I18n.t('spina.ingredients.ingredient')} #{self.id}"
    end
  end
end
