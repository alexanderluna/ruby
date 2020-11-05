class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @page_title = "Moon's Store"
    @products = Product.order(:title)
  end
end
