require 'nokogiri'
require 'open-uri'
# I am hosting interesting.html on a local server.  This is the URL.
url = "http://www.cde.ca.gov/re/sd/details.asp?cds=38103893830445&Public=Y"
 
# Here we load the URL into Nokogiri for parsing downloading the page in
# the process
data = Nokogiri::HTML(open(url))
 
# We can now target data in the page using css selectors.  The at_css method
# returns the first element that matches the selector.
counter = 2;
data.css("td").each_slice(2).each do |row|
	if counter % 2 == 0
		puts row[1].to_s[4..row.length-8]
		puts "\n"
	end
	# counter +=1
end
 
