class StaticPagesController < ApplicationController

  before_action :logged_in_user, only: [:feature, :send_email]
  before_action :setup, only: [:home, :feed, :feature]
  before_action :set_s3_direct_post

  def home
  end

  def resource_material
    @articles = {}
    @youtube = HTTParty.get('https://www.googleapis.com/youtube/v3/search?order=viewCount&part=snippet&channelId=UCEi-GZBw0qt9R5G1s-6PqKA&maxResults=25&key=AIzaSyAYr_QpJiP8Im_1TQUYdMl0WQ8ds68R4RM')
    html = HTTParty.get('http://www.institutobiblicohosanna.com/')
    html_doc = Nokogiri::HTML(html)
    (0..9).each {|n| @articles[n] = []}
    links, title, img, desc = [], [], [], []
    html_doc.xpath("//main//article//div//h2//a").each  { |t| links.push(t["href"]); title.push(t.text)}
    html_doc.xpath("//main//article//img").each {|i| img.push(i["src"])}
    html_doc.xpath("//main//article//div//p").each {|para| desc.push(para.text)}
    @articles.each {|k,v| v.push(links[k], title[k], img[k], desc[k])}
  end

  def privacy
    render 'privacy'
  end

  def feed
    @microposts = Micropost.visible.paginate(page: params[:page], per_page: 4).includes(:user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def feature
    @follow_feed = current_user.feed.visible.paginate(page: params[:page], per_page: 4)
  end

  def send_email
    if params[:provider] == "nil"
      @users_email = User.where(send_email: true).where(provider: nil)
      SendNewsletterJob.perform_async(@users_email, params[:subject], params[:message])
    elsif params[:provider] == "all"
      @users_email = User.where(send_email: true).where.not(email: nil)
      SendNewsletterJob.perform_async(@users_email, params[:subject], params[:message])
    elsif params[:provider] == "single"
      @users_email = User.find_by(email: params[:email])
      MyMailer.send_email(subject: params[:subject], user: @users_email, message: params[:message]).deliver
    elsif params[:provider] == "test_email"
      TestMailer.send_test_email(params[:email], params[:content]).deliver
    elsif params[:provider] == "cristianobook"
      @users_email = Person.where(send_email: true).limit(5000).offset(params[:start].to_i)
      SendNewsletterJob.perform_async(@users_email, params[:subject], params[:message])
    else
      @users_email = User.where(send_email: true).where(provider: params[:provider])
      SendNewsletterJob.perform_async(@users_email, params[:subject], params[:message])
    end
    redirect_to show_admin_path, notice: 'Email in queue'
  end

  def unsubscribe
    if params[:class] == "Person"
      @user = Person.find_by(email: params[:email])
    else
      @user = User.find_by(email: params[:email])
    end
    if @user
      @user.send_email = false
      @user.save
      flash[:success] = "Te saliste de nuestra lista de correos"
      redirect_to feed_path
    else
      flash[:danger] = "Edita tu perfil para dejar de recibir mensajes"
      redirect_to feed_path
    end
  end

  def unsubscribe_notify
    @user = User.find_by(email: params[:email])
    if @user
      @user.toggle!(:notify)
      flash[:success] = "Ya no vas a recibir notificaiones de correo"
      redirect_to feed_path
    else
      flash[:danger] = "Edita tu perfil para dejar de recibir correos"
      redirect_to feed_path
    end
  end

  def subscribe
    @user = User.find_by(email: params[:email])
    if @user
      flash[:success] = "Formas parte de nuestra lista"
      @user.send_email = true
      @user.save
      redirect_to feed_path
    else
      flash[:danger] = "No pudimos encontrar tu correo, edita tu perfil para formar parte the nuestra lista"
      redirect_to feed_path
    end
  end


  private
    def setup
      @ad = Ad.first
      @micropost = current_user.microposts.build if logged_in?
    end
end
