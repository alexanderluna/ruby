class User < ApplicationRecord
  has_many :sections
  has_many :posts
end
