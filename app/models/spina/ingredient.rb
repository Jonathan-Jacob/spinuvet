module Spina
  class Ingredient < ApplicationRecord
    has_many :spina_product_ingredients

    def ingredient_name(locale)
      return self.json_attributes["#{locale}_content"]["name"] if self.json_attributes["#{locale}_content"].present? && self.json_attributes["#{locale}_content"]["name"].present?

      return self.json_attributes["#{I18n.default_locale}_content"]["name"] if self.json_attributes["#{I18n.default_locale}_content"].present? && self.json_attributes["#{I18n.default_locale}_content"]["name"].present?

      return self.json_attributes.values.first["name"] if self.json_attributes.values.first.present? && self.json_attributes.values.first["name"].present?

      "#{I18n.t('spina.ingredients.ingredient')} #{self.id}"
    end
  end
end
