class AddUniquenessToFavorites < ActiveRecord::Migration[5.2]
  def change
    change_column_null :favorites, :user_id, false
    change_column_null :favorites, :nweet_id, false
    add_index :favorites, [:user_id, :nweet_id], unique: true
  end
end
