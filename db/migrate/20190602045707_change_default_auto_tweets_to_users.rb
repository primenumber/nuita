class ChangeDefaultAutoTweetsToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :autotweet_content, :Text, limit: 40, default: "射精しました！ #nuita [LINK]"
  end

  def down
    change_column :users, :autotweet_content, :Text, limit: 140, default: "#nuita"
  end
end
