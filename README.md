🌟 Analysis and Prediction of Cubic Zirconia Prices

Overview

This project explores the factors influencing the price of cubic zirconia gemstones using regression models and decision trees. It leverages the dataset from Kaggle, which contains various attributes related to the physical and qualitative characteristics of cubic zirconia.

Dataset

The dataset consists of the following attributes:

carat: Weight of the gemstone.

cut: Quality of the gemstone's cut (Fair, Good, Very Good, Premium, Ideal).

color: Color classification (D to J, where D is the best).

clarity: Measures inclusions/blemishes (FL is flawless, I3 is the lowest quality).

depth: Depth percentage.

table: Table width percentage.

price: The price of the gemstone (dependent variable).

x, y, z: Length, width, and height of the gemstone (in mm).

Project Structure

1. gemstone.R - Regression Analysis

Loads and cleans the dataset by removing irrelevant columns (depth) and renaming x, y, z to length, width, height.

Converts categorical variables (cut, color, clarity) into factors.

Conducts exploratory data analysis (EDA) using density plots and scatter plots.

Implements multiple regression models:

Linear regression for each variable (carat, cut, color, clarity, etc.).

Multiple linear regression to predict prices based on all available features.

Evaluates models using RMSE (Root Mean Square Error) and confidence intervals.

Predicts the price of new gemstones based on input characteristics.

2. arbori.R - Decision Tree Model

Uses rpart to build decision trees for price prediction.

Splits the dataset into training (70%) and testing (30%).

Performs hyperparameter tuning on minsplit and maxdepth to optimize the tree.

Visualizes decision trees using rpart.plot.

Evaluates model performance with RMSE and R².

Key Findings

Carat has the strongest influence on price, showing a significant positive correlation.

Cut and clarity play a minor role in price prediction.

Decision trees provide an intuitive structure but perform slightly worse than regression models.

The final linear regression model explains 92% of price variation (R² = 0.9208) and achieves an RMSE of 1133.
