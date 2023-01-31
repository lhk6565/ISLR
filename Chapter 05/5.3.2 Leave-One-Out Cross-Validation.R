# Chapter 05 Resampling Methods
## 5.3 Lab: Cross-Validation and the Bootstrap

### 5.3.2 Leave-One-Out Cross-Validation

glm.fit = glm(mpg ~ horsepower, data = Auto)
coef(glm.fit)

lm.fit = glm(mpg ~ horsepower, data = Auto)
coef(lm.fit)

library(boot)
glm.fit = glm(mpg ~ horsepower, data = Auto)
cv.err = cv.glm(Auto, glm.fit)
cv.err$delta

cv.error = rep(0, 10)
for(i in 1:10){
  glm.fit = glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error[i] = cv.glm(Auto, glm.fit)$delta[1]
}
cv.error