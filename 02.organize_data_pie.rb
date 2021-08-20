
hcol1={}	#rows piechart sourcetracker2
sample=''
study=''

`ls st2_output/out* > list_out_bact.txt`


aa=File.open("metadata_pie.txt").each_line do |line|
line.chomp!
col=line.split("\t")
hcol1[col[0]]=col[2]
end
aa.close

#bact=["curdtate_before_cave","food_contact_Cave1","food_contact_Cave3","food_contact_Cave2","food_contact_before_cave"]

out=File.new("megamatrix_bact.txt","w")

n=0
bb=File.open("list_out_bact.txt").each_line do |file|
file.chomp!
#prod1_CP/st2_bact_G/out_Avelino-100.txt
study=file.split("\/")[0]
sample=file.split("out_")[1].gsub(".txt","")
puts study 
puts sample
	cc=File.open(file).each_line do |line|
	line.chomp!
	if line =~ /Source/ 
		if n==0
		out.puts "Sample\t#{line.gsub("\s","\t")}"
		n=1
		end
	elsif line =~ /^(\S+)\s+(.*)/
#		if bact.include?($1)==true
		out.puts "#{hcol1[sample]}\t#{study}\_#{$1}\t#{$2.gsub("\s","\t")}"
#		end
	end
	end
	cc.close
end
bb.close




