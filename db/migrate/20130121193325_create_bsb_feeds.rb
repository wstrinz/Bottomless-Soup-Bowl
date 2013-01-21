class CreateBsbFeeds < ActiveRecord::Migration
  def change
    create_table :bsb_feeds do |t|
      t.string :title
      t.time :last_update
      t.string :url
      t.integer :read_index

      t.timestamps
    end
  end
end
