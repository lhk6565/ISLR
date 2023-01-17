# Chapter 03 Linear Regression
## 3.6 Lab: Linear Regression

### 3.6.3 Multiple Linear Regression

lm.fit = lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)

lm.fit = lm(medv ~ ., data = Boston)
summary(lm.fit)

library(car)
vif(lm.fit)

lm.fit1 = lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

lm.fit1 = update(lm.fit, ~ . - age)