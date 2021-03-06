class PagesController < ApplicationController

  def home
    if user_signed_in?
      redirect_to posts_path
    end
    @posts = Post.where(sold: false).order("created_at DESC").first(3)
  end

  def contact_us
    email = params[:email]
    body = params[:body]
    MyMailer.contact_email(email, body).deliver
    redirect_to root_path, notice: "Your Message has been sent to Admin. We would contact you ASAP."
  end

end
