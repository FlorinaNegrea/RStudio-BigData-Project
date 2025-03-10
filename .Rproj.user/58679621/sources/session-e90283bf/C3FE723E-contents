library(tidyverse)
library(rsample)
library(dplyr)
library(rpart)
library(rpart.plot)
library(caret)

rm(list = ls())

GemStone <- read_csv("cubic_zirconia.csv")
View(GemStone)

GemStone <- GemStone %>%
  mutate(across(c(cut, color, clarity), factor))

names(GemStone)[names(GemStone) == "x"] <- "length"
names(GemStone)[names(GemStone) == "y"] <- "width"
names(GemStone)[names(GemStone) == "z"] <- "height"

set.seed(123)

ggplot(GemStone, aes(x = price)) + 
  geom_density(fill = "blue", alpha = 0.5) +
  geom_density(color = "blue") +
  labs(x = "Pretul zirconiului", y = "Densitate") +
  theme_minimal()

gemstone_split <- initial_split(GemStone, prop = 0.7)
gemstone_train <- training(gemstone_split)
gemstone_test <- testing(gemstone_split)

m1 <- rpart(
  formula = price ~ ., 
  data = gemstone_train,
  method = "anova"
)
m1
rpart.plot(m1)
plotcp(m1)


hyper_grid <- expand.grid(
  minsplit = seq(7, 20, 1),
  maxdepth = seq(6, 13, 1)
)

head(hyper_grid)

models <- list()
for (i in 1:nrow(hyper_grid)) {
  minsplit <- hyper_grid$minsplit[i]
  maxdepth <- hyper_grid$maxdepth[i]
  models[[i]] <- rpart(
    formula = price ~. ,
    data = gemstone_train,
    method = "anova",
    control = list(minsplit = minsplit, maxdepth = maxdepth)
  )
}

get_cp <- function(x) {
  min <- which.min(x$cptable[,"xerror"])
  cp <- x$cptable[min, "CP"]
  return(cp)
}
get_min_error <- function(x) {
  min <- which.min(x$cptable[, "xerror"])
  xerror <- x$cptable[min, "xerror"]
  return(xerror)
}

mutated_grid <- hyper_grid %>%
  mutate(
    cp = purrr::map_dbl(models, get_cp),
    error = purrr::map_dbl(models, get_min_error)
  )  
mutated_grid %>%
  arrange(error) %>%
  top_n(-6, wt=error)


optimal_tree <- rpart(
  formula = price ~ .,
  data = gemstone_train,
  method = "anova",
  control = list(minsplit = 15, maxdepth = 9, cp = 0.01)
)


rpart.plot(optimal_tree)

pred_optimal <- predict(optimal_tree, newdata = gemstone_test)
rmse_optimal <- RMSE(pred = pred_optimal, obs = gemstone_test$price)
print(paste("RMSE al modelului optimal: ", rmse_optimal))

new_data <- gemstone_test[1, ]
prediction <- predict(optimal_tree, newdata = new_data)
cat("Prețul estimat al noului zirconiu cubic este:", prediction, "\n")

actual_values <- gemstone_test$price
mean_actual <- mean(actual_values)
sst <- sum((actual_values - mean_actual)^2)
sse <- sum((actual_values - pred_optimal)^2)
r_squared <- 1 - (sse / sst)
print(paste("R² pentru modelul arborelui de decizie: ", r_squared))
