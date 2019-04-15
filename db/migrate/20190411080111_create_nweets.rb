class CreateNweets < ActiveRecord::Migration[5.2]
  def change
    create_table :nweets do |t|
      t.datetime :did_at
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :nweets, [:user_id, :did_at]
  end
end
