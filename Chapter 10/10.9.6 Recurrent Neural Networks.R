# Chapter 10 Deep Learning
## 10.9 Lab: Deep Learning

### 10.9.6 Recurrent Neural Networks

# Sequential Models for Document Classification
wc <- sapply(x_train, length)
median(wc)
sum(wc <= 500) / length(wc)

maxlen <- 500
x_train <- pad_sequences(x_train, maxlen = maxlen)
x_test <- pad_sequences(x_test, maxlen = maxlen)
dim(x_train)
dim(x_test)
x_train[1, 490:500]

model <- keras_model_sequential() %>%
  layer_embedding(input_dim = 10000, output_dim = 32) %>%
  layer_lstm(units = 32) %>%
  layer_dense(units = 1, activation = 'sigmoid')

model %>% compile(optimizer = 'rmsprop', loss = 'binary_crossentropy',
                  metrics = c('acc'))
history <- model %>% fit(x_train, y_train, epochs = 10, batch_size = 128,
                         validation_data = list(x_test, y_test))
plot(history)
predy <- predict(model, x_test) > 0.5
mean(abs(y_test == as.numeric(predy)))

# Time Series Prediction
library(ISLR2)
xdata <- data.matrix(NYSE[, c('DJ_return', 'log_volume', 'log_volatility')])
istrain <- NYSE[, 'train']
xdata <- scale(xdata)

lagm <- function(x, k = 1){
  n <- nrow(x)
  pad <- matrix(NA, k, ncol(x))
  rbind(pad, x[1:(n - k), ])
}

arframe <- data.frame(log_volume = xdata[, 'log_volume'],
                      L1 = lagm(xdata, 1), L2 = lagm(xdata, 2),
                      L3 = lagm(xdata, 3), L4 = lagm(xdata, 4),
                      L5 = lagm(xdata, 5))
arframe <- arframe[-(1:5), ]
istrain <- istrain[-(1:5)]

arfit <- lm(log_volume ~ ., data = arframe[istrain, ])
arpred <- predict(arfit, arframe[!istrain, ])
V0 <- var(arframe[!istrain, 'log_volume'])
1 - mean((arpred - arframe[!istrain, 'log_volume'])^2) / V0

arframed <- data.frame(day = NYSE[-(1:5), 'day_of_week'], arframe)
arfitd <- lm(log_volume ~ ., data = arframed[istrain, ])
arpredd <- predict(arfitd, arframed[!istrain, ])
1 - mean((arpredd - arframe[!istrain, 'log_volume'])^2) / V0

n <- nrow(arframe)
xrnn <- data.matrix(arframe[, -1])
xrnn <- array(xrnn, c(n, 3, 5))
xrnn <- xrnn[,, 5:1]
xrnn <- aperm(xrnn, c(1, 3, 2))
dim(xrnn)

model <- keras_model_sequential() %>%
  layer_simple_rnn(units = 12, input_shape = list(5, 3), dropout = 0.1,
                   recurrent_dropout = 0.1) %>%
  layer_dense(units = 1)
model %>% compile(optimizer = optimizer_rmsprop(), loss = 'mse')

history <- model %>% fit(xrnn[istrain,, ], arframe[istrain, 'log_volume'],
                         batch_size = 64, epochs = 200,
                         validation_data = list(xrnn[!istrain,, ], arframe[!istrain, 'log_volume']))
kpred <- predict(model, xrnn[!istrain,, ])
1 - mean((kpred - arframe[!istrain, 'log_volume'])^2) / V0

model <- keras_model_sequential() %>%
  layer_flatten(input_shape = c(5, 3)) %>%
  layer_dense(units = 1)

x <- model.matrix(log_volume ~ . -1, data = arframed)  
colnames(x)

arnnd <- keras_model_sequential() %>%
  layer_dense(units = 32, activation = 'relu', input_shape = ncol(x)) %>%
  layer_dropout(rate = 0.5) %>%
  layer_dense(units = 1)
arnnd %>% compile(loss = 'mse', optimizer = optimizer_rmsprop())
history <- arnnd %>% fit(x[istrain, ], arframe[istrain, 'log_volume'],
                         epochs = 100, batch_size = 32,
                         validation_data = list(x[!istrain, ], arframe[!istrain, 'log_volume']))
plot(history)
npred <- predict(arnnd, x[!istrain, ])
1 - mean((arframe[!istrain, 'log_volume'] - npred)^2) / V0