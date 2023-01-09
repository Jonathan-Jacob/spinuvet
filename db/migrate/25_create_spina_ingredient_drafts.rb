class CreateSpinaIngredientDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_ingredient_drafts do |t|
      t.jsonb :json_attributes, null: false
      t.integer :version_id, null: false
      t.references :ingredient, null: false, foreign_key: { to_table: :spina_ingredients }

      t.timestamps
    end
  end
end
