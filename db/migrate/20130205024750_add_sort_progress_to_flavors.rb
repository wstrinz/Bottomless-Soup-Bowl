class AddSortProgressToFlavors < ActiveRecord::Migration
  def change
    add_column :flavors, :sort_progress, :integer
  end
end
