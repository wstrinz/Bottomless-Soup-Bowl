class Story < ActiveRecord::Base
  attr_accessible :content, :published, :summary, :title, :url, :author, :score

  belongs_to :bsb_feed
end
