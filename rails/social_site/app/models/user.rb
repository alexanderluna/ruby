class User < ActiveRecord::Base

  acts_as_voter
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships,   class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :passive_relationships,  class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :notifications, dependent: :destroy

# Subscribe user to Mailchimp mailing list
  # after_create :subscribe_to_mailing_list, :unless => :skip_validation

  attr_accessor :remember_token, :activation_token, :reset_token
  attr_accessor :skip_validation


  mount_uploader :avatar, AvatarUploader

  before_save :downcase_email, :unless => :skip_validation

  validates :name, presence: true

  VALID_EMAIL_ADDRESS = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255},
            format: { with: VALID_EMAIL_ADDRESS},
            uniqueness: { case_sensitive: false}

  validates :password,
            presence: true,
            length: {minimum: 6},
            allow_nil: true

  validate :avatar_size

  has_secure_password


# Method Declarations
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "debe ser menor a 5MB")
    end
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_send_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_send_at < 2.hours.ago
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  #Facebook login
  def self.from_omniauth(auth)
    unless auth.info.email
      return
    end
    user = find_or_initialize_by(email: auth.info.email)
  # where(email: auth.info.email).first_or_initialize.tap do |user|
    user.name = auth.info.name
    user.email = auth.info.email
    user.password = auth.uid
    user.password_confirmation = auth.uid
    user.remote_avatar_url = auth.info.image
    user.uid = auth.uid
    user.gender = auth.extra.raw_info.gender
    user.country = auth.extra.raw_info.locale.split('_')[1] if auth.extra.raw_info.locale
    user.language = auth.extra.raw_info.locale.split('_')[0] if auth.extra.raw_info.locale
    user.provider = auth.provider
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.provider == "facebook"
    user.save!
    user
  end

  def self.from_omniauth_instagram(auth)
    where(uid: auth.uid).where(provider: auth.provider).first_or_initialize.tap do |user|
      user.name = auth.info.name
      user.password = auth.uid
      user.password_confirmation = auth.uid
      user.remote_avatar_url = auth.info.image
      user.uid = auth.uid
      user.provider = auth.provider
      user.oauth_token = auth.credentials.token
      user.skip_validation = true
      user.save!(:validate => false)
    end
  end


  def downcase_email
    self.email = email.downcase
  end

  #Mailchimp
  # def subscribe_to_mailing_list
  #   SubscribeUserToMailingListJob.perform_async(self)
  # end

  #following actions
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
