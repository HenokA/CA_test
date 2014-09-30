require 'nokogiri'
require 'open-uri'
# I am hosting interesting.html on a local server.  This is the URL.
	info = Array.new;
	ids = Array.new;

File.open('names.txt','w'){ |file1|
	File.open('sf.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(',')
			if ( "00000" != line[1].to_s && "0000000"!= line[2].to_s && !(ids.include? line[2]))
				ids.push(line[2])
				url = "http://www.cde.ca.gov/re/sd/details.asp?cds=" + line[0].to_s + line[1].to_s + line[2].to_s+ "&Public=Y"
				data = Nokogiri::HTML(open(url))
				data.css("td").each_slice(2).each do |row|
					info.push(row[1].to_s[4..row.length-8])
				end
				if !info.empty?
					file1.write(line[2].to_s+","+info[2].to_s+"\n")
					puts line[2].to_s+","+info[2].to_s+"\n"
				end
			end
			info.clear
		end
	}
}
