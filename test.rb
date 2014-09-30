require 'nokogiri'
require 'open-uri'
# I am hosting interesting.html on a local server.  This is the URL.
	info = Array.new;
	ids = Array.new;

# File.open('names.txt','w'){ |file1|
# 	File.open('sf.txt', 'r'){ |file|
# 		file.each_line do |line|
# 			line = line.split(',')
# 			if ( "00000" != line[1].to_s && "0000000"!= line[2].to_s && !(ids.include? line[2]))
# 				ids.push(line[2])
# 				url = "http://www.cde.ca.gov/re/sd/details.asp?cds=" + line[0].to_s + line[1].to_s + line[2].to_s+ "&Public=Y"
# 				data = Nokogiri::HTML(open(url))
# 				data.css("td").each_slice(2).each do |row|
# 					info.push(row[1].to_s[4..row.length-8])
# 				end
# 				if !info.empty?
# 					file1.write(line[2].to_s+"|"+info[2].to_s+"|"+info[4]+"|"+info[5]+"\n")
# 					puts line[2].to_s+"|"+info[2].to_s+"|"+info[4].to_s+"|"+info[5].to_s+"\n"
# 				end
# 			end
# 			info.clear
# 		end
# 	}
# }

school = Array.new
File.open('names.txt','r'){ |file|
		file.each_line do |line|
			line = line.split('|')
			school.push(line)
		end
}

school = school.sort { |a, b| [a[2], a[3]] <=> [b[2], b[3]] }

File.open('final.txt', 'w'){ |file1|
	school.each do |names|
		file1.write(names[0].to_s+"|"+names[1].to_s+"|"+names[2].to_s+"|"+names[3])	
	end
}
