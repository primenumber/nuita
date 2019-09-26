class AddStatementToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :statement, :string, limit: 255
  end
end
