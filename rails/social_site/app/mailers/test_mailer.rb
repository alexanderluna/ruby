class TestMailer < ApplicationMailer
  def send_test_email(email, content)
    @content = content
    mail(:to=> email, :subject=> "Test email")
  end
end
