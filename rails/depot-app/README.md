# Rails Depot App

Rails comes with a development server which you can configure in: `Profile.dev`

```zsh
#  seed the database
rails db:seed

# run development server with css processor
bin/dev

# turn on caching in development
rails dev:cache
```

## Models

- Product: title, description, price, image:blob
- Cart: LineItems (has-many)
- LineItem: product (reference), cart (belongs to)

```zsh
# to test the models run
rails test:models
```

## Views

- Product
  - index: list all products

## Controllers

- Store
- Product
- Cart
- LineItem

```zsh
# to test the controllers run
rails test:controllers
```

## Installation

```zsh
# assuming you have mise installed
mise use -g ruby@3

gem install rails
```
