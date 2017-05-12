OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], secure_image_url: true, :info_fields => "name, email, locale, gender" 
  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET'], secure_image_url: true
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], secure_image_url: true
end
