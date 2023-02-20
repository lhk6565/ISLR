# Chapter 08 Tree-Based Methods
## 8.3 Lab: Decision Trees

### 8.3.5 Bayesian Additive Regression Trees

library(BART)
x = Boston[, 1:12]
y = Boston[, 'medv']
xtrain = x[train, ]
ytrain = y[train]
xtest = x[-train, ]
ytest = y[-train]
set.seed(1)
bartfit = gbart(xtrain, ytrain, x.test = xtest)

yhat.bart = bartfit$yhat.test.mean
mean((ytest - yhat.bart)^2)

ord = order(bartfit$varcount.mean, decreasing = T)
bartfit$varcount.mean[ord]