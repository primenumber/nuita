class AddUrlDigestToNweets < ActiveRecord::Migration[5.2]
  def change
    add_column :nweets, :url_digest, :string
    add_index :nweets, :url_digest, unique: true
  end
end
