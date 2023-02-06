# Chapter 06 Linear Model Selection and Regularization
## 6.5 Lab: Linear Models and Regularization Methods

### 6.5.3 PCR and PLS Regression

# Principal Components Regression
library(pls)
set.seed(2)
pcr.fit = pcr(Salary ~ ., data = Hitters, scale = TRUE,
              validation = 'CV')

summary(pcr.fit)

validationplot(pcr.fit, val.type = 'MSEP')

set.seed(1)
pcr.fit = pcr(Salary ~ ., data = Hitters, subset = train,
              scale = TRUE, validation = 'CV')
validationplot(pcr.fit, val.type = 'MSEP')

pcr.pred = predict(pcr.fit, x[test, ], ncomp = 5)
mean((pcr.pred - y.test)^2)

pcr.fit = pcr(y ~ x, scale = TRUE, ncomp = 5)
summary(pcr.fit)

# Partial Least Squares
set.seed(1)
pls.fit = plsr(Salary ~., data = Hitters, subset = train,
               scale = TRUE, validation = 'CV')
summary(pls.fit)
validationplot(pls.fit, val.type = 'MSEP')

pls.pred = predict(pls.fit, x[test, ], ncomp = 1)
mean((pls.pred - y.test)^2)

pls.fit = plsr(Salary ~ ., data = Hitters, scale = TRUE,
               ncomp = 1)
summary(pls.fit)