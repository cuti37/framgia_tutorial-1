class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      if user.activated?
        flash[:success] = t ".welcome_back"
        log_in user
        "1" == params[:session][:remember_me] ? remember(user) : forget(user)
        redirect_to user
      else
        flash[:warning] = t ".invalid_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".error_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
