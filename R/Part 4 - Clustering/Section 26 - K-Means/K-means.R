setwd("E:/Courses/Machine-Learning-A-Z/R/Part 4 - Clustering/Section 26 - K-Means") # nolint

# K-Means Clustering

# Importing the dataset
dataset <- read.csv("mall.csv")
x <- dataset[4:5]

# Using the elbow method to find the optimal number of clusters
set.seed(6)
wcss <- vector()
for (i in 1:10) wcss[i] <- sum(kmeans(x, i)$withinss)
plot(
  x = 1:10,
  y = wcss,
  type = "b",
  main = paste("The Elbow Method"),
  xlab = "Number of clusters",
  ylab = "WCSS"
)

# Fitting K-Means to the dataset
set.seed(29)
kmeans <- kmeans(
  x = x,
  centers = 5,
  iter.max = 300,
  nstart = 10
)

# Visualising the clusters
library(cluster)
clusplot(
  x = x,
  clus = kmeans$cluster,
  lines = 0,
  shade = TRUE,
  color = TRUE,
  labels = 2,
  plotchar = FALSE,
  span = TRUE,
  main = paste("Clusters of customers using K-means"),
  xlab = "Annual Income",
  ylab = "Spending Score"
)