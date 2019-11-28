class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.text :description, null: false, limit: 200
      t.string :icon, null: false

      t.timestamps
    end
  end
end
