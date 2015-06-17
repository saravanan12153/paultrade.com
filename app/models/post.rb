class Post < ActiveRecord::Base
  has_many :subscribers, dependent: :destroy
  has_many :users, through: :subscribers
  validates_presence_of :content
end
