class Post < ActiveRecord::Base
  has_many :subscribers, dependent: :destroy
  has_many :users, through: :subscribers
  has_many :photos, dependent: :destroy
  validates_presence_of :title
end
