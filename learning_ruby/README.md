# Learning Ruby

## Installing Ruby

1. In order to install Ruby, preferably use a ruby version manager like `rvm` or
`rbenv`.

```sh
brew install rbenv ruby-build
sudo apt install rbenv
```

2. Then run this command a follow the instructions.

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

## Overview

  1. [Introduction](./introduction.rb)
  2. [Classes and Objects](./class_objects.rb)

## Variables

```ruby
# declare a variable
my_variable = 'hello world'

# declare a constant
MY_NAME = 'Alexander'
```

## Control Statements

### if/else

```ruby
if over_21
  puts 'You can enter
else
  puts 'You have to go'
end
```

### while and until

```ruby
while not game_over
  puts 'Another round'
  make_move()
end

until game_over
  puts 'Another round'
  make_move()
end
```

### for

```ruby
for name in names
  puts name
end
```

### case/when

```ruby
age = 12
case age
when 13 then puts 'You are older than 12'
when 11 then puts 'You are younger than 12'
else puts 'You are 12'
end
```

## Arrays and Hashes

```ruby
# an array
names = ['Alexander', 'Jim', 'John']

# a hash
alexander = {name: 'Alexander', birthplace: 'Germany'}
```

## Methods

```ruby
# without arguments

def print_time
  print Time.new
end

# with arguments
def print_name(name)
  print MY_NAME
end
```

## Classes

```ruby
class Person
  attr_accessor :name, :job

  def initialize(name, job)
    @name = name
    @job = job
  end

  def contact_info
    print "#{@name} is a #{@job}"
  end
end
```

## Inheritance

```ruby
class Student < Person
  attr_accessor :books, :grades
end
```