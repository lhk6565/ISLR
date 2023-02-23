# Chapter 10 Deep Learning
## 10.9 Lab: Deep Learning

### 10.9.1 A Single Layer Network on the Hitters Data

library(ISLR2)
Gitters = na.omit(Hitters)
n = nrow(Gitters)
set.seed(13)
ntest = trunc(n / 3)
testid = sample(1:n, ntest)

lfit = lm(Salary ~ ., data = Gitters[-testid, ])
lpred = predict(lfit, Gitters[testid, ])
with(Gitters[testid, ], mean(abs(lpred - Salary)))

x = scale(model.matrix(Salary ~ . -1, data = Gitters))
y = Gitters$Salary

library(glmnet)
cvfit = cv.glmnet(x[-testid, ], y[-testid],
                  type.measure = 'mae')
cpred = predict(cvfit, x[testid, ], s = 'lambda.min')
mean(abs(y[testid] - cpred))

library(keras)
library(dplyr)
modnn = keras_model_sequential() %>%
  layer_dense(units = 50, activation = 'relu', input_shape = ncol(x)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 1)

x = scale(model.matrix(Salary ~ . -1, data = Gitters))

x = model.matrix(Salary ~ . -1, data = Gitters) %>% scale()

modnn %>% compile(loss = 'mse',
                  optimizer = optimizer_rmsprop(),
                  metrics = list('mean_absolute_error'))

history = modnn %>% fit(x[-testid, ], y[-testid], epochs = 1500, batch_size = 32,
                        validation_data = list(x[testid, ], y[testid]))

plot(history)

npred = predict(modnn, x[testid, ])
mean(abs(y[testid] - npred))