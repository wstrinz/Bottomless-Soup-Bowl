class AddForeignKeyToStories < ActiveRecord::Migration
  def change
    add_column :stories, :bsb_feed_id, :integer
  end
end
