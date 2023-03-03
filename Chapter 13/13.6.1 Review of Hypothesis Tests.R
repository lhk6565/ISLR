# Chapter 13 Multiple Testing
## 13.6 Lab: Multiple Testing

### 13.6.1 Review of Hypothesis Tests

set.seed(6)
x <- matrix(rnorm(10 * 100), 10, 100)
x[, 1:50] <- x[, 1:50] + 0.5

t.test(x[, 1], mu = 0)

p.values <- rep(0, 100)
for (i in 1:100){
  p.values[i] <- t.test(x[, i], mu = 0)$p.value
}
decision <- rep('Do not reject H0', 100)
decision[p.values <= 0.05] <- 'Reject H0'
table(decision,
      c(rep('H0 is False', 50), rep('H0 is True', 50))
)

x <- matrix(rnorm(10 * 100), 10, 100)
x[, 1:50] <- x[, 1:50] + 1
for (i in 1:100){
  p.values[i] <- t.test(x[, i], mu = 0)$p.value
}
decision <- rep('Do not reject H0', 100)
decision[p.values <= 0.05] <- 'Reject H0'
table(decision,
      c(rep('H0 is False', 50), rep('H0 is True', 50))
)