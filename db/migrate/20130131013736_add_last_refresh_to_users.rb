class AddLastRefreshToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_refresh, :datetime
  end
end
