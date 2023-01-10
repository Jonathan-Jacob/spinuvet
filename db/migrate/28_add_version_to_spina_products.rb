class AddVersionToSpinaProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_products, :version_id, :integer, default: 1
    add_column :spina_products, :version_counter, :integer, default: 1
  end
end
