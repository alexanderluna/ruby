class User < ApplicationRecord

  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token
  attr_accessor :skip_validation

  before_save :downcase_email, :unless => :skip_validation

  validates :name, presence: true
  validates :email, presence: true

  # has_secure_password

  def downcase_email
    self.email = email.downcase
  end
end
