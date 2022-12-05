class CreateSpinaPageDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_page_drafts do |t|
      t.string :view_template, null: false
      t.jsonb :json_attributes, null: false
      t.string :title, null: false
      t.string :locale, null: false
      t.integer :version_id, null: false
      t.references :spina_page, null: false, foreign_key: true
      t.timestamps
    end
  end
end
