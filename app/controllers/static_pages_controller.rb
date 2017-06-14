class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
    @feed_items = current_user.feed.select(:id, :content, :picture, :user_id,
      :created_at).sort_by_created_at.paginate page: params[:page],
      per_page: Settings.micropost.microposts_per_page
  end

  def help
  end

  def about
  end

  def contact
  end
end
