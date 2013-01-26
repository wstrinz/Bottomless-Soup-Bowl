
class BsbFeed < ActiveRecord::Base
  attr_accessible :last_update, :read_index, :title, :url
  #validates :title, presence: true
  validates_with FeedValidator
  validates :url, uniqueness: true

  has_many :stories
  belongs_to :user
  belongs_to :flavor

  def reload_attributes
    @feed = Feedzirra::Feed.fetch_and_parse(url)
    if(@feed && !(@feed.is_a? Fixnum))
      stories.destroy_all
      @feed.entries.each do |entry|
        stories.build(summary: entry.summary, title: entry.title, url: entry.url,
          published: entry.published, content: entry.content, author: entry.author)
      end
      @ordered_stories = stories.order("published DESC")
      self.last_update = @feed.last_modified
      self.read_index = 0
      self.title = @feed.title
    end
  end

  def update_feed
    if !@feed
      reload_attributes
    end
    if(@feed && !(@feed.is_a? Fixnum))
      @feed = Feedzirra::Feed.update(@feed)
    end
    if @feed.is_a? Array
      logger.error("Feed is array for #{url}")
    elsif @feed.is_a? Fixnum
      logger.error("Failed to read feed for #{url}")
    elsif !@feed.new_entries.empty?
      @feed.new_entries.each do |entry|
        stories.build(summary: entry.summary, title: entry.title, url: entry.url, published: entry.published, content: entry.content)
      end
      self.last_update = @feed.last_modified
    end
    @ordered_stories = stories.all.sort_by(&:published).reverse
    self.save
  end

  def current_story
    if(!@ordered_stories || @ordered_stories.empty)
      @ordered_stories = stories.all.sort_by(&:published).reverse
    end
    @ordered_stories[read_index]
  end

  def next_article
    unless stories[read_index+1].nil?
      self.read_index+=1
      self.save
    end
  end

  def prev_article
    unless stories[read_index-1].nil? || read_index == 0
      self.read_index-=1
      self.save
    end
  end

  def set_user(usar)
    self.user = usar
    self.save
  end
end
