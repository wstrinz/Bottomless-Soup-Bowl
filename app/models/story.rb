class Story < ActiveRecord::Base
  attr_accessible :content, :published, :summary, :title, :url

  belongs_to :bsb_feed
end
