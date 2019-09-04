class RenameFavoritesToLikes < ActiveRecord::Migration[5.2]
  def change
    rename_table :favorites, :likes
  end
end
