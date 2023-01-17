# Chapter 03 Linear Regression
## 3.6 Lab: Linear Regression

### 3.6.6 Qualitative Predictors

head(Carseats)

lm.fit = lm(Sales ~ . + Income:Advertising + Price:Age,
            data = Carseats)
summary(lm.fit)

attach(Carseats)
contrasts(ShelveLoc)