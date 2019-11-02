class AddLatestLikedTimeToNweets < ActiveRecord::Migration[5.2]
  def change
    add_column :nweets, :latest_liked_time, :datetime
  end
end
