# Depository Application

An online store with a depository system.

1. [Installation and Setup](#installation-and-setup)
2. [Internationalization](#i18n)
3. [Rails CLI Commands](#rails-cli-commands)
4. [Hotwire](#hotwire)
5. [Action Cable](#action-cable)

## Installation and Setup

```bash
git clone project.git
cd project

bundle install
```

## I18n

Rails provides build in helper functions such which accept a locale option to change the currency.

```ruby
number_to_currency(product.price, locale: :de)
```

For this to work you have to create a file for the locale you want to support in
`config/locales`. In this example `de.yml` and you have to specify how you want
rails to render other locales.

```yml
de:
   number:
    currency:
      format:
        delimiter: "."
        format: "%n %u"
        precision: 2
        separator: ","
        significant: false
        strip_insignificant_zeros: false
        unit: "€"
```

## Rails CLI commands

```sh
bin/dev                                 # runs Procfile.dev

bin/rails dev:cache                     # enable/disable caching

rake tailwindcss:build                  # builds tailwind styles
rake assets:precompile                  # compiles images, css, js ...
rails assets:clean                      # remove old compiled assets
```

## Hotwire

Hotwire is a collection of web frameworks which enables you to build and send
HTML fragement over the wire similar to how you would send JSON. The advantage
of sending prebuild HTML fragments is that the browser doesn't have to do the
heavy lifting and you get instantaneous results similar to single paged apps.

- Turbo: write code in the browser to interact with our server

> Rails includes all Hotwire frameworks by default which means you won't have
> to add them manually.

## Action Cable

Since Rails 5, Rails comes with Action Cable which implements websockets and
allows you to broadcast and receive messages.

1. Create a channel

    ```sh
    bin/rails generate channel ENTITY
    ```

2. Create a stream in your channel. For simplicity the entity and channel name should be the same.

    ```ruby
    class ENTITYChannel < ApplicationCable::Channel
      def subscribed
        stream_from "entity_channel"
      end
    end
    ```

3. Broadcast the HTML

    ```ruby
    def update
      ...
      @entity.broadcast_replace_later_to 'entity_channel', partial: 'template'
    end
    ```

4. Receive the HTML broadcasted

    ```erb
    <%= turbo_stream_from 'entity_channel' %>
    <%= turbo_frame_tag(dom_id(ENTITY)) do %>
    # display your entity
    <% end %>
    ```
