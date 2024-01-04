# Rails

> Rails is a web-application framework that includes everything needed to create
> database-backed web applications according to the Model-View-Controller (MVC)
> pattern.

## Setup

1. [Install Ruby](../learning_ruby) directly or using a version manager.

```sh
brew install rbenv ruby-build # for mac
sudo apt install rbenv # for linux

rbenv init

# list stable ruby versions
rbenv install -l
rbenv install 3.3.0
```

2. Install Rails

```sh
gem install rails --no-document
```

3. Install extras if needed.

```sh
brew install redis
brew install postgresql

# start services
brew services start redis
brew services start postgresql
```

## The Basics

Rails automatically maps the database table name `products` to the plural of
the model class `Product`. The database configuration can be found at
`config/database.yml`.

The simplest way to generate a model, view and controller is to use the
scaffold generator which also generates a **migration** file to modify the
database.

```sh
bin/rails generate scaffold Product title:string price:decimal

bin/rails db:migrate

bin/dev
```

In order to start the server, run the the `bin/dev` command this will start
multiple processes which can be found inside the `Procfile.dev`.
