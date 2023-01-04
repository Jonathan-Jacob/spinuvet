class AddRankToSpinaProductIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :spina_product_ingredients, :rank, :integer, default: 999
  end
end
