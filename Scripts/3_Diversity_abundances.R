#Load libraries
library(tidyverse)
library(phyloseq)
library(microbiome)
library(ggpubr)
library(gtsummary)

#Data  
physeqClus #Phyloseq object including the label "Cluster" after patient similarity network construction 

#Differences in abundance and diversity by cluster ####
#Use the clean phyloseq object pruned to genus level without any transformations, just the counts  

#Colors 
paletaClus <- MetBrewer::met.brewer("Renoir",n=3)

plot_richness(physeqClus)
rich <- richness(physeqClus)
plot_rich <- plot_richness(physeqClus, color = "Cluster", x = "Cluster", measures = c("Chao1", "Simpson", "Shannon")) + geom_boxplot(aes(fill = Cluster), alpha=.7) + theme_bw()
plot_rich + scale_fill_manual(values = paletaClus) + scale_color_manual(values = paletaClus)

#Add P values
alfas <- plot_rich[["plot_env"]][["DF"]] %>% select(Chao1, Shannon, Simpson, SampleID, Cluster)
compare_means(Chao1 ~ Cluster, data = alfas, method = "wilcox.test", paired = FALSE)
compare_means(Simpson ~ Cluster, data = alfas, method = "wilcox.test", paired = FALSE)
compare_means(Shannon ~ Cluster, data = alfas, method = "wilcox.test", paired = FALSE)

my_comparisons <- list( c("1", "2"), c("2", "3"), c("1", "3"))

C <- ggboxplot(alfas, x = "Cluster", y = "Chao1", fill = "Cluster", alpha=.7) + scale_fill_manual(values = cluslcol) +
  stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = my_comparisons) + theme_minimal() +
  theme(axis.text.x = element_text(color = "black", size = 11, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 11, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  ggtitle ("Chao1 Index") + theme(plot.title = element_text(family="Arial", size=rel(1), vjust=2,face="plain", color="black", lineheight=1.5)) +
  labs(x = "",y = "") + theme(axis.title = element_text(size=rel(1))) + theme(legend.position = "bottom") 

S <- ggboxplot(alfas, x = "Cluster", y = "Shannon", fill = "Cluster", alpha=.7) + scale_fill_manual(values = cluslcol) +
  stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = my_comparisons)+ theme_minimal() +
  theme(axis.text.x = element_text(color = "black", size = 11, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 11, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  ggtitle ("Shannon Index") + theme(plot.title = element_text(family="Arial", size=rel(1), vjust=2,face="plain", color="black", lineheight=1.5)) +
  labs(x = "",y = "") + theme(axis.title = element_text(size=rel(1))) + theme(legend.position = "bottom") 

Si <- ggboxplot(alfas, x = "Cluster", y = "Simpson", fill = "Cluster", alpha=.7) + scale_fill_manual(values = cluslcol) +
  stat_compare_means(label = "p.signif", method = "wilcox.test", comparisons = my_comparisons) + theme_minimal() +
  theme(axis.text.x = element_text(color = "black", size = 11, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 11, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  ggtitle ("Simpson Index") + theme(plot.title = element_text(family="Arial", size=rel(1), vjust=2,face="plain", color="black", lineheight=1.5)) +
  labs(x = "",y = "") + theme(axis.title = element_text(size=rel(1))) + theme(legend.position = "bottom") 


library(patchwork)
C+S+Si+ plot_layout(guides = "collect") & theme(legend.position = 'bottom')


#Compositional analísis transform to CLR 
physeq.rel #Phyloseq object transformed for CoDA

#Unifrac
ordinated_taxa_unifrac = ordinate(physeq.rel, method="MDS", distance="unifrac",weighted=TRUE)

plot_ordination(physeq.rel, ordinated_taxa_unifrac, color="Cluster", title = "Unifrac MDS Analysis") + theme_minimal() +
  scale_color_manual(values = cluslcol)  + geom_point(size = 2)

plot_ordination(physeq.rel, ordinated_taxa_unifrac, color="Cluster", title = "Unifrac MDS Analysis Comp. 1 & 3", axes=c(1,3)) + theme_minimal() +
  scale_color_manual(values = cluslcol)  + geom_point(size = 2)

plot_ordination(physeq.rel, ordinated_taxa_unifrac, color="Cluster", title = "Unifrac MDS Analysis Comp. 2 & 3", axes=c(2,3)) + theme_minimal() +
  scale_color_manual(values = cluslcol)  + geom_point(size = 2) 

#Relative abundances of the top-20 genus 
paleta <- MetBrewer::met.brewer("Renoir",n=20)
tb <- psmelt(physeqClus) 

tb20genus <- tb %>% group_by(Genus) %>% summarise(M=median(Abundance)) %>% ungroup() %>% unique() %>% top_n(M,n=20)
tb20genus <- tb20genus %>% inner_join(tb)
Plot20g <- ggplot(tb20genus, aes(Cluster, Abundance, fill=Genus)) + geom_col(position="fill") + 
  scale_fill_manual(values=paleta)
Plot20g <- Plot20g + theme_minimal() + xlab("Cluster") + ylab("Relative Abundance") +
  theme(axis.text.x = element_text(color = "black", size = 14, angle = 0, hjust = .5, vjust = .5, face = "plain")) +
  theme(axis.text.y = element_text(color = "black", size = 14, angle = 0, hjust = 1, vjust = 0, face = "plain")) + 
  theme(legend.title=element_text(color= "black", size=12), legend.text=element_text(size=11, face="italic"))
Plot20g + theme(aspect.ratio = 2.5) 


