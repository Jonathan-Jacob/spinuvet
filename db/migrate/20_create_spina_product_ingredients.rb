class CreateSpinaProductIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_product_ingredients do |t|
      t.references :product, null: false, foreign_key: {to_table: :spina_products}
      t.references :ingredient, null: false, foreign_key: {to_table: :spina_ingredients}

      t.timestamps
    end
  end
end
