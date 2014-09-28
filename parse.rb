File.open('2010_clean.txt', 'a'){ |save|

	File.open('2010.txt', 'r'){ |file|
		file.each_line do |line|
			line = line.split(',')
			if ((line[16] != '"*"' && line[16] != '""') && 
					(line[17] != '"*"' && line[17] != '""') && (line[18] != '"*"' && line[18] != '""') &&
					(line[19] != '"*"' && line[19] != '""') && (line[20] != '"*"' && line[20] != '""') &&
					(line[21] != '"*"' && line[21] != '""') && (line[22] != '"*"' && line[22] != '""'))
				i = 0;
				while i < 23 do
					if line[i][0] == '"'
						line[i] = line[i][1..line[i].length-2];
					end
					i+=1
				end
				line = line.join(",");
				save.write(line.to_s);
			end
		end
	}
}