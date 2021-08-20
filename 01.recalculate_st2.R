
library(RcmdrMisc)
library(tidyverse)

args <- commandArgs(trailingOnly = TRUE)
filename <- args[1]
data<-read.table(filename, row.names=1, header=TRUE, sep="\t")
filename<-str_remove(filename, ".feature_table.txt")
data2<-totPercents(data,digits=2)
data2<-data2[-nrow(data2),]

data3<-cbind(data2$Lactococcus,data2$Lactobacillus,data2$Tetragenococcus,data2$Corynebacterium,
			data2$Acidipropionibacterium,data2$Staphylococcus,data2$Brevibacterium,data2$Hafnia,
			data2$Alkalibacterium,data2$Brachybacteriu,data2$Yaniella,
			data2$Halomonas,data2$Marinobacter,data2$Psychroflexus,data2$Pseudomonas,data2$Psychrobacter,
			data2$Enterococcus,data2$Leuconostoc,data2$Enterobacter,data2$Obesumbacterium,data2$Bifidobacterium)

data3<-as.data.frame(data3)
#data2$Yaniella
data3$Other<-round(data2$Total-rowSums(data3),digits=2)
data3$Total<-data2$Total
colnames(data3)[1:21]<-c("Lactococcus","Lactobacillus","Tetragenococcus","Corynebacterium","Acidipropionibacterium","Staphylococcus","Brevibacterium","Hafnia",
			"Alkalibacterium","Brachybacterium","Yaniella",
			"Halomonas","Marinobacter","Psychroflexus","Pseudomonas","Psychrobacter",
			"Enterococcus","Leuconostoc","Enterobacter","Obesumbacterium","Bifidobacterium")
rownames(data3)<-rownames(data2)
data3<-cbind(rownames(data3),data3)
colnames(data3)[1]<-"Source"
filename<-str_glue( "out_",filename, ".txt")
write.table(data3, file=filename, row.names=FALSE, quote=FALSE)

