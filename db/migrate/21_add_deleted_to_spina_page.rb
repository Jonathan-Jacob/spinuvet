class AddDeletedToSpinaPage < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_pages, :deleted, :boolean, default: false
  end
end
