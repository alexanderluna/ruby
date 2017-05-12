class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :set_s3_direct_post
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = current_user.comments.create(comment_params)
    @comment.micropost = @micropost
    @comment.user = current_user

    if @comment.save
      create_notification @micropost, "comento"
      flash[:success] = "Se creo tu Commentario"
      respond_to do |format|
        format.html { redirect_to @micropost }
        format.js
      end
    else
      flash[:danger] = "No se pudo crear tu Commentario"
      redirect_to @micropost
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Se borro tu Commentario"
    respond_to do |format|
      format.html { redirect_to request.referrer || @micropost }
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
