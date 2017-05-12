Aws.config.update({
    region: ENV["S3_REGION"],
    credentials: Aws::Credentials.new(ENV["S3_ACCESS_KEY"], ENV["S3_SECRET_KEY"]),
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV["S3_BUCKET"])
