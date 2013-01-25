class AddScoreToStories < ActiveRecord::Migration
  def change
    add_column :stories, :score, :float
  end
end
