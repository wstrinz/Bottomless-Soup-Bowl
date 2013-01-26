class AddFlavorKeyToBsbFeed < ActiveRecord::Migration
  def change
    add_column :bsb_feeds, :flavor_id, :integer
  end
end
