setwd("E:/Courses/Machine-Learning-A-Z/R/Part 10 - Model Selection and Boosting/Section 43 - Model Selection") # nolint
# k-Fold Cross Validation

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

# Feature Scaling
training_set[-3] <- scale(training_set[-3])
test_set[-3] <- scale(test_set[-3])

# Fitting Kernel SVM to the Training set

library(e1071)
classifier <- svm(
     formula = Purchased ~ ., # nolint
     data = training_set,
     type = "C-classification",
     kernel = "radial"
)

# Predicting the Test set results
y_pred <- predict(classifier, newdata = test_set[-3])

# Making the Confusion Matrix
cm <- table(test_set[, 3], y_pred)

# Applying k-Fold Cross Validation

library(caret)
folds <- createFolds(training_set$Purchased, k = 10)
cv <- lapply(folds, function(x) {
     training_fold <- training_set[-x, ] # nolint
     test_fold <- training_set[x, ]
     classifier <- svm(
          formula = Purchased ~ ., # nolint
          data = training_fold,
          type = "C-classification",
          kernel = "radial"
     ) # nolint
     y_pred <- predict(classifier, newdata = test_fold[-3])
     cm <- table(test_fold[, 3], y_pred)
     accuracy <- (cm[1, 1] + cm[2, 2]) / (cm[1, 1] + cm[2, 2] + cm[1, 2] + cm[2, 1]) # nolint: line_length_linter.
     return(accuracy)
})
accuracy <- mean(as.numeric(cv))

# Visualising the Training set results
library(ElemStatLearn)
set <- training_set
x1 <- seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
x2 <- seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set <- expand.grid(x1, x2)
colnames(grid_set) <- c("Age", "EstimatedSalary")
y_grid <- predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = "Kernel SVM (Training set)", # nolint
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(x1), ylim = range(x2)
)
contour(x1, x2, matrix(as.numeric(y_grid), length(x1), length(x2)), add = TRUE)
points(grid_set, pch = ".", col = ifelse(y_grid == 1, "dodgerblue", "salmon"))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, "dodgerblue3", "salmon3"))

# Visualising the Test set results
library(ElemStatLearn)
set <- test_set
x1 <- seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
x2 <- seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set <- expand.grid(x1, x2)
colnames(grid_set) <- c("Age", "EstimatedSalary")
y_grid <- predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = "Kernel SVM (Test set)", # nolint
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(x1), ylim = range(x2)
)
contour(x1, x2, matrix(as.numeric(y_grid), length(x1), length(x2)), add = TRUE)
points(grid_set, pch = ".", col = ifelse(y_grid == 1, "dodgerblue", "salmon"))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, "dodgerblue3", "salmon3"))
