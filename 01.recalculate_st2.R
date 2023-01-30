library(RcmdrMisc)
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
filename <- args[1]
data<-read.table(filename, row.names=1, header=TRUE, sep="\t")
filename<-str_remove(filename, ".feature_table.txt")
filename<-str_remove(filename, "matrices/")

# Since matrix from SourceTracker2 sums 10000, to transform to percentage and take those taxa with at least 0.5% of influence, we will run:	
cutoff=500	#you can change the cutoff value, if you want or need it
data2<-data[,which(colSums(data)>cutoff)]/100
data2$Other<-rowSums(data[,-which(colSums(data)>cutoff)]/100)

data3<-cbind(rownames(data2),data2)
colnames(data3)[1]<-"Source"

filename<-str_glue( "matrices/out_",filename, ".txt")
write.table(data3, file=filename, row.names=FALSE, quote=FALSE, sep="\t")
