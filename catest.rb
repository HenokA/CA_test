require 'sinatra'
require 'nokogiri'
require 'open-uri'

configure do
  enable :sessions
end

get '/' do
	names = Array.new
	# Gets all of the names of schools from file
	File.open('names.txt', 'r'){ |file| 
		file.each_line do |line|
			line = line.split('|')
			names.push(line)
		end
	}
	erb :"home.html", :locals =>{:names => names}
end	

post '/home' do
	names=Hash.new
	test=Hash.new
	File.open('names.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split('|')
			names[line[0].chomp] = line[1].chomp
		end
	}
	# gets all of the tests 
	File.open('tests.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(',')
			test[line[0].chomp] = line[1].chomp
		end
	}
	# based on user selection, matches to school code
	names.each do |key, value|
		if params[:school] == value
			params[:school] = key
		end
	end
	# based on user selection, matches to test code
	test.each do |key, value|
		if params[:test] == value
			params[:test] = key
		end
	end
	# if nothing is null
	if params[:school].empty? || params[:test].empty? || params[:grade].empty?
		redirect('nopage')
	end
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
	test = Hash.new;
	mean = Array.new;
	first = Array.new;
	second = Array.new;
	third = Array.new;
	fourth = Array.new;
	fifth = Array.new;
	sixth = Array.new;
	todo = 0;
	info = Array.new;
	testname = nil
	countymean = Array.new;
	File.open('tests.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(',')
			test[line[0].chomp] = line[1].chomp
		end
	}
	test.each do |key, value|
		if params[:test] == key
			puts key
			testname = value
		end
	end
	# sf is the main file with the tests that have been parsed and cleaned
	File.open('sf.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(',')
			if (line[1] == "00000" && line[2] =="0000000" && params[:test] == 
				# gets the county means for that test
				line[12] && params[:grade] == line[11])
				countymean.push(line[16])
			end
			# if all of the users input matches something in our file
			if (params[:school] == line[2] && params[:test] == line[12] && 
				params[:grade] == line[11])
				mean.push(line[16].to_s)
				first.push(line[17].to_s)
				second.push(line[18].to_s)
				third.push(line[19].to_s)
				fourth.push(line[20].to_s)
				fifth.push(line[21].to_s)
				sixth.push(line[22].to_s)
				# if we want to scrape information from the cde website
				if todo == 0
					url = "http://www.cde.ca.gov/re/sd/details.asp?cds=" + 
							line[0].to_s + line[1].to_s + line[2].to_s+ "&Public=Y"
					data = Nokogiri::HTML(open(url))
					# grabs all of the td elements and parses to find the ones we want
					data.css("td").each_slice(2).each do |row|
						info.push(row[1].to_s[4..row.length-8])
					end
				end
			end
		end
	}
	# if there was no mean or there were not 4 of them, redirect to bad info page
	if mean.empty? || mean.length != 4
		redirect('/nopage') 
	end
	erb :"schools.html", :locals => {:testname => testname, :countymean => countymean, 
										:school => params[:school], :grade => params[:grade], 
										:test => params[:test], :mean => mean, :first => first, 
										:second => second, :third => third, :fourth => fourth,
										:fifth => fifth, :sixth => sixth, :info => info}
end

get '/nopage' do
	erb :"fail.html"
end
get '/*' do
	erb :"fail.html"
end

