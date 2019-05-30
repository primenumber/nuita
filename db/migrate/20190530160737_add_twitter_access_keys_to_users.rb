class AddTwitterAccessKeysToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_access_secret, :string
    add_column :users, :twitter_access_token, :string
  end
end
