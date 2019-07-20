class CreateNweetLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :nweet_links do |t|
      t.references :nweet, index: true, foreign_key: true
      t.references :link, index: true, foreign_key: true

      t.timestamps
    end
  end
end
