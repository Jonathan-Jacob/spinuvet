module Spina
  class Product < ApplicationRecord
    include AttrJson::Model

    attr_json_config(unknown_key: :strip)

    attr_json :name, :string
    attr_json :price, :integer
  end
end
