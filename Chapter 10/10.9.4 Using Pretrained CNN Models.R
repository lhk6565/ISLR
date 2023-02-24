# Chapter 10 Deep Learning
## 10.9 Lab: Deep Learning

### 10.9.4 Using Pretrained CNN Models

img_dir <- 'book_images'
image_names <- list.files(img_dir)
num_images <- length(image_names)
x <- array(dim = c(num_images, 224, 224, 3))
for (i in 1:num_images){
  img_path <- paste(img_dir, image_names[i], sep = '/')
  img <- image_load(img_path, target_size = c(224, 224))
  x[i,,, ] <- image_to_array(img)
}
x <- imagenet_preprocess_input(x)

model <- application_resnet50(weights = 'imagenet')
summary(model)

pred6 <- model %>% predict(x) %>% imagenet_decode_predictions(top = 3)
names(pred6) <- image_names
print(pred6)