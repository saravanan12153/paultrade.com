class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    case params[:sold]
      when "true"
        @posts = Post.where(sold: true).order("created_at DESC").page(params[:page]).per(6)
      else
        @posts = Post.where(sold: false).order("created_at DESC").page(params[:page]).per(6)
    end
  end

  def show
    @photos = @post.photos.all
    @comments = @post.comments.all
    @comment = Comment.new
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

end
