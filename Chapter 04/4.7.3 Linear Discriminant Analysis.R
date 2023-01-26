# Chapter 04 Classification Methods
## 4.7 Lab: Classification Methods

### 4.7.3 Linear Discriminant Analysis

library(MASS)
lda.fit = lda(Direction ~ Lag1 + Lag2, data = Smarket,
              subset = train)
lda.fit
plot(lda.fit)

lda.pred = predict(lda.fit, Smarket.2005)
names(lda.pred)

lda.class = lda.pred$class
table(lda.class, Direction.2005)
mean(lda.class == Direction.2005)

sum(lda.pred$posterior[,1] >= 0.5)
sum(lda.pred$posterior[,1] < 0.5)

lda.pred$posterior[1:20,1]
lda.class[1:20]

sum(lda.pred$posterior[,1] > 0.9)