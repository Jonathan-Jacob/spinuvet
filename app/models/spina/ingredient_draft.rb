module Spina
  class IngredientDraft < ApplicationRecord
    belongs_to :ingredient

    def ingredient_name(locale)
      return self.json_attributes["#{locale}_content"]["name"] if self.json_attributes["#{locale}_content"].present? && self.json_attributes["#{locale}_content"]["name"].present?

      return self.json_attributes["#{I18n.default_locale}_content"]["name"] if self.json_attributes["#{I18n.default_locale}_content"].present? && self.json_attributes["#{I18n.default_locale}_content"]["name"].present?

      Spina.locales.each do |spina_locale|
        return self.json_attributes["#{spina_locale}_content"]["name"] if self.json_attributes["#{spina_locale}_content"].present? && self.json_attributes["#{spina_locale}_content"]["name"].present?
      end

      "#{I18n.t('spina.ingredients.ingredient')} #{self.ingredient_id}"
    end
  end
end
