class AddVersionToSpinaProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_products, :version_id, :integer
    add_column :spina_products, :version_counter, :integer
  end
end
