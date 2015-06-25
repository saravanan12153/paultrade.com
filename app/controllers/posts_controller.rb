class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:upvote, :downvote]
  before_action :set_post, only: [:show, :upvote, :downvote]

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

  def upvote
    @post.upvote_from current_user
    redirect_to post_path(@post), notice: "Liked!"
  end

  def downvote
    @post.downvote_from current_user
    redirect_to post_path(@post), notice: "Unliked!"
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

end
