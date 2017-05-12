class Micropost < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  default_scope -> { order(created_at: :desc)}

  # mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true
  validate :picture_size

  before_create :make_visible
  before_create :set_title
  before_destroy :delete_s3_image

  def picture_size
    if picture
      #limit picture size
      if picture.size > 10.megabytes
        errors.add(:picture, "La imagen debe ser menor a 10MB")
      end
    else
      #randomly select image out of 3 options
      options = [
        'https://s3-us-west-2.amazonaws.com/hyouka/static_files/bible.jpg',
        'https://s3-us-west-2.amazonaws.com/hyouka/static_files/christmas.jpg',
        'https://s3-us-west-2.amazonaws.com/hyouka/static_files/prayer.jpg'
      ]
      self.picture = options[Random.rand(3)]
    end
  end

  def self.has_picture
    options = [
      'https://s3-us-west-2.amazonaws.com/hyouka/static_files/bible.jpg',
      'https://s3-us-west-2.amazonaws.com/hyouka/static_files/christmas.jpg',
      'https://s3-us-west-2.amazonaws.com/hyouka/static_files/prayer.jpg'
    ]
    Micropost.where.not(picture: options)
  end

  def Micropost.visible
    Micropost.where('visible = ?', true)
  end

  def Micropost.invisible
    Micropost.where('visible = ?', false)
  end

  def make_visible
    self.visible = true
  end

  def delete_s3_image
    key = self.picture.split('amazonaws.com/')[1]
    begin
    S3_BUCKET.object(key).delete
    rescue => e
      Rails.logger.error e.message
    end
  end

  def set_title
    title = self.title
    post = self.content.split(/[\s,';.]/)
    title << post[0..6].join(" ")
  end

end
