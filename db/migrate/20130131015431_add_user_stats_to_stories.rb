class AddUserStatsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :user_stats_id, :integer
  end
end
