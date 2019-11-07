class AddDescriptionToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :description, :string, limit: 200
  end
end
