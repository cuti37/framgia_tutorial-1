class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def valid_info user
    return if user
    render file: "public/404.html", status: :not_found, layout: false
  end
end
