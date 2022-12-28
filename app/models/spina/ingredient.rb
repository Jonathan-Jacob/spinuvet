module Spina
  class Ingredient < ApplicationRecord
    has_many :spina_product_ingredients

    def ingredient_name(locale)
      return ingredient.json_attributes["#{locale}_content"]["name"] if ingredient.json_attributes["#{locale}_content"].present? && ingredient.json_attributes["#{locale}_content"]["name"].present?

      return ingredient.json_attributes["#{I18n.default_locale}_content"]["name"] if ingredient.json_attributes["#{I18n.default_locale}_content"].present? && ingredient.json_attributes["#{I18n.default_locale}_content"]["name"].present?

      return ingredient_name = ingredient.json_attributes.values.first["name"] if ingredient.json_attributes.values.first.present? && ingredient.json_attributes.values.first["name"].present?

      "#{I18n.t('spina.ingredients.ingredient')} #{ingredient.id}"
    end
  end
end
