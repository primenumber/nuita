class CreateLinkCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :link_categories do |t|
      t.references :link, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
    add_index :link_categories, [:link_id, :category_id], unique: true
  end
end
