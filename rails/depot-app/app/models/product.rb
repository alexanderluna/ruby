class Product < ApplicationRecord
  has_one_attached :image

  # update after saving in real time
  after_commit -> { broadcast_refresh_later_to "products" }
end
