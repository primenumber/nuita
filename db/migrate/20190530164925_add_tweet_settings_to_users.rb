class AddTweetSettingsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :autotweet_enabled, :boolean, default: false
    add_column :users, :autotweet_content, :Text, limit: 140, default: "#nuita"
  end
end
