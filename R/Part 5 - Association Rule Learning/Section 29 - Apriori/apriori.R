setwd("E:/Courses/Machine-Learning-A-Z/R/Part 5 - Association Rule Learning/Section 29 - Apriori") # nolint
# Apriori

# Data Preprocessing
library(arules)
dataset <- read.csv("Market_Basket_Optimisation.csv", header = FALSE)
dataset <- read.transactions("Market_Basket_Optimisation.csv",
  sep = ",", rm.duplicates = TRUE
)
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# Training Apriori on the dataset

rules <- apriori(
  data = dataset,
  parameter = list(support = 0.004, confidence = 0.2)
)

# Visualising the results
inspect(sort(rules, by = "lift")[1:10])

# lift measures how much more likely it is for the items to be bought together  # nolint
#compared to what would be expected if their purchase was independent of each other. # nolint: line_length_linter.