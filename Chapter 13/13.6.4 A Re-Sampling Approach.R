# Chapter 13 Multiple Testing
## 13.6 Lab: Multiple Testing

### 13.6.4 A Re-Sampling Approach

attach(Khan)
x <- rbind(xtrain, xtest)
y <- c(as.numeric(ytrain), as.numeric(ytest))
dim(x)
table(y)

x <- as.matrix(x)
x1 <- x[which(y == 2), ]
x2 <- x[which(y == 4), ]
n1 <- nrow(x1)
n2 <- nrow(x2)
t.out <- t.test(x1[, 11], x2[, 11], var.equal = TRUE)
TT <- t.out$statistic
TT
t.out$p.value

set.seed(1)
B <- 10000
Tbs <- rep(NA, B)
for (b in 1:B){
  dat <- sample(c(x1[, 11], x2[, 11]))
  Tbs[b] <- t.test(dat[1:n1], dat[(n1 + 1):(n1 + n2)], var.equal = TRUE)$statistic
}
mean((abs(Tbs) >= abs(TT)))

hist(Tbs, breaks = 100, xlim = c(-4.2, 4.2), main ='',
     xlab = 'Null Distribution of Test Statistic', col = 7)
lines(seq(-4.2, 4.2, len = 1000),
      dt(seq(-4.2, 4.2, len = 1000), df = (n1 + n2 -2)) * 1000, col = 2, lwd = 3)
abline(v = TT, col = 4, lwd = 2)
text(TT + 0.5, 350, paste('T = ', round(TT, 4), sep = ''), col = 4)

m <- 100
set.seed(1)
index <- sample(ncol(x1), m)
Ts <- rep(NA, m)
Ts.star <- matrix(NA, ncol = m, nrow = B)
for (j in 1:m){
  k <- index[j]
  Ts[j] <- t.test(x1[, k], x2[, k], var.equal = TRUE)$statistic
  for (b in 1:B){
    dat <- sample(c(x1[, k], x2[, k]))
    Ts.star[b, j] <- t.test(dat[1:n1], dat[(n1 + 1):(n1 + n2)],
                            var.equal = TRUE)$statistic
  }
}

cs <- sort(abs(Ts))
FDRs <- Rs <- Vs <- rep(NA, m)
for (j in 1:m){
  R <- sum(abs(Ts) >= cs[j])
  V <- sum(abs(Ts.star) >= cs[j]) / B
  Rs[j] <- R
  Vs[j] <- V
  FDRs[j] <- V / R
}

max(Rs[FDRs <= 0.1])
sort(index[abs(Ts) >= min(cs[FDRs < 0.1])])
max(Rs[FDRs <= .2])
sort(index[abs(Ts) >= min(cs[FDRs < .2])])

plot(Rs, FDRs, xlab = 'Number of Rejections', type = 'l',
     ylab = 'False Discovery Rate', col = 4, lwd = 3)