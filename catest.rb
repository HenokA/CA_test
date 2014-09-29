require 'sinatra'

configure do
  enable :sessions
end

get '/' do
	erb :"home.html"
end	

post '/home' do
  session['school'] = params[:school]
  session['test'] = params[:test]
  session['grade']= params[:grade]
  session['b1'] = params[:button1]
  redirect('/schools/'+params[:school]+"/"+params[:grade]+"/"+params[:test]);
end

get '/about' do
	erb :"about.html"
end

get '/schools/:school/:grade/:test' do
	mean = Array.new;
	first = Array.new;
	second = Array.new;
	third = Array.new;
	fourth = Array.new;
	fifth = Array.new;
	sixth = Array.new;
	  File.open('sf.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(',')
			if (params[:school] == line[2] && params[:test] == line[12] && params[:grade] == line[11])
				mean.push(line[16].to_s)
				first.push(line[17].to_s)
				second.push(line[18].to_s)
				third.push(line[19].to_s)
				fourth.push(line[20].to_s)
				fifth.push(line[21].to_s)
				sixth.push(line[22].to_s)
			end
		end
	}
	if mean.empty?
		redirect('/nopage')
	end
	erb :"schools.html", :locals => {:school => params[:school], :grade => params[:grade], :test => params[:test], :mean => mean, :first => first, :second => second, :third => third, :fourth => fourth,
										:fifth => fifth, :sixth => sixth}
end

get '/nopage' do
	erb :"fail.html"
end

