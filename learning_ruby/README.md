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

## Resources

- [Programming Ruby 3.2](https://pragprog.com/titles/ruby5/programming-ruby-3-3-5th-edition/)
