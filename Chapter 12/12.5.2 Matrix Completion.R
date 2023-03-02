# Chapter 12 Unsupervised Learning
## 12.5 Lab: Unsupervised Learning

### 12.5.2 Matrix Completion

X <- data.matrix(scale(USArrests))
pcob <- prcomp(X)
summary(pcob)

sX <- svd(X)
names(sX)
round(sX$v, 3)

pcob$rotation

t(sX$d * t(sX$u))
pcob$x

nomit <- 20
set.seed(15)
ina <- sample(seq(50), nomit)
inb <- sample(1:4, nomit, replace = TRUE)
Xna <- X
index.na <- cbind(ina, inb)
Xna[index.na] <- NA

fit.svd <- function(X, M = 1){
  svdob <- svd(X)
  with(svdob,
       u[, 1:M, drop = FALSE] %*% (d[1:M] * t(v[, 1:M, drop = FALSE])))
}

Xhat <- Xna
xbar <- colMeans(Xna, na.rm = TRUE)
Xhat[index.na] <- xbar[inb]

thresh <- 1e-7
rel_err <- 1
iter <- 0
ismiss <- is.na(Xna)
mssold <- mean((scale(Xna, xbar, FALSE)[!ismiss])^2)
mss0 <- mean(Xna[!ismiss]^2)

while(rel_err > thresh){
  iter <- iter + 1
  # Step 2(a)
  Xapp <- fit.svd(Xhat, M = 1)
  # Step 2(b)
  Xhat[ismiss] <- Xapp[ismiss]
  # Step 2(c)
  mss <- mean(((Xna - Xapp)[!ismiss])^2)
  rel_err <- (mssold - mss) / mss0
  mssold <- mss
  cat('Iter:', iter, 'MSS:', mss, 'Rel. Err:', rel_err, '\n')
}

cor(Xapp[ismiss], X[ismiss])