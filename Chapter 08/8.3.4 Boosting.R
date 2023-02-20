# Chapter 08 Tree-Based Methods
## 8.3 Lab: Decision Trees

### 8.3.4 Boosting

library(gbm)
set.seed(1)
boost.boston = gbm(medv ~ ., data = Boston[train, ],
                   distribution = 'gaussian', n.trees = 5000)

summary(boost.boston)

plot(boost.boston, i = 'rm')
plot(boost.boston, i = 'lstat')

yhat.boost = predict(boost.boston, newdata = Boston[-train, ],
                     n.trees = 5000)
mean((yhat.boost - boston.test)^2)

boost.boston = gbm(medv ~ ., data = Boston[train, ],
                   distribution = 'gaussian', n.trees = 5000,
                   interaction.depth = 4, shrinkage = 0.2, verbose = F)
yhat.boost = predict(boost.boston, newdata = Boston[-train, ], n.trees = 5000)
mean((yhat.boost - boston.test)^2)