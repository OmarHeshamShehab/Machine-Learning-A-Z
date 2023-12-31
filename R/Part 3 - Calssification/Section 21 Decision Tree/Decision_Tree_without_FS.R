setwd("E:/Courses/Machine-Learning-A-Z/R/Part 3 - Calssification/Section 21 Decision Tree") # nolint

# Importing the dataset
dataset <- read.csv("Social_Network_Ads.csv")
dataset <- dataset[3:5]

# Encoding the target feature as factor
dataset$Purchased <- factor(dataset$Purchased, levels = c(0, 1))

# Splitting the dataset into the Training set and Test set
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)


# Fitting Decision Tree Classification to the Training set

library(rpart)
classifier <- rpart(formula = Purchased ~ ., data = training_set)

# Predicting the Test set results
y_pred <- predict(classifier, newdata = test_set[-3], type = "class")

# Making the Confusion Matrix
cm <- table(test_set[, 3], y_pred)

# Plotting the tree
plot(classifier)
text(classifier)
