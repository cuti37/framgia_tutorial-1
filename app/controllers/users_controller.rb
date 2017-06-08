class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :load_user, except: [:create, :new, :index]

  def index
    @users = User.select(:id, :name, :email, :is_admin).order(:id)
      .paginate page: params[:page], per_page: Settings.user.users_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".success_signup"
      redirect_to @user
    else
      flash.now[:danger] = t ".error_signup"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      flash.now[:danger] = t ".error_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted_user"
      redirect_to users_url
    else
      flash.now[:alert] = t ".delete_failed"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    render file: "public/404.html", status: :not_found, layout: false
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t ".please_login"
      redirect_to root_path
    end
  end
end
