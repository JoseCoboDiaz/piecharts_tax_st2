hcol1={}	#rows piechart sourcetracker2
sample=''
study=''

`ls matrices_selected/out* > list3.txt`


aa=File.open("metadata_pie.txt").each_line do |line|
line.chomp!
col=line.split("\t")
hcol1[col[0]]=col[2]
end
aa.close

out=File.new("megamatrix_piechart.txt","w")

n=0
bb=File.open("list3.txt").each_line do |file|
file.chomp!
sample=file.split("out_")[1].gsub(".txt","")
puts sample
	cc=File.open(file).each_line do |line|
	line.chomp!
	if line =~ /Source/ 
		if n==0
		out.puts "Sample\tSurface\t#{line}"
		n=1
		end
	elsif line =~ /^(\S+)\s+(.*)/
		out.puts "#{sample}\t#{hcol1[sample]}\t#{line}"
	end
	end
	cc.close
end
bb.close
