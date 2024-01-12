# Depository Application

An online store with a depository system.

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
