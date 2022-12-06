module Spina
  class PageDraft < ApplicationRecord
    # include Partable

    # include AttrJson::Record
    # include AttrJson::NestedAttributes

    belongs_to :page, class_name: "Spina::Page"
  end
end


# TODO: PageDrafts localized machen! 5 PDs Deutsch, 3 PDs Englisch usw.
