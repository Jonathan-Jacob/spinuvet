module Spina
  class Ingredient < ApplicationRecord
    has_many :spina_product_ingredients
  end
end
