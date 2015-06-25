class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page]).per(6)
  end

  def show
    @photos = @post.photos.all
    @comments = @post.comments.all
    @comment = Comment.new
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

end
