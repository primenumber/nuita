class CreateStamps < ActiveRecord::Migration[5.2]
  def change
    create_table :stamps do |t|
      t.datetime :date, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :action, null: false
      t.references :nweet, foreign_key: true
      t.references :like, foreign_key: true

      t.timestamps
    end
  end
end
