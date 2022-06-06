class StaticPagesController < ApplicationController
  def home
    @tweet = current_user.tweets.build if logged_in?
    @feed_items = current_user.feed.page(params[:page])
  end

  def help
  end

  def about
  end
  
  def contact
  end

end
