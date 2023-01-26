# Chapter 04 Classification Methods
## 4.7 Lab: Classification Methods

### 4.7.1 The Stock Market Data

library('ISLR2')
names(Smarket)
dim(Smarket)
summary(Smarket)

cor(Smarket)
cor(Smarket[,-9])

attach(Smarket)
plot(Volume)