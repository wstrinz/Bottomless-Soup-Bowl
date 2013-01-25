class AddForeignKeyToFlavor < ActiveRecord::Migration
  def change
    add_column :flavors, :user_id, :integer
  end
end
