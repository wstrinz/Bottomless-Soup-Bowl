class BsbFeed < ActiveRecord::Base
  attr_accessible :last_update, :read_index, :title, :url
  has_many :stories
end
