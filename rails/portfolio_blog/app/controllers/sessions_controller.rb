class SessionsController < ApplicationController
  before_action :section_header

  def new
  end

# login user
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.valid_password?(params[:session][:password])
      log_in user
      redirect_to user
      flash[:success] = "Welcome"
    else
      flash[:danger] = "Goodbye"
      render 'new'
    end
  end

# logout user
  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
