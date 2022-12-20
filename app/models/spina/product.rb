module Spina
  class Product < ApplicationRecord
    has_many :spina_product_ingredients
  end
end
