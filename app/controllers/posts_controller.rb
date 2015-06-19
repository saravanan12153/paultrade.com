class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @photos = @post.photos.all
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

end
