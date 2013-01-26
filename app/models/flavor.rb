class Flavor < ActiveRecord::Base
  attr_accessible :name, :read_index
  belongs_to :user
  has_one :sorter
  has_many :bsb_feeds
  #has_many :stories, through: :bsb_feeds

  def score_stories
    bsb_feeds.each do |bfeed|
      bfeed.stories.each do |story|
        story.score = sorter.score_individual(story)
        story.save
      end
    end
  end

end
