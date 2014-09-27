require 'sinatra'

configure do
  enable :sessions
end

get '/' do
	erb :"index.html"
end	

get '/about' do
	erb :"about.html"
end

get '/schools' do
	erb :"schools.html"
end

