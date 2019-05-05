class AddStatementToNweets < ActiveRecord::Migration[5.2]
  def change
    add_column :nweets, :statement, :text, limit: 100
  end
end
