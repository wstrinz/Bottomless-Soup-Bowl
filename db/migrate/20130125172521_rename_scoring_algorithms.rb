class RenameScoringAlgorithms < ActiveRecord::Migration
  def up
    rename_table :scoring_algorithms, :sorters
  end

  def down
    rename_table :sorters, :scoring_algorithms
  end
end
