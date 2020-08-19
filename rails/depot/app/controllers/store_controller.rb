class StoreController < ApplicationController
  def index
    @page_title = "Moon's Store"
    @products = Product.order(:title)
  end
end
