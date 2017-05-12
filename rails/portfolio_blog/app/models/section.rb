class Section < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :posts

  def to_param
    "#{id}-#{name}"
  end
end
