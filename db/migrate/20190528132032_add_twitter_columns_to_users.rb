class AddTwitterColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_uid, :string
    add_column :users, :twitter_screen_name, :string
    add_column :users, :twitter_url, :string
  end
end
