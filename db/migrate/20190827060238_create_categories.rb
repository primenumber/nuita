class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, limit: 30, null: false
      t.boolean :censored_by_default, default: false, null: false

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
