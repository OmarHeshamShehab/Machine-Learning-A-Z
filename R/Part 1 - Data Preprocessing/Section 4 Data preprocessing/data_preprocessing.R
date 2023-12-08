setwd("E:/Courses/Machine-Learning-A-Z/R/Part 1 - Data Preprocessing/Section 4 Data preprocessing") # nolint
# importing the dataset

dataset <- read.csv("Data.csv")

# taking care of missing data
# first line checks the conditions whether true or false if true data is missing
# execute the second line if not execute the third line
dataset$Age <- ifelse(is.na(dataset$Age),
  ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
  dataset$Age
)

dataset$Salary <- ifelse(is.na(dataset$Salary),
  ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
  dataset$Salary
)

# Encoding categorical data
dataset$Country <- factor(dataset$Country,
  levels = c("France", "Spain", "Germany"),
  labels = c(1, 2, 3)
)
dataset$Purchased <- factor(dataset$Purchased,
  levels = c("No", "Yes"),
  labels = c(0, 1)
)
# splitting data into Training & Test set
# install.packages('caTools') # nolint: commented_code_linter.
library(caTools)
set.seed(123)
# the split ratio here give 80to training True goes train set and false test set
split <- sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
# feature scaling
training_set[, 2:3] <- scale(training_set[, 2:3])
test_set[, 2:3] <- scale(test_set[, 2:3])
View(dataset)
View(training_set)
View(test_set)
