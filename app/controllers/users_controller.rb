class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show, :destroy]
  before_action :load_user, except: [:create, :new, :index]

  def index
    @users = User.where(activated: true).select(:id, :name, :email, :is_admin)
      .order(:id).paginate page: params[:page], per_page: Settings.user.users_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to @user
    else
      flash.now[:danger] = t ".error_signup"
      render :new
    end
  end

  def show
    @microposts = @user.microposts.select(:id, :content, :picture, :user_id,
      :created_at).sort_by_created_at.paginate page: params[:page],
      per_page: Settings.micropost.microposts_per_page
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

  def following
    @title = t ".following"
    @user = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.user.users_per_page
    render :show_follow
  end

  def followers
    @title = t ".followers"
    @user = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.user.users_per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    
    valid_info @user
  end
end
