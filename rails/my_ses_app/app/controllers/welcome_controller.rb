class WelcomeController < ApplicationController
  def index
  end

  def send_email
    @user = User.where(send_email: true)
    NewsletterJob.perform_async(@user, params[:subject], params[:message])
    redirect_to root_url, notice: 'Email Queued'
  end

  def unsubscribe
    @user = User.find_by(email: params[:email])
    if @user
      @user.toggle!(:send_email)
      flash[:success] = "You usubscribed from our mailing list"
      redirect_to root_url
    else
      flash[:danger] = "We couldn't find you, unsubscribe in your edit page"
      redirect_to root_url
    end
  end
end
