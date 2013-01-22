class ChangePublishedFormatInBsbFeeds < ActiveRecord::Migration
  def up
    change_column :bsb_feeds, :last_update, :datetime
  end

  def down
    change_column :bsb_feeds, :last_update, :time
  end
end
