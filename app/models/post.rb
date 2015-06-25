class Post < ActiveRecord::Base
  acts_as_votable
  extend FriendlyId
    friendly_id :title, use: :slugged
  has_many :subscribers, dependent: :destroy
  has_many :users, through: :subscribers
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates_presence_of :title

end
