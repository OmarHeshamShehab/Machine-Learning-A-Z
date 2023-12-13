setwd("E:/Courses/Machine-Learning-A-Z/R/Part 4 - Clustering/Section 27 - Hierarchical") # nolint

# Importing the dataset
dataset <- read.csv("mall.csv")
x <- dataset[4:5]
# using dendogram to find optimal number of clusters
dendogram <- hclust(dist(x, method = "euclidean"), method = "ward.D")
plot(dendogram,
  main = paste("Dendogram"),
  xlab = "Customer", ylab = "euclidean"
)
# fitting Hierarchical Clustering to the mall dataset
hc <- hclust(dist(x, method = "euclidean"), method = "ward.D")
y_hc <- cutree(hc, 5)

# Visualising the clusters
library(cluster)
clusplot(
  x = x,
  clus = y_hc,
  lines = 0,
  shade = TRUE,
  color = TRUE,
  labels = 2,
  plotchar = FALSE,
  span = TRUE,
  main = paste("Clusters of customers using Hierarchical Cluster"),
  xlab = "Annual Income",
  ylab = "Spending Score"
)
