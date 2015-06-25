class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      # @comment.create_activity key: 'comment.created', owner: @comment.user, recipient: @comment.post
      respond_to do |format|
        format.html {redirect_to post_url(@post), notice: 'Comment Posted!!!'}
        format.js
      end
    else
      redirect_to :back, alert: 'Something went wrong!'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to post_url(@post), notice: 'Comment Deleted!'}
      format.js
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
