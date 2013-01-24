class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :bsb_feeds

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

end
