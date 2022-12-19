module Spina
  class Ingredient < ApplicationRecord
    include AttrJson::Record

    attr_json :name, :string
    attr_json :description, :text
  end
end
