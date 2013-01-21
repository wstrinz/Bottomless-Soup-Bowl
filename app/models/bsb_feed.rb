class BsbFeed < ActiveRecord::Base
  attr_accessible :last_update, :read_index, :title, :url
  has_many :stories

  def reload_attributes
    @feed = Feedzirra::Feed.fetch_and_parse(url)
    @feed.entries.each do |entry|
      stories.build(summary: entry.summary, title: entry.title, url: entry.url, published: entry.published, content: entry.content)
    end
    self.last_update = @feed.last_modified
    self.read_index = 0
    self.title = @feed.title
  end

  def update_feed
    if @feed.nil?
      reload_attributes
    end
    @feed = Feedzirra::Feed.update(@feed)
    unless @feed.new_entries.empty?
      @feed.new_entries.each do |entry|
        stories.build(summary: entry.summary, title: entry.title, url: entry.url, published: entry.published, content: entry.content)
      end
    end
    self.last_update = @feed.last_modified
    self.save
  end

  def current_story
    stories[read_index]
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

end
