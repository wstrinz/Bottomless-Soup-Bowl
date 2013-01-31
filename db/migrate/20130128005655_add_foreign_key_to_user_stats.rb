class AddForeignKeyToUserStats < ActiveRecord::Migration
  def change
    add_column :user_stats, :user_id, :integer
  end
end
