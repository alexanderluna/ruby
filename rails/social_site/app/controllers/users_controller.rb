class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy, :show_admin]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :show_admin]
  before_action :advertisment, only: [:index, :show, :new, :create, :edit, :update, :following, :followers]
  before_action :set_s3_direct_post

  def index
    @users = User.paginate(page: params[:page], per_page: 10).order("created_at DESC")
    @micropost = current_user.microposts.build if logged_in?
  end

  def show_admin
    @facebook = User.where(provider: 'facebook').count
    @neutral = User.where(provider: nil).count
    @country = User.where.not(country: nil).count
    @unsubscribed = User.where(send_email: false).count
    @person = Person.where(send_email: false).count
    @users_banned = User.where(banned: true).paginate(page: params[:banned], per_page: 10)
    @ad = Ad.first_or_create
    @micropost = current_user.microposts.build
    @microposts_invisible = Micropost.invisible.paginate(page: params[:unapproved], per_page: 10)
    @microposts_visible = Micropost.visible.paginate(page: params[:approved], per_page: 10)
    @micropost_picture = Micropost.has_picture.paginate(page: params[:picture], per_page: 10)
    @statistic = Statistic.all
  end

  def show
    @user = User.find(params[:id])
    @micropost = current_user.microposts.build if logged_in?
    @microposts_visible = @user.microposts.visible.paginate(page: params[:approved], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Bienvenido, que Dios te bendiga"
      redirect_to feed_path
    else
      render 'new'
    end
  end

  def edit
    @micropost = current_user.microposts.build if logged_in?
  end

  def update
    if @user.update_attributes(user_params)
      # if @user.provider == 'instagram'
        # SubscribeUserToMailingListJob.perform_async(@user)
      # end
      flash[:success] = "Se guardaron tus cambios"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "Se elimino a #{user.name}"
    redirect_to users_url
  end

  def following
    @title = "yo sigo"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "a mi me siguen"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:id])
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :remote_avatar_url, :uid, :provider, :oauth_token, :oauth_expires_at, :banned)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    def admin_user
      redirect_to(root_url) unless logged_in? && current_user.admin?
    end
end
