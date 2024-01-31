# Learning Ruby

## Overview

1. [Installing Ruby](#installing-ruby)
2. [Introduction](./introduction.rb)
3. [Classes and Objects](./classes_objects.rb)
4. [Methods](./methods.rb)
5. [Inheritance, Modules and Mixins](./inheritance_modules_mixins.rb)
6. [Regular Expressions](./regular_expressions.rb)
7. [Exceptions](./exceptions.rb)
8. [Input and Output](./input_output.rb)
9. [Concurrency](./concurrency.rb)
10. [Unit Testing](./unit_testing.rb)
11. [Ruby Gems](#ruby-gems)

## Installing Ruby

1. In order to install Ruby, preferably use a ruby version manager like `rvm` or
`rbenv`.

    ```sh
    brew install rbenv ruby-build
    sudo apt install rbenv
    ```

2. Then run this command and follow the instructions.

    ```sh
    rbenv init
    ```

3. Now you can install a version. Preferably the latest stable version.

    ```sh
    # list stable ruby versions
    rbenv install -l

    rbenv install 3.3.0
    ```

4. If you can run these commands successfully you are all set.

    ```sh
    (master*) ruby                                                           
    puts "hello"
    hello
    ```

    ```sh
    (master*) irb
    irb(main):001> 
    ```

### Ruby and the Command Line

You can run your scripts calling ruby with options directly from the command
line interface.

```sh
ruby [options] [ruby-file] [arguments]
ruby -e "puts (1..5).map(&:succ)"
```

If you want to run your ruby script like standalone programs you can make them
executables but adding a shebang and changing the mode of the file.

> Ruby will load libraries and gems based on your `$LOAD_PATH`. If you want Ruby
> to find your scripts, add it to this path.

```ruby
#!/usr/bin/env ruby

# add this at the top of your ruby file
```

```sh
chmod +x rubyscript.rb
```

Within your code you can access Environment variables via the `ENV` class which
works like a hash.

```ruby
ENV["USER"] # alexander
ENV.keys    # all the available keys
```

### Rake Build Tool

A nice way of adding CLI utility to your programs is by using `rake`. `rake` is
a build tool that is commonly used as a utility tool to run code from the CLI.

1. Create a `Rakefile`

    ```sh
    touch Rakefile
    ```

2. Create a task in your `Rakefile`

    ```ruby
    desc "Remove files whose names end with a tilde"
    task :delete_logs do
        files = Dir["*.log"]
        rm(files, verbose: true) unless files.empty?
    end
    ```

3. Invoke your task

    ```sh
    rake -T                 # list all available tasks
    rake delete_logs
    ```

## Ruby Gems

Ruby has an ecosystem of tools called [Gems](rubygems.org). A Gem is a library
as well as a packing structure to write Ruby programs. You can download, modify,
create and share gems.

- `gem`: Command-Line tool for installing and managing gems

    ```sh
    gem search -ed rails    # -e: exact, -d: details
    gem install rails
    ```

- `bundler`: keeps track of dependencies and versions required for the gem

    ```sh
    gem install bundler
    bundle init             # generate Gemfile which lists all dependencies
    bundle install          # installs all listed dependencies

    bundle exec COMMAND     # executes command with gem from the Gemfile
    bundle binstubs GEM     # generate a bin/GEM file to execute Gemfile gem

    bundle update           # upgrades all gems in the Gemfile to latest version
    ```

In you `Gemfile` you add all the gems you need for your program together with
the version. You can use version specifiers to tell bundler which up to which
version it should upgrade the gem.

```Gemfile
gem rails '7.1.3.2'         # exact version only
rails '~> 7.1'              # all minor upgrades to 7.1: 7.1.3, 7.1.6, etc.

group :development do       # ignored in production
    gem 'standardrb'
    gem 'debug'
end
```

You can create your own gem with the `bundle gem NAME` command. It generates a
folder structure for you which makes it easier to develop your own gems.

> It is a Ruby convention that each file should have one top level Module/Class
> and the name of the class is based on the name of the file.

```ruby
# lib/Gemname/player.rb
module Gemname
    class Player
        def move; end
    end
end
```

```sh
NAME
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── Gemfile                 # all dependencies for your gem
├── LICENSE.txt
├── README.md
├── Rakefile
├── bin                     # setup scripts
│   ├── console
│   └── setup
├── lib                     # you code goes here
│   ├── NAME
│   │   └── version.rb
│   └── NAME.rb
├── NAME.gemspec            # metadata about your gem
├── sig                     # ruby type info goes here
│   └── NAME.rbs
└── test                    # all your tests for you code
    ├── test_helper.rb
    └── test_NAME.rb
```

## Resources

- [Programming Ruby 3.2](https://pragprog.com/titles/ruby5/programming-ruby-3-3-5th-edition/)
