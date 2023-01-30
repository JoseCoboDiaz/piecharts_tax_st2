`ls st2_output/* > list.txt`
`mkdir matrices`
aa=File.open("list.txt").each_line do |file|
file.chomp!
puts file
out=File.new("#{file.gsub("st2_output/","matrices/")}","w")
	bb=File.new("#{file}").each_line do |line|
	line.chomp!
	if line =~ /^\t(.*)/
	out.puts line.gsub('""','')
	else out.puts line
	end
	end
	bb.close
end
aa.close


