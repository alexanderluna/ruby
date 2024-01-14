# frozen_string_literal: true

###############################################################################
# [Regular Epressions] are patterns which you can test against a string. You
# use this in Ruby to:
#   - match a string
#   - extract a section from a string
#   - replace a section from a string
###############################################################################

pokemons = 'Bisasam, Glumanda, Schiggy, Pikachu'

/Pikachu/ =~ pokemons               # returns index of first match
/Pikachu/ !~ pokemons               # returns false when matched
/Pikachu/.match(pokemons)           # returns MatchData object
/Pikachu/.match?(pokemons)          # returns boolean when matched

Regexp.new(/Pikachu/) =~ pokemons
%r{Pikachu} =~ pokemons
/Pikachu/ =~ pokemons               # 28

/Pikachu/.match?(pokemons)          # true
pokemons.match?(/Shillok/)          # false

/pikachu/i =~ pokemons              # case-insensitive match
%r{
(\w.*),                             # name followed by a comma
\s                                  # a space
}x =~ pokemons                      # multiline regex mode

###############################################################################
# Calling match without the question mark returns a handy MatchData object
###############################################################################

match_data = pokemons.match(/Schiggy/)
match_data                          # <MatchData "Schiggy">
match_data[0]                       # Schiggy
match_data.pre_match                # "Bisasam, Glumanda, "
match_data.post_match               # ", Pikachu"

###############################################################################
# To replace a section from a string using regex you can use the [sub] and
# [gsub] methods. [sub] only replaces the first match it finds while [gsub]
# will replace all matches. Both methods accept blocks as parameters.
###############################################################################

pokemons.sub(/Glumanda/, 'Glutexo')
pokemons.gsub(/,/, ' *')

pokemons.gsub(/\w/) { |word| word.upcase } # BISASAM, GLUMANDA, SCHIGGY, PIKACHU
pokemons.gsub(/\w/, &:upcase)

###############################################################################
# In regex it is possible to group terms with parentheses. Each group becomes a
# match which is accesible via the MatchData object or through global variables
###############################################################################

/(\w+), (\w+)/ =~ pokemons          # matches Bisasam and Glumanda
puts "#{$1} attacks #{$2}"          # Bisasam attacks Glumanda

pokemon = pokemons.match(/(\w+), (\w+)/)
puts "#{pokemon[1]} attacks #{pokemon[2]}" # Bisasam attacks Glumanda
