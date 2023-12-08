setwd("E:/Courses/Machine-Learning-A-Z/R/Part 1 - Data Preprocessing/Section 4 Data preprocessing") # nolint
# importing the dataset

dataset <- read.csv("Data.csv")

# splitting data into Training & Test set
# install.packages('caTools') # nolint: commented_code_linter.
library(caTools)
set.seed(123)
# the split ratio here give 80to training True goes train set and false test set
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
# feature scaling
# training_set[, 2:3]<-scale(training_set[, 2:3])# nolint
# test_set[, 2:3]=scale(test_set[, 2:3]) # nolint: commented_code_linter.
View(dataset)
View(training_set)
View(test_set)
