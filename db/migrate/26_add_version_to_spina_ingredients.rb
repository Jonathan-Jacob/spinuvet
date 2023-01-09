class AddVersionToSpinaIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_ingredients, :version_id, :integer
    add_column :spina_ingredients, :version_counter, :integer
  end
end
