class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :summary
      t.string :title
      t.string :url
      t.time :published
      t.text :content

      t.timestamps
    end
  end
end
