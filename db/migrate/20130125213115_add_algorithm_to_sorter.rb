class AddAlgorithmToSorter < ActiveRecord::Migration
  def change
    add_column :sorters, :algorithm, :string
  end
end
