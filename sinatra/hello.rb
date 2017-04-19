require 'sinatra'
require 'sinatra/reloader' if development?

get '/hello' do
	"Hello Sinatra"
end

get '/alexander' do
	name = "Alexander"
	"Hello #{name}"
end

get '/:name' do
	name = params[:name]
	"Hello #{name}"
end

# get '/:one/:two/:three' do
# 	first = params[:one]
# 	"First: #{first}, Second: #{params[:two]}, Third: #{params[:three]}"
# end


get '/bet/:stake/:number' do
	stake  = params[:stake].to_i
	number = params[:number].to_i
	roll = rand(6) + 1
	if roll == number
		"It landed on #{roll}, you win #{roll * stake} chips"
	else
		"It landed on #{roll}, you lose #{roll * stake} chips"
	end
end