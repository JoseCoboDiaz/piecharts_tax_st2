
`ls matrices/out_* > list2.txt`

taxa=[]

aa=File.new("list2.txt").each_line do |file|
file.chomp!
	bb=File.new("#{file}").each_line do |line|
	line.chomp!
	if line =~ /Source/
	#puts line.split("\t")[0]
	line.split("\t").each {|x| taxa << x}
	end
	end
	bb.close
end
aa.close

out=File.new("selected_taxa.txt","w")
out.puts taxa.uniq
puts taxa.uniq
puts taxa.uniq.length
