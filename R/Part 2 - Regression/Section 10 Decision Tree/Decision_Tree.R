setwd("E:/Courses/Machine-Learning-A-Z/R/Part 2 - Regression/Section 10 Decision Tree") # nolint
# importing dataset

dataset <- read.csv("Position_Salaries.csv")
dataset <- dataset[2:3]

# Fitting Decision Tree to data set
library(rpart)
regressor <- rpart(
  formula = Salary ~ ., data = dataset,
  control = rpart.control(minsplit = 1)
)
# predicting the result
y_pred <- predict(regressor, data.frame(Level = 6.5))
View(y_pred)
# Visualising the SVR
library(ggplot2)
x_grid <- seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = x_grid, y = predict(regressor,
      newdata = data.frame(
        Level = x_grid
      )
    )),
    colour = "blue"
  ) +
  ggtitle("Truth or Bluff (Decision Tree Regression)") +
  xlab("Level") +
  ylab("Salary")
