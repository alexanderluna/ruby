module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def toggle_text(approve)
    approve.visible? ? 'glyphicon glyphicon-check' : 'glyphicon glyphicon-unchecked'
  end

  def meta_tag(tag, text)
   content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def liked_post(micropost)
    return 'glyphicon-heart' if current_user.voted_up_for? micropost
    'glyphicon-heart-empty'
  end

  def post_link(micropost)
    if current_user.voted_up_for? micropost
      unlike_micropost_path(micropost.id)
    else
      like_micropost_path(micropost.id)
    end
  end
end
