class CreateSpinaProductDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_product_drafts do |t|
      t.jsonb :json_attributes, null: false
      t.integer :version_id, null: false
      t.integer :ingredients, array: true, default: []
      t.references :product, null: false, foreign_key:  { to_table: :spina_products }

      t.timestamps
    end
  end
end
