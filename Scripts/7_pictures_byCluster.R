#Load library
library(tidyverse)

#Percentage of pictures in each photovoice theme by cluster 

#Set Colors
paletaDonut <- MetBrewer::met.brewer("Degas",n=4)
donutCol <- as.character(paletaDonut) 

#Cluster 1
donutC1 <- data.frame(
  group=c("#Balance", "#Foodie", "#MindfulEating", "#Wellnes"),
  count=c(9, 9, 12,5)
)

# Compute percentages
donutC1$fraction <- donutC1$count / sum(donutC1$count)

# Compute the cumulative percentages (top of each rectangle)
donutC1$ymax <- cumsum(donutC1$fraction)

# Compute the bottom of each rectangle
donutC1$ymin <- c(0, head(donutC1$ymax, n=-1))

# Compute label position
donutC1$labelPosition <- (donutC1$ymax + donutC1$ymin) / 2

# Compute a good label
donutC1$label <- paste0(donutC1$group, "\n value: ", donutC1$count)

# Make the plot
ggplot(donutC1, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=group)) +
  geom_rect() +
  scale_fill_manual(values = donutCol)+
  coord_polar(theta="y") +
  xlim(c(-1, 4)) +
  theme_void() +
  theme(legend.position = "right") + ggtitle ("Cluster 1") 

#Cluster 2
donutC2 <- data.frame(
  group=c("#Balance", "#Foodie", "#MindfulEating", "#Wellnes"),
  count=c(8, 6, 7,4)
)

# Compute percentages
donutC2$fraction <- donutC2$count / sum(donutC2$count)

# Compute the cumulative percentages (top of each rectangle)
donutC2$ymax <- cumsum(donutC2$fraction)

# Compute the bottom of each rectangle
donutC2$ymin <- c(0, head(donutC2$ymax, n=-1))

# Compute label position
donutC2$labelPosition <- (donutC2$ymax + donutC2$ymin) / 2

# Compute a good label
donutC2$label <- paste0(donutC1$group, "\n value: ", donutC2$count)

# Make the plot
ggplot(donutC2, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=group)) +
  geom_rect() +
  scale_fill_manual(values = donutCol)+
  coord_polar(theta="y") +
  xlim(c(-1, 4)) +
  theme_void() +
  theme(legend.position = "right") + ggtitle ("Cluster 2") 

#Cluster 3
donutC3 <- data.frame(
  group=c("#Balance", "#Foodie", "#MindfulEating", "#Wellnes"),
  count=c(1, 1, 0,2)
)

# Compute percentages
donutC3$fraction <- donutC3$count / sum(donutC3$count)

# Compute the cumulative percentages (top of each rectangle)
donutC3$ymax <- cumsum(donutC3$fraction)

# Compute the bottom of each rectangle
donutC3$ymin <- c(0, head(donutC3$ymax, n=-1))

# Compute label position
donutC3$labelPosition <- (donutC3$ymax + donutC3$ymin) / 2

# Compute a good label
donutC3$label <- paste0(donutC1$group, "\n value: ", donutC3$count)

# Make the plot
ggplot(donutC3, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=group)) +
  geom_rect() +
  scale_fill_manual(values = donutCol)+
  coord_polar(theta="y") +
  xlim(c(-1, 4)) +
  theme_void() +
  theme(legend.position = "right") + ggtitle ("Cluster 3") 
