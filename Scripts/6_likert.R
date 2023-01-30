#Load libraries
library(tidyverse)
library(likert)
library(MetBrewer)  

#My data
valoracion <- read_csv2("DATA/valoracion.csv")

#Rearrange data
#Q5 Topic covered
valoracion$`Topics covered aroused your interest` <- factor(valoracion$`Topics covered aroused your interest`,
                                                            levels = c("1", "2", "3", "4", "5"), 
                                                            labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                       "Agree", "Strongly agree"))

#Q4 Photovoice
valoracion$`Photovoice activity was useful` <- factor(valoracion$`Photovoice activity was useful`,
                                                      levels = c("1", "2", "3", "4", "5"), 
                                                      labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                 "Agree", "Strongly agree"))


#Q6 Focus groups
valoracion$`Focus group sessions were easy-to-follow` <- factor(valoracion$`Focus group sessions were easy-to-follow`,
                                                                levels = c("1", "2", "3", "4", "5"), 
                                                                labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                           "Agree", "Strongly agree"))


#Q7 Material
valoracion$`The material provided was easy to compliment` <- factor(valoracion$`The material provided was easy to compliment`,
                                                                    levels = c("1", "2", "3", "4", "5"), 
                                                                    labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                               "Agree", "Strongly agree"))

#Q3 Doubts
valoracion$`All your doubts about nutrition, health, and microbiome were solved` <- factor(valoracion$`All your doubts about nutrition, health, and microbiome were solved`,
                                                                                           levels = c("1", "2", "3", "4", "5"), 
                                                                                           labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                                                      "Agree", "Strongly agree"))

#Q2 awarness
valoracion$`You became aware of the importance of maintaining a good diet and leading a healthy lifestyle to prevent diseases.` <- factor(valoracion$`You became aware of the importance of maintaining a good diet and leading a healthy lifestyle to prevent diseases.`,
                                                                                                                                          levels = c("1", "2", "3", "4", "5"), 
                                                                                                                                          labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                                                                                                     "Agree", "Strongly agree"))

#Q1 healthy eating
valoracion$`Your interest in healthy eating has increased` <- factor(valoracion$`Your interest in healthy eating has increased`,
                                                                     levels = c("1", "2", "3", "4", "5"), 
                                                                     labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                                "Agree", "Strongly agree"))

#Q8 expectations
valoracion$`The project has met your expectations.` <- factor(valoracion$`The project has met your expectations.`,
                                                              levels = c("1", "2", "3", "4", "5"), 
                                                              labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                         "Agree", "Strongly agree"))

#Q9 recommendations
valoracion$`You would recommend participating in the project` <- factor(valoracion$`You would recommend participating in the project`,
                                                                        levels = c("1", "2", "3", "4", "5"), 
                                                                        labels = c("Strongly disagree", "Disagree", "Neither agree nor disagree",
                                                                                   "Agree", "Strongly agree"))


#Likert plot
val <- as.data.frame(valoracion)
like.val <- likert(val)
summary(like.val)
met_pal <- met.brewer("Degas", 5) #Colors with MetBrewer

likert_plot <- plot(like.val,  group.order=names(val), legend.position="right", colors=met_pal, centered=F, 
                    plot.percent.low = T, plot.percent.high = T,
                    plot.percent.neutral = F, text.size = 4) + 
  theme(axis.text.y = element_text(colour="black", size="12", hjust=0)) +
  theme(axis.text.x = element_text(colour="black", size="12")) 

likert_plot
