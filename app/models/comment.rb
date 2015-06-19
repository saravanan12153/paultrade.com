class Comment < ActiveRecord::Base
  include PublicActivity::Model
  belongs_to :user
  belongs_to :post
  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_presence_of :content
end
