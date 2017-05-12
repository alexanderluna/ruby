class SessionsController < ApplicationController
  before_action :advertisment, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password].downcase)
      log_in user
      redirect_to feed_path
      flash[:success] = "Bienvenido, que tengas un bendecido dia"
    else
      flash[:danger] = "Correo Electronico o Contraseña incorrecto"
      render 'new'
    end
  end

  def create_facebook
    facebook_user = User.from_omniauth(env["omniauth.auth"])
    if facebook_user
      log_in facebook_user
      flash[:success] = "Bienvenido, que tengas un bendecido dia"
      redirect_to feed_path
    else
      flash[:danger] = "No se pudo crear tu cuenta, porfavor rellena el formulario"
      redirect_to signup_path
    end
  end

  def create_instagram
    user = User.from_omniauth_instagram(env["omniauth.auth"])
    if user
      log_in user
      if user.email?
        flash[:success] = "Bienvenido que Dios te bendiga"
        redirect_to feed_path
      else
        flash[:success] = "Añade tu Correo Electronico"
        redirect_to edit_user_path(user)
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
