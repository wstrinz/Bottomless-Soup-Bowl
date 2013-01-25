class CreateScoringAlgorithms < ActiveRecord::Migration
  def change
    create_table :scoring_algorithms do |t|
      t.string :name

      t.timestamps
    end
  end
end
