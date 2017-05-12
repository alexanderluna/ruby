namespace :create_statistic do
  desc "TODO"
  task read: :environment do
    user_count = User.all.count
    facebook_count = User.where(provider: "facebook").count
    twitter_count = User.where(provider: "twitter").count
    instagram_count = User.where(provider: "instagram").count
    unsubscribe_user = User.where(send_email: false).count
    unsubscribe_person = Person.where(send_email: false).count
    micropost_count = Micropost.all.count
    commment_count = Comment.all.count
    relationship_count = Relationship.all.count
    like_count = Vote.all.count
    notification_count = Notification.all.count
    statistic = Statistic.create(user_count: user_count, facebook_count: facebook_count, twitter_count: twitter_count, instagram_count: instagram_count, unsubscribe_user: unsubscribe_user, unsubscribe_person: unsubscribe_person, micropost_count: micropost_count, commment_count: commment_count, relationship_count: relationship_count, like_count: like_count, notification_count: notification_count)
    statistic.save
    p statistic
  end
end
