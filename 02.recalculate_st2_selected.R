library(RcmdrMisc)
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
filename <- args[1]
data<-read.table(filename, row.names=1, header=TRUE, sep="\t")
filename<-str_remove(filename, ".feature_table.txt")
filename<-str_remove(filename, "matrices/")

selected<-scan("selected_taxa.txt","")
selected<-selected[! selected %in% c('Source', 'Other')]

data2<-data[,which(colnames(data) %in% selected)]/100
data2$Other<-rowSums(data[,-which(colnames(data) %in% selected)]/100)

data3<-cbind(rownames(data2),data2)
colnames(data3)[1]<-"Source"

filename<-str_glue( "matrices_selected/out_",filename, ".txt")
write.table(data3, file=filename, row.names=FALSE, quote=FALSE, sep="\t")
