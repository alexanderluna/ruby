class Post < ApplicationRecord
  belongs_to :section, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
