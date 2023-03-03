# Chapter 13 Multiple Testing
## 13.6 Lab: Multiple Testing

### 13.6.3 The False Discovery Rate

fund.pvalues <- rep(0, 2000)
for (i in 1:2000){
  fund.pvalues[i] <- t.test(Fund[, i], mu = 0)$p.value
}

q.values.BH <- p.adjust(fund.pvalues, method = 'BH')
q.values.BH[1:10]

sum(q.values.BH <= 0.1)

sum(fund.pvalues <= (0.1 / 2000))

ps <- sort(fund.pvalues)
m <- length(fund.pvalues)
q <- 0.1
wh.ps <- which(ps < q * (1:m) / m)
if (length(wh.ps) > 0){
  wh <- 1:max(wh.ps)
} else {
  wh <- numeric(0)
}

plot(ps, log = 'xy', ylim = c(4e-6, 1), ylab = 'P-Value',
     xlab = 'Index', main = '')
points(wh, ps[wh], col = 4)
abline(a = 0, b = (q / m), col = 2, untf = TRUE)
abline(h = 0.1 / 2000, col = 3)