#Activate Conda enviroment 
conda activate qiime2-2022.2

qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path manifest.csv \
  --output-path demux.qza \
  --input-format PairedEndFastqManifestPhred33 \

qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv

 qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux.qza \
  --p-n-threads 6 \
  --p-trim-left-f 6 \
  --p-trim-left-r 6 \
  --p-trunc-len-f 220 \
  --p-trunc-len-r 220 \
  --o-table table.qza \
  --o-representative-sequences rep-seqs.qza \
  --o-denoising-stats denoising-stats.qza

  qiime feature-table tabulate-seqs \
  --i-data rep-seqs.qza \
  --o-visualization rep-seqs.qzv
  
qiime metadata tabulate \
  --m-input-file denoising-stats.qza \
  --o-visualization denoising-stats.qzv
  
qiime feature-table summarize \
  --i-table table.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file metadata_summary.tsv


#Taxonomy assignment 

#Download SILVA classifier

  wget https://data.qiime2.org/2022.2/common/silva-138-99-nb-classifier.qza

  qiime feature-classifier classify-sklearn \
  --i-classifier silva-138-99-nb-classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza
  
qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

# Contruct phylogenetic tree 

  qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences filtered_rep-seqs.qza \
  --o-alignment aligned_filtered-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza