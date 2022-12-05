class AddVersionToSpinaPages < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_pages, :version_id, :jsonb, default: {I18n.locale => 1}
    add_column :spina_pages, :version_counter, :jsonb, default: {I18n.locale => 1}
  end
end
