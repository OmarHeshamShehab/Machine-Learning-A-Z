setwd("E:/Courses/Machine-Learning-A-Z/R/Part 2 - Regression/Section 9 Support Vector Regression (SVR)") # nolint
# importing dataset

dataset <- read.csv("Position_Salaries.csv")
dataset <- dataset[2:3]

# Fitting SVR to data set
library(e1071)
regressor <- svm(formula = Salary ~ ., data = dataset, type = "eps-regression")

# predicting the result
y_pred <- predict(regressor, data.frame(Level = 6.5))
View(y_pred)
# Visualising the SVR
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = dataset$Level, y = predict(regressor,
      newdata = dataset
    )),
    colour = "blue"
  ) +
  ggtitle("Salary expectation (SVR)") +
  xlab("Levels") +
  ylab("Salary")
