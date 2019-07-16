class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.text :title, limit: 100
      t.text :description, limit: 500
      t.string :image
      t.string :card
      t.string :url, null: false

      t.index :url, unique: true

      t.timestamps
    end
  end
end
