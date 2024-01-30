# frozen_string_literal: true

# Root Controller of the App
class StoreController < ApplicationController
  include CurrentCart

  before_action :set_cart

  def index
    @products = Product.order(:title)
  end
end
