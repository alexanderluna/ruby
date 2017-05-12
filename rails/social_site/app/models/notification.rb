class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribed_user, class_name: 'User'
  belongs_to :micropost

  after_create :notify

  def notify
    begin
      if self.user.notify? && self.user.send_email?
        NotificationMailer.send_notification(subject: "Tienes una respuesta a tu oracion", notification: self).deliver
      end
    rescue Net::OpenTimeout, Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      Rails.logger.error e.message
    end
  end
end
