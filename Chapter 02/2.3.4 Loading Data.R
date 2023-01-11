# Chapter 02 Statistical Learning
## 2.3 Lab: Introduction to R

### 2.3.4 Loading Data

Auto = read.table('Auto.data')
View(Auto)
head(Auto)

Auto = read.csv('Auto.csv', na.strings = '?',
                stringsAsFactors = T)
View(Auto)

dim(Auto)
Auto[1:4, ]

Auto = na.omit(Auto)
dim(Auto)

names(Auto)