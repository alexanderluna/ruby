class Entry < ApplicationRecord

  belongs_to :user

  validates :title, :content, :date, :user_id, presence: true
  validates :date, uniqueness: { message: 'you cant create more than one entry per day'}
  scope :current_month, lambda {
    where(
      'created_at > ? AND created_at < ?',
      Time.now.beginning_of_month,
      Time.now.end_of_month
    ) 
  }

end
