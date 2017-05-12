class SendNewsletterJob < ActiveJob::Base
  include SuckerPunch::Job

  def perform(user, subject, message)
    user.each do |u|
      begin
      MyMailer.send_email(subject: subject, user: u, message: message).deliver
      rescue Net::OpenTimeout, Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        Rails.logger.error e.message
      end
      sleep 0.02
    end
  end
end
