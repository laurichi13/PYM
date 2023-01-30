library(tidyverse)
library(ggplot2)
library(ggpubr)

#Microbiome-knowledge questionnarie scores by Cluster

#metadata
metadata <- read_csv("Data/metadata.csv")

#Questionnarie scores plus metadata
cal <- read_csv2("DATA/calificaciones.csv")
colnames(cal) <- c("SampleID", "Cal_pre", "Cal_post")
cal <- cal %>% mutate(var= Cal_post - Cal_pre) %>% right_join(metadata)

my_comparisons <- list(c("1", "3"))

var_clas <- ggboxplot(cal, x = "Cluster", y = "var", fill = "Cluster", alpha=.7) + scale_fill_manual(values = cluslcol) +
  stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = my_comparisons,hide.ns = TRUE) + theme_minimal() +
  theme(axis.text.x = element_text(color = "black", size = 11, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 11, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  ggtitle ("Variation in calification") + theme(plot.title = element_text(family="Arial", size=rel(1), vjust=2,face="plain", color="black", lineheight=1.5)) +
  labs(x = "",y = "") + theme(axis.title = element_text(size=rel(1))) + theme(legend.position = "bottom") 


var_clas


pre_clas <- ggboxplot(cal, x = "Cluster", y = "Cal_pre", fill = "Cluster", alpha=.7) + scale_fill_manual(values = cluslcol) +
  stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = my_comparisons,hide.ns = TRUE) + theme_minimal() +
  theme(axis.text.x = element_text(color = "black", size = 11, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 11, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  ggtitle ("Questionarie pre-intervention") + theme(plot.title = element_text(family="Arial", size=rel(1), vjust=2,face="plain", color="black", lineheight=1.5)) +
  labs(x = "",y = "") + theme(axis.title = element_text(size=rel(1))) + theme(legend.position = "bottom") 


pre_clas

post_clas <- ggboxplot(cal, x = "Cluster", y = "Cal_post", fill = "Cluster", alpha=.7) + scale_fill_manual(values = cluslcol) +
  stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = my_comparisons,hide.ns = TRUE) + theme_minimal() +
  theme(axis.text.x = element_text(color = "black", size = 11, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 11, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  ggtitle ("Questionarie post-intervention") + theme(plot.title = element_text(family="Arial", size=rel(1), vjust=2,face="plain", color="black", lineheight=1.5)) +
  labs(x = "",y = "") + theme(axis.title = element_text(size=rel(1))) + theme(legend.position = "bottom") 


post_clas


#Medias 

cal %>% select(Cal_pre,Cal_post,var,Cluster) %>% group_by(Cluster) %>% summarise(mean_pre=mean(Cal_pre, na.rm=T),
                                                                                 mean_post=mean(Cal_post, na.rm=T),
                                                                                 var=mean(var,na.rm=T))

kruskal.test(cal$Cal_pre,cal$Cluster)
kruskal.test(cal$Cal_post,cal$Cluster)
kruskal.test(cal$var,cal$Cluster)


