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

get '/leaderboard' do
	erb :"leaderboard.html"
end

