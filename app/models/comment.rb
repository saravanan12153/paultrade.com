class Comment < ActiveRecord::Base
  include PublicActivity::Model
  belongs_to :user
  belongs_to :post
  validates_presence_of :user_id
  validates_presence_of :post_id
  validates_presence_of :content
  auto_html_for :content do
    html_escape
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
