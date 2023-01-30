#Load libraries 
library(tidyverse)
library(gtsummary)

#metadata
metadata <- read_csv("Data/metadata.csv")

#All data 
tableALL <- clus_mod %>% column_to_rownames(var="SampleID") %>% 
  select(`F/B`, NivelEd_cod, Age, Gender, IMC, PhysicalAct_total, IAS_Clas, Smoking, Weight_Kg, Ccintura, cObesity,RF_NCD, pRF) %>% 
  tbl_summary(by= NULL, statistic = list(all_continuous() ~ "{mean} ({IQR})",
                                         all_categorical() ~ "{n} ({p}%)"), missing = 'no', 
              list( `F/B`= 'F/B ratio',
                    Age = 'Age (years)',
                    Gender = 'Gender',
                    IMC = 'BMI',
                    NivelEd_cod = 'Nivel Educativo',
                    Ccintura = 'ccintura',
                    Weigth_Kg = 'weight',
                    PhysicalAct_total = 'Physical activity (%)',
                    IAS_Clas = 'HEI classification',
                    Smoking = 'Smoking (%)',
                    cObesity = 'Central Obesity',
                    RF_NCD = 'Risk NCD',
                    `F/B`= 'F/B ratio',
                    pRF = '>1 Risk'))

#Nivel Educativo: 1 - Bachiller, 2 - FP, 3 - Licenciado/gradaudo, 4 - Master o superiot 

tableALL


#Metadata by Cluster 
tableCLUS <- clus_mod %>% column_to_rownames(var="SampleID") %>% 
  select(Cluster, `F/B`, Age, Gender, IMC, PhysicalAct_total, IAS_Clas, Smoking, Weight_Kg, Ccintura, cObesity,RF_NCD, pRF) %>% 
  tbl_summary(by= Cluster, statistic = list(all_continuous() ~ "{mean} ({IQR})",
                                            all_categorical() ~ "{n} ({p}%)"), missing = 'no', 
              list( `F/B`= 'F/B ratio',
                    Age = 'Age (years)',
                    Gender = 'Gender',
                    IMC = 'BMI',
                    Ccintura = 'ccintura',
                    Weigth_Kg = 'weight',
                    PhysicalAct_total = 'Physical activity (%)',
                    IAS_Clas = 'HEI classification',
                    Smoking = 'Smoking (%)',
                    cObesity = 'Central Obesity',
                    RF_NCD = 'Risk NCD',
                    `F/B`= 'F/B ratio',
                    pRF = '>1 Risk')) %>% add_p()



tableCLUS

