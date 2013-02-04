class Flavor < ActiveRecord::Base
  attr_accessible :name, :read_index
  belongs_to :user
  has_one :sorter
  has_many :bsb_feeds
  has_many :stories, through: :user

  def score_stories
    # bsb_feeds.each do |bfeed|
    #   bfeed.stories.each do |story|
    #     story.score = sorter.score_individual(story)
    #     story.save
    #   end
    # end

    stories.each do |story|
      story.score = sorter.score_individual(story)
      story.save
    end

  end

  def get_story(rindex)
    titles = bsb_feeds.pluck(:title)
    #allstories = stories.order("score DESC").where(titles.include?(:title))[rindex]
    allstories = []
    stories.each do |story|
      if titles.include?(story.bsb_feed.title)
        allstories << story
      end
    end

    # bsb_feeds.each do |bfeed|
    #   bfeed.stories.each do |story|
    #     if(story && story.score && usr.user_stats.stories.include?(story))
    #       allstories << story
    #     end
    #   end
    # end

    allstories[rindex]
    #do not want to be sorting on every page view
    #allstories.sort_by(&:score).reverse[@flavor.read_index]
  end

end
