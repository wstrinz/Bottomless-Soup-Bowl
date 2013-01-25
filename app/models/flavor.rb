class Flavor < ActiveRecord::Base
  attr_accessible :name, :read_index
  belongs_to :user
  has_one :scoring_algorithm
  has_many :bsb_feeds, through: :user
  #has_many :stories, through: :bsb_feeds

  def score_stories
    bsb_feeds.each do |bfeed|
      bfeed.stories.each do |story|
        story.score = scoring_algorithm.score_individual(story)
        story.save
      end
    end
  end

end
