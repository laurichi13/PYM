 # PYM
 PictureYourMicrobe's project analysis code and data. 
 
Raw data can be found in ENA under accession number: PRJEB59312.
[Here](https://www.medrxiv.org/content/10.1101/2022.06.17.22276351v1.full) is a preprint of the study published in medRxiv. 

## Table of contents
* [Data](#data)
* [Scripts](#scripts)

## Data
This directory contains the data used to construct the `phyloseq` object and metadata for analysis. 
#### Qiime2_artifacts: Folder containing qiime2 artifacts used to construct `phyloseq` object:
- `metadata_summary.csv`: metadata.
-	 `rooted-tree.qza`: phylogenetic tree
-	 `table_qza`: ASV table 
-	`taxonomy.qza`: taxonomy table

**NOTE:** 16S rRNA data was processed following Qiime2 Version 2022.2 pipeline. Taxonomic assignment was performed with SILVA classifier `silva-138-99-nb-classifier.qza` trained with qiime2 version 2022.2. 

- `calificaciones.cvs`: a text file containing the ad-hoc microbiome-knowledge scores of participants.
- `metadata.csv`: a text file containing all metadata from the study.
- `valoracion.csv`: a text file containing answers from ad-hoc satisfaction and learning questionnaires.


## Scripts
This directory contains the scripts used for pre-processing data in Qiime 2 and upstream analysis in R.

#### Qiime2: Folder containing scripts for qiime2 pipeline:
- 	`qiime.sh`: pipeline used for qiime2
-	`script_manifest.pl`: script used for creating manifest for qiime2
#### R scripts:
- `1_qiime_to_phyloseq.R`: script used to create `phyloseq` object from qiime2 artifacts.
- `2_patient_similarity.R`: script used to create patient similarity network with Aitchinson distance. 
- `3_Diversity_abundances.R`: script for alpha and beta diversity analysis and relative abundance by cluster. 
- `4_coocurrence_byCluster.R`: script for microbial co-occurrence network construction and analysis. 
- `5_knowledge_byCluster.R`: script for knowledge questionnaires analysis by cluster. 
- `6_likert.R`:analysis of satisfaction and ad-hoc learning questionnaires. 
- `7_pictures_byCluster.R`: script for analysis of the contribution of participants of each cluster to the different photovoice themes. 
- `8_metadata_tables.R`: table summary of metadata. 
- `9_participants_report.R`: Script for personalised report delivered to each participant.
