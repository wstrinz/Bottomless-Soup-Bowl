class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :last_refresh
  # attr_accessible :title, :body
  has_one :user_stats
  has_many :stories, :through => :user_stats
  has_and_belongs_to_many :bsb_feeds
  has_many :flavors

  def addFeed (feed)
    if feed
      bsb_feeds.build(last_update: feed.last_update, read_index: feed.read_index, title: feed.title, url: feed.url)
    end
  end

  def remove_all_feeds
    bsb_feeds.each do |bf|
      bf.destroy
    end
  end

  def refresh_stats
    if !self.last_refresh
      self.last_refresh = Time.now - 7.days
    end
    bsb_feeds.each do |feed|
      feed.update_feed
      feed.stories.each do |story|
        if(story.published && (story.published > last_refresh))
          user_stats.stories << story
        end
      end
      #user_stats.stories.save
    end
    self.last_refresh = Time.now
    self.save
  end

  def mark_read(story)
    user_stats.stories.delete(story)
  end

  def import_feeds(file)

    urls = []

    doc = Nokogiri::XML(file)
    doc.xpath("//outline").each do |ent|
      if ent.attribute("xmlUrl")
        urls.push(ent.attribute("xmlUrl").value)
      end
    end
    #urls = import_feeds_from_xml(file)

    urls.each do |u|
      bf = BsbFeed.new(url: u)
      if bf.valid?
        bsb_feeds << BsbFeed.new(url: u)
      end
    end

    bsb_feeds.each do |bf|
      bf.update_feed
    end
  end

  def create_user_stats
    self.user_stats = UserStats.new(:total_read => 0)
    #user_stats.save
  end
end
