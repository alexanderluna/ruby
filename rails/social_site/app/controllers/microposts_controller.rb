class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :advertisment, only: [:show]
  before_action :setup, only: [:show, :edit, :update, :toggle_approve]
  before_action :set_s3_direct_post

  def toggle_approve
    @micropost.toggle!(:visible)
    respond_to do |format|
      format.html { render :nothing => true }
      format.js
    end
  end

  def like
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.liked_by current_user
      create_notification @micropost, "se unio"
      respond_to do |format|
        format.html { :back }
        format.js
      end
    end
  end

  def unlike
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.unliked_by current_user
      respond_to do |format|
        format.html { :back }
        format.js
      end
    end
  end

  def index
    redirect_to feed_path
  end

  def show
    if @micropost.visible?
      @comments = @micropost.comments.paginate(page: params[:page], per_page: 10)
      @comment = Comment.new
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:danger] = "Esta Oracion aun no ha sido aprobada"
      redirect_to feed_path
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Se creo tu Oracion"
      respond_to do |format|
        format.html { redirect_to feed_path}
        format.js
      end
    else
      flash[:danger] = "No se pudo crear tu Oracion"
      redirect_to feed_path
    end
  end

  def edit
  end

  def update
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Se guardaron tus cambios"
      render js: "window.location='#{micropost_path(@micropost)}'"
    else
      render 'new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Se borro tu Oracion"
    respond_to do |format|
      format.html { redirect_to request.referrer || feed_path }
      format.js
    end
  end


  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :picture, :visible)
  end

  def correct_user
    @micropost = Micropost.find_by(id: params[:id])
    unless current_user?(@micropost.user) || current_user.admin?
      redirect_to user_path(current_user)
    end
  end

  def setup
    @micropost = Micropost.find(params[:id])
  end

end
