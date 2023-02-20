# Chapter 08 Tree-Based Methods
## 8.3 Lab: Decision Trees

### 8.3.1 Fitting Classification Trees

library(tree)

library(ISLR2)
attach(Carseats)
High = factor(ifelse(Sales <= 8, 'No', 'Yes'))

Carseats = data.frame(Carseats, High)

tree.carseats = tree(High ~ . -Sales, Carseats)
summary(tree.carseats)

plot(tree.carseats)
text(tree.carseats, pretty = 0)

tree.carseats

set.seed(2)
train = sample(1:nrow(Carseats), 200)
Carseats.test = Carseats[-train, ]
High.test = High[-train]
tree.carseats = tree(High ~ . -Sales, Carseats, subset = train)
tree.pred = predict(tree.carseats, Carseats.test, type = 'class')
table(tree.pred, High.test)
(104 + 50) / 200

set.seed(7)
cv.carseats = cv.tree(tree.carseats, FUN = prune.misclass)
names(cv.carseats)
cv.carseats

par(mfrow = c(1, 2))
plot(cv.carseats$size, cv.carseats$dev, type = 'b')
plot(cv.carseats$k, cv.carseats$dev, type = 'b')

prune.carseats = prune.misclass(tree.carseats, best = 9)
plot(prune.carseats)
text(prune.carseats, pretty = 0)

tree.pred = predict(prune.carseats, Carseats.test, type = 'class')
table(tree.pred, High.test)
(97 + 58) / 200

prune.carseats = prune.misclass(tree.carseats, best = 14)
plot(prune.carseats)
text(prune.carseats, pretty = 0)
tree.pred = predict(prune.carseats, Carseats.test, type = 'class')
table(tree.pred, High.test)
(102 + 52) / 200