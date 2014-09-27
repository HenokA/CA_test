require 'sinatra'

configure do
  enable :sessions
end

get '/' do
	erb :"index.html"
end	

get '/home' do
	erb :"home.html"
end

# post '/home' do
#   session['state'] = params[:state]
#   session['city'] = params[:city]
#   session['b1'] = params[:button1]

#   redirect '/schools'
# end

get '/about' do
	erb :"about.html"
end

get '/schools' do
	location = session['state'].to_s
	puts "jajkalksdfjlaksjdflkajsdlkfjalskjflaskjdf" + session['b1'].to_s
	erb :"schools.html", :locals => {:location => location}
end

