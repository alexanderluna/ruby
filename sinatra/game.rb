require 'sinatra'

before do
  content_type :txt
  @deafeat = { rock: :scissors, paper: :rock, scissors: :paper}
  @throws = @deafeat.keys
end

get '/throw/:type' do
  player_throw = params[:type].to_sym

  if !@throws.include?(player_throw)
    halt 403, "You must throw one of the following: #{@throws}"
  end

  computer_throw = @throws.sample

  if player_throw == computer_throw
    "You tied with the computer"
  elsif computer_throw == @deafeat[player_throw]
    "Nice done, #{player_throw} defeats #{computer_throw}."
  else
    "Ouch, #{computer_throw} defeats #{player_throw}."
  end
end
