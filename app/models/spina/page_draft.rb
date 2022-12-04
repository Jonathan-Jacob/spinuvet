module Spina
  class PageDraft < ApplicationRecord
    include Partable

    include AttrJson::Record
    include AttrJson::NestedAttributes

    belongs_to :spina_page, class_name: "Spina::Page"

    attr_json :json_attributes, AttrJson::Type::SpinaPartsModel.new, array: true
    attr_json_accepts_nested_attributes_for :json_attributes
  end
end
