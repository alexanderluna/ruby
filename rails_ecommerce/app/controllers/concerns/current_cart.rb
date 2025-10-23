# CurrentCart is a module which is shared among controllers.
module CurrentCart
  # private prevents rails from making it available as an action.
  private

  # set_cart sets the current cart by getting the card_id from the session.
  # if no card_id is found, it creates a new cart and sets the session cart.
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
