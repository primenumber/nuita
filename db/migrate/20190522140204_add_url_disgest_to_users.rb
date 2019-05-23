class AddUrlDisgestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :url_digest, :string
    add_index :users, :url_digest, unique: true
  end
end
