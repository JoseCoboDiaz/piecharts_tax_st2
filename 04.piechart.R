
#https://stackoverflow.com/questions/8612920/pie-charts-in-ggplot2-with-variable-pie-sizes

###########################################################

library(ggplot2)
library(tidyr)
library(dplyr)

library(RColorBrewer)
YlOrRd<-brewer.pal(n = 8, name = "YlOrRd")
BuPu<-brewer.pal(n = 8, name = "BuPu")
Spectral<-c(brewer.pal(n=11, name = "Spectral"),"purple4")
#Spectral<-brewer.pal(n=6, name = "Spectral")
library("khroma")
#discrete_rainbow <- colour("discrete rainbow")
discrete_rainbow <- colour("smooth rainbow")
plot_scheme(discrete_rainbow(28), colours = TRUE, size = 0.7)

Spectral<-c(
"#E8ECFB","#DAD2EB","#CAB5D9","#B997C7","#A87AB5","#995FA5","#824D99",
"#6653A2","#5764B4","#4E78C4","#4D8CC3","#5099B8","#57A2AC","#5FAA9F",
"#6AB18D","#7EB875","#9ABD5C","#B8BC4A","#D0B541","#DEA63B","#E59437",
"#E67F33","#E4652D","#DE4327","#CE2220","#A4211C","#791E17","#521A13"
)

########################

data<-read.table("megamatrix_piechart.txt", header = TRUE, sep="\t")
data$Total<-rowSums(data[4:ncol(data)])
data_list<-gather(data, key="Taxa", value="Abundance", -c("Sample", "Surface", "Source", "Total"))
#write.table(data_list, file = "heatpiemap_data.txt", sep="\t", quote=FALSE)
data2<-data_list%>% 
  #group_by(Group) %>%
  group_by(Surface,Source,Taxa) %>%
  summarize(Abundance=mean(Abundance), Total=mean(Total))
data2$Abundance[which(data2$Abundance<0)]<-0	#si hay valores negativos dibuja medio rosco


pdf("sourcetracker_piechart.pdf",width=15, height=15)
ggplot(data2, aes(x=Total/2, y = Abundance, fill = Taxa, width = Total)) +
  geom_bar(position="fill", stat="identity") + 
#  facet_grid(Genus ~ Sample) + 
  facet_grid(Surface ~ Source) + 
  coord_polar("y") +	# to convert geom_bar to piechart
  scale_fill_manual(values = Spectral) +
  theme_bw()+
theme(panel.spacing=unit(.05, "lines"),
        panel.border = element_rect(color = "grey", fill = NA, size = 1), 
        strip.background = element_rect(color = "grey", size = 1))
dev.off()

########################



