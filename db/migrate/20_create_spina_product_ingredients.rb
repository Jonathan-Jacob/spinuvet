class CreateSpinaProductIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_product_ingredients do |t|
      t.references :spina_product, null: false, foreign_key: true
      t.references :spina_ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
