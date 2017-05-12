class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Porfavor Inicie Session"
        redirect_to login_url
      end
    end

    def advertisment
      @ad = Ad.first
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read-write')
    end

    def create_notification(micropost, notice_type)
    return if micropost.user.id == current_user.id
    Notification.create(user_id: micropost.user.id,
                        subscribed_user_id: current_user.id,
                        micropost_id: micropost.id,
                        notice_type: notice_type)
    end
end
