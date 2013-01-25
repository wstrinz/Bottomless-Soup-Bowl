class AddForeignKeyToScoringAlgorithm < ActiveRecord::Migration
  def change
    add_column :scoring_algorithms, :flavor_id, :integer
  end
end
