class RenameDateToTargetedAt < ActiveRecord::Migration[5.2]
  def change
    rename_column :stamps, :date, :targeted_at
  end
end
