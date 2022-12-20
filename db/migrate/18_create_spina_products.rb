class CreateSpinaProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_products do |t|
      t.jsonb :json_attributes, null: false

      t.timestamps
    end
  end
end
