namespace :destroy_old_posts do
  desc "TODO"
  task clean_up_posts: :environment do
    Micropost.where("created_at <= ?", Time.now - 3.months).each do |post|
      post.destroy
    end
  end
end
