setwd("E:/Courses/Machine-Learning-A-Z/R/Part 2 - Regression/Section 7 Multiple Linear Regression") # nolint
# importing the dataset

dataset <- read.csv("50_Startups.csv")

# Encoding categorical data
dataset$State <- factor(dataset$State,
  levels = c("New York", "California", "Florida"),
  labels = c(1, 2, 3)
)

# splitting data into Training & Test set
library(caTools)
set.seed(123)
# the split ratio here give 80to training True goes train set and false test set
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)
# view datasets
View(dataset)
View(training_set)
View(test_set)
# fitting mulitple linear regression to training set
# regressor <- lm(formula = Profit ~ R.D.Spend + Administration #nolint
#+ Marketing.Spend + State) # nolint 23,24 could be replaced by below
regressor <- lm(formula = Profit ~ ., data = training_set) # nolint
summary(regressor)
# based on * we pick below as it highly impacts profit
# regressor <- lm(formula = Profit ~ R.D.Spend, data = training_set) # nolint
# Predicting the Test set results
y_predict <- predict(regressor, newdata = test_set)
y_predict
# building the optimal model using backward elimination
# taking all dataset to recognize with independent value to use
regressor <- lm(
  formula = Profit ~ R.D.Spend # nolint
  , data = dataset
) # nolint 23,24
summary(regressor)
