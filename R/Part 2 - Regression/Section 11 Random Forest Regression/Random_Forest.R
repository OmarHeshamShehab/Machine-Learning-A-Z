setwd("D:/Courses/Machine-Learning-A-Z/R/Part 2 - Regression/Section 11 Random Forest Regression") # nolint
# importing dataset

dataset <- read.csv("Position_Salaries.csv")
dataset <- dataset[2:3]

# Fitting Random Forest Regression to dataset

library(randomForest)
set.seed(1234)
regressor <- randomForest(
  x = dataset[1], # datadrame
  y = dataset$Salary, # vector
  ntree = 500
)
# predicting the result

y_pred <- predict(regressor, data.frame(Level = 6.5))
View(y_pred)

# Visualising the Random Forest Regression

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
  ggtitle("Truth or Bluff (Random Forest Regression)") +
  xlab("Level") +
  ylab("Salary")
