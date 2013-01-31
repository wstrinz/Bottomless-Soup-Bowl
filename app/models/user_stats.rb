class UserStats < ActiveRecord::Base
  attr_accessible :total_read
  has_many :stories
  belongs_to :user
end
