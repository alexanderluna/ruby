class NewsletterJob < ApplicationJob
  include SuckerPunch::Job

  def perform(user, subject, message)
    user.each do |u|
      MyMailer.send_email(subject: subject, user: u, message: message).deliver
      sleep 0.08
    end
  end
end
