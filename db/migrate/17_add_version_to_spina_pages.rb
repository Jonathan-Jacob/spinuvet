class AddVersionToSpinaPages < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_pages, :version_id, :jsonb
    add_column :spina_pages, :version_counter, :jsonb
  end
end
