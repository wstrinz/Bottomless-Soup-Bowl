class CreateStatsToStoriesJoinTable < ActiveRecord::Migration
  def up
    create_table :stories_users_stats, :id => false do |t|
      t.integer :story_id
      t.integer :user_stats_id
    end
  end

  def down
    drop_table :stories_users_stats
  end
end
