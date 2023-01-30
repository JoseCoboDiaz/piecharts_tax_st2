`ls matrices/*table.txt > list.txt`
`mkdir matrices_selected`

bb=File.open("list.txt").each_line do |line|
line.chomp!
`Rscript 02.recalculate_st2_selected.R #{line}`
end
bb.close
