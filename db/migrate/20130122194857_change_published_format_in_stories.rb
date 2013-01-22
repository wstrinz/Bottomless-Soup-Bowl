class ChangePublishedFormatInStories < ActiveRecord::Migration
    def up
    change_column :stories, :published, :datetime
  end

  def down
    change_column :stories, :published, :time
  end
end
