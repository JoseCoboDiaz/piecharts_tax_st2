`ls matrices/*table.txt > list.txt`

bb=File.open("list.txt").each_line do |line|
line.chomp!
`Rscript 01.recalculate_st2.R #{line}`
end
bb.close
