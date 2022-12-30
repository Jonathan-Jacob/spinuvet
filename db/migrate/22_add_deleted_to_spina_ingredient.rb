class AddDeletedToSpinaIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_ingredients, :deleted, :boolean, default: false
  end
end
