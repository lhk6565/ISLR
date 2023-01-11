# Chapter 02 Statistical Learning
## 2.3 Lab: Introduction to R

### 2.3.5 Additinal Graphical and Numerical Summaries

plot(cylinders, mpg)

plot(Auto$cylinders, Auto$mpg)
attach(Auto)
plot(cylinders, mpg)

cylunders = as.factor(cylinders)

plot(cylinders, mpg)
plot(cylinders, mpg, col = 'red')
plot(cylinders, mpg, col = 'red', varwidth = T)
plot(cylinders, mpg, col = 'red', varwidth = T,
     horizontal = T)
plot(cylinders, mpg, col = 'red', varwidth = T,
     xlab = 'cylinders', ylab = 'MPG')

hist(mpg)
hist(mpg, col = 2)
hist(mpg, col = 2, breaks = 15)

pairs(Auto)
pairs(~ mpg + displacement + horsepower + weight + acceleration,
      data = Auto)

plot(horsepower, mpg)
identify(horsepower, mpg, name)

summary(Auto)
summary(mpg)