class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def valid_info user
    return if user
    render file: "public/404.html", status: :not_found, layout: false
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".please_login"
    redirect_to root_url
  end
end
