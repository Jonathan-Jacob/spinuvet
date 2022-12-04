class AddJsonAttributesToSpinaPages < ActiveRecord::Migration[7]
  def change
    add_column :spina_pages, :version_id, :integer
    add_column :spina_pages, :version_counter, :integer
  end
end
