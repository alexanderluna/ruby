class Section < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :posts

  default_scope -> { order(order: :asc)}

  validates :name, presence: true
  validates :order, presence: true

  def to_param
    "#{id}-#{name}"
  end
end
