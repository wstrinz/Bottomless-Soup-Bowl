class AddForeignKeyToBsbFeeds < ActiveRecord::Migration
  def change
    add_column :bsb_feeds, :user_id, :integer
  end
end
