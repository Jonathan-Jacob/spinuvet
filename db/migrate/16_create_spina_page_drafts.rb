class CreateSpinaPageDrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :spina_page_drafts do |t|
      t.string :view_template, null: false
      t.jsonb :json_attributes
      t.integer :version_id
      t.references :spina_page, null: false, foreign_key: true
      t.timestamps
    end
  end
end
