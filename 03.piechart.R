
#https://stackoverflow.com/questions/8612920/pie-charts-in-ggplot2-with-variable-pie-sizes

###########################################################

library(ggplot2)
library(tidyr)
library(dplyr)

data<-read.table("megamatrix_bact.txt", header = TRUE, sep="\t")

data_list<-gather(data, key="Taxa", value="Abundance", -c("Sample", "Source", "Total"))

#write.table(data_list, file = "heatpiemap_data.txt", sep="\t", quote=FALSE)


########################

library(RColorBrewer)
YlOrRd<-brewer.pal(n = 8, name = "YlOrRd")
BuPu<-brewer.pal(n = 8, name = "BuPu")
Spectral<-c(brewer.pal(n=11, name = "Spectral"),"purple4")
#Spectral<-brewer.pal(n=6, name = "Spectral")
library("khroma")
discrete_rainbow <- colour("discrete rainbow")
plot_scheme(discrete_rainbow(22), colours = TRUE, size = 0.7)

Spectral<-c("#D9CCE3","#CAACCB","#BA8DB4","#AA6F9E","#994F88",
		"#882E72","#1965B0","#437DBF","#6195CF","#7BAFDE",
		"#4EB265","#90C987","#CAE0AB","#F7F056","#F7CB45",
		"#F4A736","#EE8026","#E65518","#DC050C","#A5170E",
		"#72190E","#42150A")

 
data2<-data_list%>% 
  #group_by(Group) %>%
  group_by(Sample,Source,Taxa) %>%
  summarize(Abundance=mean(Abundance), Total=mean(Total))

data2$Abundance[which(data2$Abundance<0)]<-0	#si hay valores negativos dibuja medio rosco


pdf("sourcetracker_bact_22sps.pdf",width=15, height=15)
ggplot(data2, aes(x=Total/2, y = Abundance, fill = Taxa, width = Total)) +
  geom_bar(position="fill", stat="identity") + 
#  facet_grid(Genus ~ Sample) + 
  facet_grid(Sample ~ Source) + 
  coord_polar("y") +	# to convert geom_bar to piechart
  scale_fill_manual(values = Spectral) +
  theme_bw()+
theme(panel.spacing=unit(.05, "lines"),
        panel.border = element_rect(color = "grey", fill = NA, size = 1), 
        strip.background = element_rect(color = "grey", size = 1))
dev.off()


