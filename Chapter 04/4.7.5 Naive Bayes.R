# Chapter 04 Classification Methods
## 4.7 Lab: Classification Methods

### 4.7.5 Naive Bayes

library(e1071)
nb.fit = naiveBayes(Direction ~ Lag1 + Lag2, data = Smarket,
                    subset = train)
nb.fit
mean(Lag1[train][Direction[train] == 'Down'])
sd(Lag1[train][Direction[train] == 'Down'])

nb.class = predict(nb.fit, Smarket.2005)
table(nb.class, Direction.2005)
mean(nb.class == Direction.2005)

nb.preds = predict(nb.fit, Smarket.2005, type = 'raw')
nb.preds[1:5,]