class CreateBsbFeedsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :bsb_feeds_users, :id => false do |t|
      t.integer :bsb_feed_id
      t.integer :user_id
    end
  end
end
