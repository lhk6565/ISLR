# Chapter 04 Classification Methods
## 4.7 Lab: Classification Methods

### 4.7.6 K-Nearest Neighbors

library(class)
train.X = cbind(Lag1, Lag2)[train, ]
test.X = cbind(Lag1, Lag2)[!train, ]
train.Direction = Direction[train]

set.seed(1)
knn.pred = knn(train.X, test.X, train.Direction, k=1)
table(knn.pred, Direction.2005)
(83+43) / 252

knn.pred = knn(train.X, test.X, train.Direction, k=3)
table(knn.pred, Direction.2005)
mean(knn.pred == Direction.2005)

dim(Caravan)
attach(Caravan)
summary(Purchase)
348 / 5822

standardized.X = scale(Caravan[, -86])
var(Caravan[,1])
var(Caravan[,2])
var(standardized.X[,1])
var(standardized.X[,2])

test = 1:1000
train.X = standardized.X[-test,]
test.X = standardized.X[test,]
train.Y = Purchase[-test]
test.Y = Purchase[test]
set.seed(1)
knn.pred = knn(train.X, test.X, train.Y, k=1)
mean(test.Y != knn.pred)
mean(test.Y != 'No')

table(knn.pred, test.Y)
10 / (66+10)

knn.pred = knn(train.X, test.X, train.Y, k=3)
table(knn.pred, test.Y)
5 / 25

knn.pred = knn(train.X, test.X, train.Y, k=5)
table(knn.pred, test.Y)
4 / 15

glm.fits = glm(Purchase ~ ., data = Caravan,
               family = binomial, subset = -test)
glm.probs <- predict (glm.fits , Caravan[test , ],
                      type = "response")
glm.pred <- rep ("No", 1000)
glm.pred[glm.probs > .5] <- " Yes "
table (glm.pred , test.Y)

glm.pred <- rep ("No", 1000)
glm.pred[glm.probs > .25] <- " Yes "
table (glm.pred , test.Y)
11 / (22 + 11)