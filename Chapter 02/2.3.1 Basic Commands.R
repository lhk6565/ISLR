# Chapter 02 Statistical Learning
## 2.3 Lab: Introduction to R

### 2.3.1 Basic Commands

x = c(1, 3, 2, 5)
x

x = c(1, 6, 2)
x

y = c(1, 4, 3)

length(x)
length(y)

x + y

ls()
rm(x, y)

ls()
rm(list = ls())

x = matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2)
x

x = matrix(c(1, 2, 3, 4), 2, 2)
x

matrix(c(1, 2, 3, 4), 2, 2 , byrow = TRUE)

sqrt(x)
x^2

x = rnorm(50)
y = x + rnorm(50, mean = 50, sd = .1)
cor(x, y)

set.seed(1303)
rnorm(50)

set.seed(3)
y = rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)