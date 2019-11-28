class CreateBadgesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :badges_users, id: false do |t|
      t.belongs_to :badge
      t.belongs_to :user
    end
  end
end
