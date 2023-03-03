# Chapter 13 Multiple Testing
## 13.6 Lab: Multiple Testing

### 13.6.2 The Family-Wise Error Rate

m <- 1:500
fwe1 <- 1 - (1 - 0.05)^m
fwe2 <- 1 - (1 - 0.01)^m
fwe3 <- 1 - (1 - 0.001)^m

par(mfrow = c(1, 1))
plot(m, fwe1, type = 'l', log = 'x', ylim = c(0, 1), col = 2,
     ylab = 'Family - Wise Error Rate',
     xlab = 'Number of Hypotheses')
lines(m, fwe2, col = 4)
lines(m, fwe3, col = 3)
abline(h = 0.05, lty = 2)

library(ISLR2)
fund.mini <- Fund[, 1:5]
t.test(fund.mini[, 1], mu = 0)
fund.pvalue <- rep(0, 5)
for (i in 1:5){
  fund.pvalue[i] <- t.test(fund.mini[, i], mu = 0)$p.value
}
fund.pvalue

p.adjust(fund.pvalue, method = 'bonferroni')
pmin(fund.pvalue * 5, 1)

p.adjust(fund.pvalue, method = 'holm')

apply(fund.mini, 2, mean)

t.test(fund.mini[, 1], fund.mini[, 2], paired = T)

returns <- as.vector(as.matrix(fund.mini))
manager <- rep(c('1', '2', '3', '4', '5'), rep(50, 5))
a1 <- aov(returns ~ manager)
TukeyHSD(x = a1)

plot(TukeyHSD(x = a1))