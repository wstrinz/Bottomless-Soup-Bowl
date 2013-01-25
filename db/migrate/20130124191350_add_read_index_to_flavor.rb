class AddReadIndexToFlavor < ActiveRecord::Migration
  def change
    add_column :flavors, :read_index, :integer
  end
end
