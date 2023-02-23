# Chapter 10 Deep Learning
## 10.9 Lab: Deep Learning

### 10.9.2 A Multilayer Network on the MNIST Digit Data

mnist <- dataset_mnist()
x_train <- mnist$train$x
g_train <- mnist$train$y
x_test <- mnist$test$x
g_test <- mnist$test$y
dim(x_train)
dim(x_test)

x_train <- array_reshape(x_train, c(nrow(x_train), 784))
x_test <- array_reshape(x_test, c(nrow(x_test), 784))
y_train <- to_categorical(g_train, 10)
y_test <- to_categorical(g_test, 10)

x_train <- x_train / 255
x_test <- x_test / 255
modelnn <- keras_model_sequential()
modelnn %>%
  layer_dense(units = 256, activation = 'relu', input_shape = c(784)) %>%
  layer_dropout(rate = 0.4) %>%
  layer_dense(units = 128, activation = 'relu') %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 10, activation = 'softmax')
summary(modelnn)

modelnn %>% compile(loss = 'categorical_crossentropy',
                    optimizer = optimizer_rmsprop(), metrics = c('accuracy'))

system.time(
  history <- modelnn %>%
    fit(x_train, y_train, epochs = 30, batch_size = 128, validation_split = 0.2)
)
plot(history, smooth = FALSE)

# 'predict_classes()' is removed from tensorflow in version 2.6.
# in 'accuracy()' function should change 'pred' to numeric
# also change 'predict(x)' to 'predict(x) %>% k_argmax()' in softmax activation
accuracy <- function(pred, truth){
  mean(drop(as.numeric(pred)) == drop(truth))
}
modelnn %>% predict(x_test) %>% k_argmax() %>% accuracy(g_test)

modellr <- keras_model_sequential() %>%
  layer_dense(input_shape = 784, units = 10, activation = 'softmax')
summary(modellr)

modellr %>% compile(loss = 'categorical_crossentropy',
                    optimizer = optimizer_rmsprop(), metrics = c('accuracy'))
modellr %>% fit(x_train, y_train, epochs = 30, batch_size = 128,
                validation_split = 0.2)
modelnn %>% predict(x_test) %>% k_argmax() %>% accuracy(g_test)