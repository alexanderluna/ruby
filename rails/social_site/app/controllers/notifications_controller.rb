class NotificationsController < ApplicationController

  def index
    @notification = current_user.notifications.all
  end

  def destroy
    @notification = Notification.find(params[:id]).destroy
    respond_to do |format|
      format.html { render :index, notice: 'Se borro la notificacion' }
      format.js
    end
  end
end
