# Importing Data Set
dataset <- read.csv("Salary_Data.csv")

# Splitting dataset into training set & test set
# install.packages('caTools') # nolint: commented_code_linter.
library(caTools)
set.seed(123)
split <- sample.split(dataset$Salary, SplitRatio = 2 / 3)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

# Fitting Simple Linear Regression to Training set
regressor <- lm(
  formula = Salary ~ YearsExperience,
  data = training_set
)
# install.packages('ggplot2') # nolint: commented_code_linter.
# predicting the test set results
y_pred <- predict(regressor, newdata = test_set)
# Visualizing the Training set results
# line 24 we use training as i am visualizing the result of
# the salary of training set
library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = training_set$YearsExperience, y = predict(regressor,
      newdata = training_set
    )),
    colour = "blue"
  ) +
  ggtitle("Salary vs Experience (Training set)") +
  xlab("Years of experience") +
  ylab("Salary")

# Visualizing the Test set results
# what i did understood is that the training what the model is built on
# so we didn't change in line 36
# Visualising the Test set results
library(ggplot2)
ggplot() +
  geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
    colour = "red"
  ) +
  geom_line(
    aes(x = training_set$YearsExperience, y = predict(regressor,
      newdata = training_set
    )),
    colour = "blue"
  ) +
  ggtitle("Salary vs Experience (Test set)") +
  xlab("Years of experience") +
  ylab("Salary")
