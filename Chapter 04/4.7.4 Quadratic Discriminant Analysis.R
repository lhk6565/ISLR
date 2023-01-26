# Chapter 04 Classification Methods
## 4.7 Lab: Classification Methods

### 4.7.4 Quadratic Discriminant Analysis

qda.fit = qda(Direction ~ Lag1 + Lag2, data = Smarket,
              subset = train)
qda.fit

qda.class = predict(qda.fit, Smarket.2005)$class
table(qda.class, Direction.2005)
mean(qda.class == Direction.2005)