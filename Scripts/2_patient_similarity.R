#Load libraries
library(tidyverse)
library(phyloseq)
library(microbiome)
library(NetCoMi)
library(genefilter)

#Data 
physeq.rel #Phyloseq object pruned at genus level transformed to CoDA analysis 

#Network construction Netcomi#### 
#Keep taxa with a relative abundance greater than 0.05% in at least 1 of the samples
# k = 1; A = 0.0005 
flist <- filterfun(kOverA(1, 0.0005))
physeq.fil <- filter_taxa(physeq.rel, flist)
physeq.genus <- prune_taxa(physeq.fil, physeq.rel)

#Patient network construction#### 

#Aitchison distance 

net_aitchison <- netConstruct(physeq.genus,
                              measure = "aitchison",
                              zeroMethod = "none",
                              normMethod = "clr",
                              sparsMethod = "knn", 
                              kNeighbor = 3,
                              verbose = 3)

props_aitchison <- netAnalyze(net_aitchison,
                              clustMethod = "hierarchical",
                              hubPar = "eigenvector")

summary(props_aitchison)

plot(props_aitchison, 
     nodeColor = "cluster", 
     nodeSize = "fix",
     hubTransp = 40,
     edgeTranspLow = 60,
     charToRm = "00000",
     mar = c(2, 3, 3, 5))

#Color and aesthetics
paletaClus <- MetBrewer::met.brewer("Renoir",n=3)
cluslcol <- as.character(paletaClus) 

plot(props_aitchison, 
     nodeColor = "cluster", 
     nodeTransp = 15,
     colorVec=cluslcol,
     nodeSize = "fix",
     hubTransp = 10,
     posCol = "darkgray", 
     edgeTranspLow = 20,
     charToRm = "00000",
     cexLabels=0,
     highlightHubs = F,
     mar = c(2, 3, 3, 5))


#Include cluster information with metadata
clus <- as.data.frame(props_aitchison[["clustering"]][["clust1"]])
colnames(clus) <- "Cluster"
clus <- rownames_to_column(clus, var="SampleID") %>% left_join(metadata)
clus$Cluster <- as.factor(clus$Cluster)

#Summary table all metadata by Cluster 
tabla <-clus %>% column_to_rownames(var="SampleID") %>% tbl_summary(`by=Cluster`) %>% add_p()


#Diferencias por Cluster ####
#Include Cluster information into phyloseq
sample_metadataCLUS <- sample_data(clus)
sample_names(sample_metadataCLUS) <- paste(clus$SampleID)

#Objeto phyloseq de todo
physeqClus <- merge_phyloseq(physeq, sample_metadataCLUS)

#saveRDS(physeqClus)