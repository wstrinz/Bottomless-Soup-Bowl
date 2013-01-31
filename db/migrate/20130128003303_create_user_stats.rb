class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.integer :total_read

      t.timestamps
    end
  end
end
