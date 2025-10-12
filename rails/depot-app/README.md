# Rails Depot App

Rails comes with a development server which you can configure in: `Profile.dev`

```zsh
#  seed the database
rails db:seed

# run development server with css processor
bin/dev

# turn on caching in development
rails dev:cache

# generate & run migrations
rails g migration your_migration_name
rails db:migrate
rails db:migrate:status
```

## Installation

```zsh
# assuming you have mise installed
mise use -g ruby@3

gem install rails
```

## Models

- Product: title, description, price, image:blob
- Cart: LineItems (has-many)
- LineItem: product (reference), cart (belongs to), quantity

```zsh
# to test the models run
rails test:models
```

## Views

- Product
  - index: list all products

We can integrate Hotwire in our app by making use of turbo streams in our
controller. Inside the controller, either respond with partial or create a
template. In both cases, the HTML has to have a unique ID element.

```ruby
# respond directly with a partial
def create
  respond_to do |format|
    if @line_item.save
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(:cart, partial: 'layouts/cart', locals: { cart: @cart })
      end
    end
  end
end
```

```ruby
# respond with a template assumes a 'controller#action' template exists
def create
  respond_to do |format|
    if @line_item.save
      format.turbo_stream
  end
end
```

```ruby
# 'controller#action' template
<%= turbo_stream.replace 'notice' do %>
  <%= render partial: 'store/notice' %>
<% end %>
<%= turbo_stream.replace 'cart' do %>
  <%= render partial: 'layouts/cart', locals: { cart: @cart } %>
<% end %>
```

## Controllers

- Store
- Product
- Cart
- LineItem

```zsh
# to test the controllers run
rails test:controllers
```

## Action Cable

Action Cable combines a Javascript client-side framework with a server-side Ruby framework to implement the WebSockets protocol. In order to use Action Cable follow three steps:

1. Create a channel for your entity

    ```zsh
    rails generate channel products
    ```

    ```ruby
    # Channel encapsulates work similar to a Controller
    class ProductsChannel < ApplicationCable::Channel
      # called when a consumer subscribes to a Channel
      def subscribed
      # subscribe to a broadcasting named "store/products"
        stream_from "store/products"
      end

      def unsubscribed
        # Any cleanup needed when channel is unsubscribed
      end
    end
    ```

    ```ruby
    # in development environment: config/environments/development.rb
    config.action_cable.disable_request_forgery_protection= true
    ```

2. Broadcast data

    ```ruby
    # ProductsController
    def update
      respond_to do |format|
        if @product.update(product_params)
          # broadcast async the HTML for a product every time it is updated
          @product.broadcast_replace_later_to "store/products", partial: "store/product"
        end
      end
    end
    ```

3. Receive data

    ```html
    <!-- identify to which channel we subscribe to -->
    <%= turbo_stream_from 'products' %>

    <!-- this tag generates both an ID and HTML to handle streams -->
    <%= turbo_frame_tag(dom_id(product)) do %>
      <!-- our product data goes here -->
    <% end %>
    ```
