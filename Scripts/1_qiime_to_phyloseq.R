#Load libraries
library(tidyverse)
library(qiime2R)
library(phyloseq)
library(microbiome)

#Read data from qiime2####

ASV<-read_qza("Data/table.qza")
#Taxonomy
taxonomyq <-read_qza("Data/taxonomy.qza")

#Transforme table into phyloseq-readable table
taxtableq <- taxonomyq$data %>% as.tibble() %>% separate(Taxon, sep=";", c("Kingdom","Phylum","Class","Order","Family","Genus","Species"))
taxtableq$Kingdom <- gsub("d__", "",taxtableq$Kingdom)
taxtableq$Phylum <- gsub("p__", "",taxtableq$Phylum)
taxtableq$Class <- gsub("c__", "",taxtableq$Class)
taxtableq$Order <- gsub("o__", "",taxtableq$Order)
taxtableq$Family <- gsub("f__", "",taxtableq$Family)
taxtableq$Genus <- gsub("g__", "",taxtableq$Genus)
taxtableq$Species <- gsub("s__", "",taxtableq$Species)

#Load tree
tree<-read_qza("Data/rooted-tree.qza")

#Load Metadata
metadata<-read_csv("Data/metadata_summary.csv")

#Clean-up taxa table
taxtableq <- taxtableq[grep("Unassigned|Eukaryota", taxtableq$Kingdom, invert=T),]
taxtableq <- taxtableq[grep("Chloroplast| Mitochondria|unidentified|uncultured", taxtableq$Family, invert=T),]
taxtableq <- taxtableq[grep("unidentified|uncultured", taxtableq$Genus, invert=T),]

#Create phyloseq object 
OTUs <- otu_table(ASV$data, taxa_are_rows = T) 
tree <- phy_tree(tree$data) 
TAXq <- tax_table(as.data.frame(taxtableq) %>% select_("-Confidence") %>% column_to_rownames("Feature.ID") %>% as.matrix()) #moving the taxonomy to the way phyloseq wants it
sample_metadata <- sample_data(metadata %>% as.data.frame()) 
sample_names(sample_metadata) <- paste(metadata$SampleID)
physeq<- merge_phyloseq(OTUs, tree, TAXq,sample_metadata)


#Prune taxa at genus level and transform data for CoDA  
physeq <- tax_glom(physeq, taxrank = "Genus")
physeq.rel <- transform(physeq, transform="compositional")

#saveRDS(physeq.rel)
