class NotificationMailer < ApplicationMailer
  def send_notification(options={})
    @notification = options[:notification]
    @subject = options[:subject]
    mail(:to=> @notification.user.email, :subject=> @subject)
  end
end
