class AddDeletedToSpinaProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :deleted, :boolean, default: false
  end
end
