# Chapter 05 Resampling Methods
## 5.3 Lab: Cross-Validation and the Bootstrap

### 5.3.3 k-Fold Cross-Validation

set.seed(17)
cv.error.10 = rep(0, 10)
for(i in 1:10){
  glm.fit = glm(mpg ~ poly(horsepower, i), data = Auto)
  cv.error.10[i] = cv.glm(Auto, glm.fit, K=10)$delta[1]
}
cv.error.10