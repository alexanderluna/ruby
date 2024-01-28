# frozen_string_literal: true

################################################################################
# Ruby has two popular solutions for writing [Unit Tests].
#   - Minitest: a lightweight and fast approach (assertion based)
#   - RSpec: a feature rich (expectation based)
################################################################################

# Defines a Pokemon and how it attacks
class Pokemon
  attr_reader :name, :hp, :pp, :attacks

  MAX = 100
  MIN = 0

  def initialize(name:, hp:, pp:, attacks: [])
    raise "HP must be between #{MIN}-#{MAX}" if hp <= MIN || hp > MAX
    raise "PP must be between #{MIN}-#{MAX}" if pp <= MIN || pp > MAX

    @name = name
    @hp = hp
    @pp = pp
    @attacks = attacks
  end

  def to_s
    return "#{@name} has not learned an attack yet" if @attacks.empty?

    @pp -= 1
    "#{@name} #{@hp} HP uses #{@attacks.first}\nit's effective\n#{@pp} PP left"
  end
end

pikachu = Pokemon.new(name: 'Pikachu', hp: 20, pp: 10, attacks: ['donnerwelle'])
puts pikachu

################################################################################
# Now that we have our class, we can test it with Minitest. Minitest offers
# several modules to run your test the quickest way of getting started is with
# the 'minitest/autorun' module.
################################################################################

require 'minitest/autorun'

# Test that Pokemon returns expected results
class TestPokemon < Minitest::Test
  # setup runs before each test method
  def setup
    @pikachu = Pokemon.new(
      name: 'Pikachu',
      hp: 20,
      pp: 10,
      attacks: ['donnerwelle']
    )
    @world = Minitest::Mock.new # mock objects mimic behaviour from real objects
    @world.expect(:spawn, true) # world mock object should spawn
    @world.expect(:shutdown, false) # world mock object should shutdown
  end

  # teardown will run after each test method
  def teardown
    @world.shutdown
  end

  # make sure our guard statement kick in
  def test_pokemon_is_initialized_correctly
    Pokemon.new(name: 'Bisasam', hp: 20, pp: 10)

    assert_raises(RuntimeError) { Pokemon.new(name: 'Bisasam', hp: 200, pp: 5) }
    assert_raises(RuntimeError) { Pokemon.new(name: 'Bisasam', hp: 5, pp: -10) }
  end

  # each test method MUST start with 'test' or 'assert'
  def test_basic_attack
    message = "Pikachu 20 HP uses donnerwelle\nit's effective\n9 PP left"
    assert_equal message, @pikachu.to_s
  end
end

################################################################################
# In a real world application you would split your code into their directories:
#   - app/lib: production code
#   - app/test: all tests for production code
# In the test direcotry you will want to add a test_suite.rb file where you
# require all your test files. That way you can run all your tests by running
# just one file: ruby -I lib test/test_suite.rb
################################################################################

################################################################################
# RSpec is a feature rich testing tool that focuses more on Behavior Driven
# Development BDD. Therefore, the vocabulary is different to Minitest. Before
# we can write our tests we have to:
#   - install rspec: gem install rspec
#   - create a spec file: touch pokemon_spec.rb
#   - run our specs: rspec pokemon_spec.rb
################################################################################

Rspec.describe 'Pokemon' do
  describe 'pokemon initialization' do
    # works just like setup in Minitest
    before(:example) do
      @bisasam = Pokemon.new(name: 'Bisasam', hp: 20, pp: 10)
      @world = double # create a mock by creating a test double
      allow(@world).to receive(:spawn).and_return('creating the world...')
    end

    it 'allow a pokemons without attacks' do
      expect(@bisasam.attacks).to eq([])
    end

    it 'does not allow pokemons with too many hit points' do
      expect(Pokemon.new(name: 'Bisasam', hp: 200, pp: 5)).to raise_error(RuntimeError)
    end
  end

  describe 'pokemon attack' do
    it 'outputs a message with the attack' do
      @pikachu = Pokemon.new(
        name: 'Pikachu',
        hp: 20,
        pp: 10,
        attacks: ['donnerwelle']
      )
      message = "Pikachu 20 HP uses donnerwelle\nit's effective\n9 PP left"
      expect(message).to eq(@pikachu.to_s)
    end
  end
end
