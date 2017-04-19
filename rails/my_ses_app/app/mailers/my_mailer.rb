class MyMailer < ApplicationMailer
  def send_email(options={})
    @user = options[:user]
    @message = options[:message]
    @subject = options[:subject]
    mail(:to=> @user.email, :subject=> @subject)
  end
end
