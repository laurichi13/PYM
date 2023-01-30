library(tidyverse)
library(NetCoMi)
# Create networks from each cluster 
# Split the phyloseq object into two groups

physeqClus 
physeqClus_split <- metagMisc::phyloseq_sep_variable(physeqClus,"Cluster")

#Net bugs from Cluster 1
net_C1 <- netConstruct(data = physeqClus_split$`1`,data2=NULL, dataType = "counts", group = NULL,
                         matchDesign = NULL, measure = "spieceasi", measurePar = NULL,
                         jointPrepro = NULL, filtTax = "none", filtTaxPar = NULL,
                         filtSamp = "none", filtSampPar = NULL,  zeroMethod = "none",
                         zeroPar = NULL, normMethod = "none", normPar = NULL, sparsMethod = "t-test",
                         thresh = 0.3, alpha = 0.05, adjust = "adaptBH", trueNullMethod = "convest",
                         lfdrThresh = 0.2, nboot = 1000L,  cores = 8,  logFile = "log.txt",
                         softThreshType = "signed",  softThreshPower = NULL, softThreshCut = 0.8,
                         kNeighbor = 3L, knnMutual = FALSE,  dissFunc = "signed",  dissFuncPar = NULL,
                         simFunc = NULL, simFuncPar = NULL,  scaleDiss = TRUE, weighted = TRUE,
                         sampleSize = NULL,  verbose = 2, seed = NULL)

props_clusC1 <- netAnalyze(net_C1, 
                         centrLCC = FALSE,
                         avDissIgnoreInf = TRUE,
                         sPathNorm = FALSE,
                         clustMethod = "cluster_fast_greedy",
                         hubPar = c("degree", "between"),
                         hubQuant = 0.9,
                         lnormFit = TRUE,
                         normDeg = TRUE,
                         normBetw = FALSE,
                         normClose = FALSE,
                         normEigen = FALSE)

#Colors and aesthetics
taxtab <- physeqClus@tax_table@.Data
phyla <- as.factor(gsub("p__", "", taxtab[, "Phylum"]))
colors <- MetBrewer::met.brewer("Renoir",n=18)


plot(props_clusC1, 
     sameLayout = F, 
     nodeColor = "feature", 
     featVecCol = phyla, 
     colorVec =  colors,
     borderCol = "gray40",
     nodeSize = "mclr", 
     cexNodes = 2,
     nodeSizeSpread = 4, 
     edgeTranspLow = 30, 
     edgeTranspHigh = 10,
     groupNames = c("Cluster 1", "Cluster2"), 
     mar = c(3,3,3,3), 
     repulsion = 1, 
     rmSingles = "inboth",
     nodeFilter = "clustMin", 
     nodeFilterPar = 3, 
     nodeTransp = 10, 
     hubTransp = 10, 
     highlightHubs = T,
     cexLabels=0)

summary(props_clusC1)

#Net bugs from Cluster 2
net_C2 <- netConstruct(data = physeqClus_split$`2`,data2=NULL, dataType = "counts", group = NULL,
                       matchDesign = NULL, measure = "spieceasi", measurePar = NULL,
                       jointPrepro = NULL, filtTax = "none", filtTaxPar = NULL,
                       filtSamp = "none", filtSampPar = NULL,  zeroMethod = "none",
                       zeroPar = NULL, normMethod = "none", normPar = NULL, sparsMethod = "t-test",
                       thresh = 0.3, alpha = 0.05, adjust = "adaptBH", trueNullMethod = "convest",
                       lfdrThresh = 0.2, nboot = 1000L,  cores = 8,  logFile = "log.txt",
                       softThreshType = "signed",  softThreshPower = NULL, softThreshCut = 0.8,
                       kNeighbor = 3L, knnMutual = FALSE,  dissFunc = "signed",  dissFuncPar = NULL,
                       simFunc = NULL, simFuncPar = NULL,  scaleDiss = TRUE, weighted = TRUE,
                       sampleSize = NULL,  verbose = 2, seed = NULL)

props_clusC2 <- netAnalyze(net_C2, 
                           centrLCC = FALSE,
                           avDissIgnoreInf = TRUE,
                           sPathNorm = FALSE,
                           clustMethod = "cluster_fast_greedy",
                           hubPar = c("degree", "between"),
                           hubQuant = 0.9,
                           lnormFit = TRUE,
                           normDeg = FALSE,
                           normBetw = FALSE,
                           normClose = FALSE,
                           normEigen = FALSE)

#Colors and aesthetics
taxtab <- physeqClus@tax_table@.Data
phyla <- as.factor(gsub("p__", "", taxtab[, "Phylum"]))
colors <- MetBrewer::met.brewer("Renoir",n=18)

plot(props_clusC2, 
     sameLayout = F, 
     nodeColor = "feature", 
     featVecCol = phyla, 
     colorVec =  colors,
     borderCol = "gray40",
     nodeSize = "mclr", 
     cexNodes = 2,
     nodeSizeSpread = 4, 
     edgeTranspLow = 30, 
     edgeTranspHigh = 10,
     groupNames = c("Cluster 1", "Cluster2"), 
     mar = c(3,3,3,3), 
     repulsion = 1, 
     rmSingles = "inboth",
     nodeFilter = "clustMin", 
     nodeFilterPar = 3, 
     nodeTransp = 10, 
     hubTransp = 10, 
     highlightHubs = T,
     cexLabels=0)

summary(props_clusC2)

#Net bugs from cluster 3

net_C3 <- netConstruct(data = physeqClus_split$`3`,data2=NULL, dataType = "counts", group = NULL,
                       matchDesign = NULL, measure = "spieceasi", measurePar = NULL,
                       jointPrepro = NULL, filtTax = "none", filtTaxPar = NULL,
                       filtSamp = "none", filtSampPar = NULL,  zeroMethod = "none",
                       zeroPar = NULL, normMethod = "none", normPar = NULL, sparsMethod = "t-test",
                       thresh = 0.3, alpha = 0.05, adjust = "adaptBH", trueNullMethod = "convest",
                       lfdrThresh = 0.2, nboot = 1000L,  cores = 8,  logFile = "log.txt",
                       softThreshType = "signed",  softThreshPower = NULL, softThreshCut = 0.8,
                       kNeighbor = 3L, knnMutual = FALSE,  dissFunc = "signed",  dissFuncPar = NULL,
                       simFunc = NULL, simFuncPar = NULL,  scaleDiss = TRUE, weighted = TRUE,
                       sampleSize = NULL,  verbose = 3, seed = NULL)

props_clusC3 <- netAnalyze(net_C3, 
                           centrLCC = FALSE,
                           avDissIgnoreInf = TRUE,
                           sPathNorm = FALSE,
                           clustMethod = "cluster_fast_greedy",
                           hubPar = c("degree", "between"),
                           hubQuant = 0.9,
                           lnormFit = TRUE,
                           normDeg = FALSE,
                           normBetw = FALSE,
                           normClose = FALSE,
                           normEigen = FALSE)

summary(props_clusC3)

#Colors and aesthetics
taxtab <- physeqClus@tax_table@.Data
phyla <- as.factor(gsub("p__", "", taxtab[, "Phylum"]))
colors <- MetBrewer::met.brewer("Renoir",n=18)

plot(props_clusC3, 
     nodeColor = "feature", 
     featVecCol = phyla, 
     colorVec =  colors,
     borderCol = "gray40",
     nodeSize = "mclr", 
     cexNodes = 2,
     nodeSizeSpread = 4, 
     edgeTranspLow = 10, 
     edgeTranspHigh = 10,
     mar = c(3,3,3,3), 
     repulsion = 1, 
     rmSingles = T,
     nodeFilter = "clustMin", 
     nodeFilterPar = 3, 
     nodeTransp = 10, 
     hubTransp = 7, 
     highlightHubs = T,
     cexLabels=0,
     posCol = "#247d3f", 
     negCol = "#931e18")


#Network comparisons Two by Two

#C1 Vs C3
net_C1vsC3 <- netConstruct(data = physeqClus_split$`1`,data2=physeqClus_split$`3`, dataType = "counts", group = NULL,
                         matchDesign = NULL, measure = "spieceasi", measurePar = NULL,
                         jointPrepro = NULL, filtTax = "none", filtTaxPar = NULL,
                         filtSamp = "none", filtSampPar = NULL,  zeroMethod = "none",
                         zeroPar = NULL, normMethod = "none", normPar = NULL, sparsMethod = "t-test",
                         thresh = 0.3, alpha = 0.05, adjust = "adaptBH", trueNullMethod = "convest",
                         lfdrThresh = 0.2, nboot = 1000L,  cores = 8,  logFile = "log.txt",
                         softThreshType = "signed",  softThreshPower = NULL, softThreshCut = 0.8,
                         kNeighbor = 3L, knnMutual = FALSE,  dissFunc = "signed",  dissFuncPar = NULL,
                         simFunc = NULL, simFuncPar = NULL,  scaleDiss = TRUE, weighted = TRUE,
                         sampleSize = NULL,  verbose = 2, seed = NULL)

props_C1VsC3 <- netAnalyze(net_C1vsC3, 
                         centrLCC = FALSE,
                         avDissIgnoreInf = TRUE,
                         sPathNorm = FALSE,
                         clustMethod = "cluster_fast_greedy",
                         hubPar = c("degree", "between", "closeness"),
                         hubQuant = 0.9,
                         lnormFit = TRUE,
                         normDeg = FALSE,
                         normBetw = FALSE,
                         normClose = FALSE,
                         normEigen = FALSE)


#Properties comparison
comp_C1vsC3 <- netCompare(props_C1VsC3, permTest = FALSE, verbose = FALSE)

summary(comp_C1vsC3, 
        groupNames = c("Cluster 1", "Cluster 3"),
        showCentr = c("degree", "between", "closeness"), 
        numbNodes = 10)

#C2 Vs C3
net_C2vsC3 <- netConstruct(data = physeqClus_split$`2`,data2=physeqClus_split$`3`, dataType = "counts", group = NULL,
                           matchDesign = NULL, measure = "spieceasi", measurePar = NULL,
                           jointPrepro = NULL, filtTax = "none", filtTaxPar = NULL,
                           filtSamp = "none", filtSampPar = NULL,  zeroMethod = "none",
                           zeroPar = NULL, normMethod = "none", normPar = NULL, sparsMethod = "t-test",
                           thresh = 0.3, alpha = 0.05, adjust = "adaptBH", trueNullMethod = "convest",
                           lfdrThresh = 0.2, nboot = 1000L,  cores = 8,  logFile = "log.txt",
                           softThreshType = "signed",  softThreshPower = NULL, softThreshCut = 0.8,
                           kNeighbor = 3L, knnMutual = FALSE,  dissFunc = "signed",  dissFuncPar = NULL,
                           simFunc = NULL, simFuncPar = NULL,  scaleDiss = TRUE, weighted = TRUE,
                           sampleSize = NULL,  verbose = 2, seed = NULL)

props_C2VsC3 <- netAnalyze(net_C2vsC3, 
                           centrLCC = FALSE,
                           avDissIgnoreInf = TRUE,
                           sPathNorm = FALSE,
                           clustMethod = "cluster_fast_greedy",
                           hubPar = c("degree", "between", "closeness"),
                           hubQuant = 0.9,
                           lnormFit = TRUE,
                           normDeg = FALSE,
                           normBetw = FALSE,
                           normClose = FALSE,
                           normEigen = FALSE)


#Properties comparison
comp_C2vsC3 <- netCompare(props_C1VsC2, permTest = FALSE, verbose = FALSE)

summary(comp_C2vsC3, 
        groupNames = c("Cluster 2", "Cluster 3"),
        showCentr = c("degree", "between", "closeness"), 
        numbNodes = 10)

