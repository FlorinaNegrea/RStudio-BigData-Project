library(tidyverse)
library(dplyr)
library(modelr)

rm(list = ls())


GemStone <-read_csv("cubic_zirconia.csv")
View(GemStone)

GemStone <- GemStone %>%
  select(-...1)

GemStone <- GemStone %>%
  select(-depth)

GemStone <- GemStone %>%
  mutate(across(c(cut, color, clarity), factor))

names(GemStone)[names(GemStone) == "x"] <- "length"
names(GemStone)[names(GemStone) == "y"] <- "width"
names(GemStone)[names(GemStone) == "z"] <- "height"

GemStone %>% 
  select_if(is.numeric) %>%
  gather(metric, value) %>%
  ggplot(aes(value, fill=metric)) +
  geom_density(show.legend = FALSE) +
  facet_wrap(~metric, scales = "free")

set.seed(123)

GemStone %>%
  ggplot(aes(carat, price)) + geom_point() + geom_smooth()

GemStone %>%
  ggplot(aes(cut, price)) + geom_point() + geom_smooth()

GemStone %>%
  ggplot(aes(color, price)) + geom_point() + geom_smooth()

GemStone %>%
  ggplot(aes(clarity, price)) + geom_point() + geom_smooth()


GemStone %>%
  ggplot(aes(table, price)) + geom_point() + geom_smooth()

GemStone %>%
  ggplot(aes(length, price)) + geom_point() + geom_smooth()

GemStone %>%
  ggplot(aes(width, price)) + geom_point() + geom_smooth()

GemStone %>%
  ggplot(aes(height, price)) + geom_point() + geom_smooth()

mod_prices_all <- lm(data=GemStone, price ~ .)
summary(mod_prices_all)

mod_prices_without_table_width <- lm(data = GemStone, price ~ carat + cut +color+clarity+length+height)
summary(mod_prices_without_table_width)

mod_prices_carat <- lm(data=GemStone, price ~ carat)
summary(mod_prices_carat)
confint(mod_prices_carat)  


mod_prices_cut <- lm(data=GemStone, price ~ cut)
summary(mod_prices_cut)

confint(mod_prices_cut)  


mod_prices_color <- lm(data=GemStone, price ~ color)
summary(mod_prices_color)

mod_prices_clarity <- lm(data=GemStone, price ~ clarity)
summary(mod_prices_clarity)


mod_prices_table <- lm(data=GemStone, price ~ table)
summary(mod_prices_table)

mod_prices_length <- lm(data=GemStone, price ~ length)
summary(mod_prices_length)

confint(mod_prices_length)  

mod_prices_width <- lm(data=GemStone, price ~ width)
summary(mod_prices_width)

confint(mod_prices_width)  


mod_prices_height <- lm(data=GemStone, price ~ height)
summary(mod_prices_height)

confint(mod_prices_height)  


gemstones <- tibble(
  carat = 0.48,
  cut = "Very Good",
  color = "D",
  clarity = "IF",
  length = 5.08,
  height = 3.09,
)

predict(mod_prices_without_table_width, newdata = gemstones, interval = "confidence")
predict(mod_prices_without_table_width, newdata = gemstones, interval = "prediction")

predicted_prices <- predict(mod_prices_without_table_width, newdata = GemStone)
actual_prices <- GemStone$price
rmse <- sqrt(mean((predicted_prices - actual_prices)^2))


print(paste("RMSE pentru modelul 'mod_prices_without_table_width':", rmse))
