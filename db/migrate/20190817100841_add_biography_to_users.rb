class AddBiographyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :biography, :string, limit: 140
  end
end
