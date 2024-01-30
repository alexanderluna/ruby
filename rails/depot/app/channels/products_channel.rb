# frozen_string_literal: true

# websocket connection for product
class ProductsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'products'
  end

  def unsubscribed; end
end
