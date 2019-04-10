class AddHandleAndScreenNamesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :handle_name, :string, limit: 30
    add_column :users, :screen_name, :string, limit: 20

    add_index :users, :screen_name, unique: true
  end
end
