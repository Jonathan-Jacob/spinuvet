module Spina
  class Ingredient < ApplicationRecord
    include AttrJson::Model

    attr_json_config(unknown_key: :strip)

    attr_json :name, :string
    attr_json :description, :text
  end
end
