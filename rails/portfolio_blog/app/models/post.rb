class Post < ApplicationRecord
  belongs_to :section, dependent: :destroy
  belongs_to :user, dependent: :destroy

  default_scope -> { order(created_at: :desc)}

  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true

end
