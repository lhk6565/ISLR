# Chapter 10 Deep Learning
## 10.9 Lab: Deep Learning

### 10.9.5 IMDb Document Classification

max_features <- 10000
imdb <- dataset_imdb(num_words = max_features)
c(c(x_train, y_train), c(x_test, y_test)) %<-% imdb

x_train[[1]][1:12]

word_index <- dataset_imdb_word_index()
decode_review <- function(text, word_index){
  word <- names(word_index)
  idx <- unlist(word_index, use.names = FALSE)
  word <- c('<PAD>', 'START', '<UNK>', '<UNUSED>', word)
  idx <- c(0:3, idx + 3)
  words <- word[match(text, idx, 2)]
  paste(words, collapse = ' ')
}
decode_review(x_train[[1]][1:12], word_index)

library(Matrix)
one_hot <- function(sequences, dimension){
  seqlen <- sapply(sequences, length)
  n <- length(seqlen)
  rowind <- rep(1:n, seqlen)
  colind <- unlist(sequences)
  sparseMatrix(i = rowind, j = colind, dims = c(n, dimension))
}

x_train_1h <- one_hot(x_train, 10000)
x_test_1h <- one_hot(x_test, 10000)
dim(x_train_1h)
nnzero(x_train_1h) / (25000 * 10000)

set.seed(3)
ival <- sample(seq(along = y_train), 2000)

library(glmnet)
fitlm <- glmnet(x_train_1h[-ival, ], y_train[-ival], family = 'binomial',
                standardize = FALSE)
classlmv <- predict(fitlm, x_train_1h[ival, ]) > 0
acclmv <- apply(classlmv, 2, accuracy, y_train[ival] > 0)

par(mar = c(4, 4, 4, 4), mfrow = c(1, 1))
plot(-log(fitlm$lambda), acclmv)

model <- keras_model_sequential() %>%
  layer_dense(units = 16, activation = 'relu', input_shape = c(10000)) %>%
  layer_dense(units = 16, activation = 'relu') %>%
  layer_dense(units = 1, activation = 'sigmoid')
model %>% compile(optimizer = 'rmsprop', loss = 'binary_crossentropy',
                  metrics = c('accuracy'))
history <- model %>% fit(x_train_1h[-ival, ], y_train[-ival], epochs = 20, batch_size = 512,
                         validation_data = list(x_train_1h[ival, ], y_train[ival]))

history <- model %>% fit(x_train_1h[-ival, ], y_train[-ival], epochs = 20,
                         batch_size = 512, validation_data = list(x_test_1h, y_test))