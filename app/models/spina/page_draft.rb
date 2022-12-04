module Spina
  class PageDraft < ApplicationRecord
    include Partable

    include AttrJson::Record
    include AttrJson::NestedAttributes

    belongs_to :spina_page, class_name: "Spina::Page"
  end
end
