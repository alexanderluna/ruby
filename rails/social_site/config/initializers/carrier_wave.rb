CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp') # adding these...
  config.cache_dir = 'carrierwave' # ...two lines
  config.storage = :fog
  config.permissions = 0666
  config.fog_credentials = {
    # Configuration for Amazon S3
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
    :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
    :region                 => ENV['S3_REGION']
  }

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory     =  ENV['S3_BUCKET']
end
