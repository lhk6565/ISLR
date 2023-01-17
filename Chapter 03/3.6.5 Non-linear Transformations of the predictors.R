# Chapter 03 Linear Regression
## 3.6 Lab: Linear Regression

### 3.6.5 Non-linear Transformations of the Predictors

lm.fit2 = lm(medv ~ lstat + I(lstat^2))
summary(lm.fit2)

lm.fit = lm(medv ~ lstat)
anova(lm.fit, lm.fit2)

par(mfrow= c(2, 2))
plot(lm.fit2)

lm.fit5 = lm(medv ~ poly(lstat, 5))
summary(lm.fit5)

summary(lm(medv ~ log(rm), data = Boston))