setwd("E:/Courses/Machine-Learning-A-Z/R/Part 2 - Regression/Section 8 Polynomial Regression") # nolint
# importing dataset

dataset <- read.csv("Position_Salaries.csv")
dataset <- dataset[2:3]

# Fitting Linear Regression to data set
lin_reg <- lm(formula = Salary ~ ., data = dataset)
summary(linreg)
# Fitting Polynomial Regression to data set
dataset$Level2 <- dataset$Level^2
dataset$Level3 <- dataset$Level^3
dataset$Level4 <- dataset$Level^4
poly_reg <- lm(formula = Salary ~ ., data = dataset)
summary(poly_reg)
View(dataset)
# Visualising the Linear Regression

library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = dataset$Level, y = predict(lin_reg,
      newdata = dataset
    )),
    colour = "blue"
  ) +
  ggtitle("Salary expectation (Linear regression)") +
  xlab("Levels") +
  ylab("Salary")

# Visualising the Polynomial Linear Regression
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = dataset$Level, y = predict(poly_reg,
      newdata = dataset
    )),
    colour = "blue"
  ) +
  ggtitle("Salary expectation (Polynomial Linear regression)") +
  xlab("Levels") +
  ylab("Salary")
# Visualising the Polynomial Linear Regression
# smooth curve line 50
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
    colour = "red"
  ) +
  geom_line(aes(x = dataset$Level, y = predict(poly_reg, newdata = dataset)),
    colour = "blue"
  ) +
  ggtitle("Truth or Bluff (Polynomial Regression)") +
  xlab("Level") +
  ylab("Salary")

# Visualising the Regression Model results  smoother curve
library(ggplot2)
x_grid <- seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level, y = dataset$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = x_grid, y = predict(poly_reg,
      newdata = data.frame(
        Level = x_grid,
        Level2 = x_grid^2,
        Level3 = x_grid^3,
        Level4 = x_grid^4
      )
    )),
    colour = "blue"
  ) +
  ggtitle("Truth or Bluff (Polynomial Regression)") +
  xlab("Level") +
  ylab("Salary")
# Predicting new result with Linear Regression
linear_pred <- predict(lin_reg, data.frame(Level = 6.5))
View(linear_pred)
# Predicting new result with Polynomial Regression
poly_pred <- predict(poly_reg, data.frame(
  Level = 6.5,
  Level2 = 6.5^2,
  Level3 = 6.5^3,
  Level4 = 6.5^4
))
View(poly_pred)
