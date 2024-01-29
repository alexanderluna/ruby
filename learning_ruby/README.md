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

## Resources

- [Programming Ruby 3.2](https://pragprog.com/titles/ruby5/programming-ruby-3-3-5th-edition/)
