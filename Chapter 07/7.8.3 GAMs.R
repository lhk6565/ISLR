# Chapter 07 Moving Beyond Linearity
## 7.8 Lab: Non-linear Modeling

### 7.8.3 GAMs

gam1 = lm(wage ~ ns(year, 4) + ns(age, 5) + education, data = Wage)

library(gam)
gam.m3 = gam(wage ~ s(year, 4) + s(age, 5) + education, data = Wage)

par(mfrow = c(1, 3))
plot(gam.m3, se = TRUE, col = 'blue')

plot.Gam(gam1, se = TRUE, col = 'red')

gam.m1 = gam(wage ~ s(age, 5) + education, data = Wage)
gam.m2 = gam(wage ~ year + s(age, 5) + education, data = Wage)
anova(gam.m1, gam.m2, gam.m3, test = 'F')

summary(gam.m3)

preds = predict(gam.m2, newdata = Wage)

gam.lo = gam(
  wage ~ s(year, df = 4) + lo(age, span = 0.7) + education, data = Wage
)
plot.Gam(gam.lo, se = TRUE, col = 'green')

gam.lo.i = gam(wage ~ lo(year, age, span = 0.5) + education, data = Wage)

library(akima)
plot(gam.lo.i)

gam.lr = gam(
  I(wage > 250) ~ year + s(age, df = 5) + education,
  family = binomial, data = Wage
)
par(mfrow = c(1, 3))
plot(gam.lr, se = T, col = 'green')

table(education, I(wage > 250))

gam.lr.s = gam(
  I(wage > 250) ~ year + s(age, df = 5) + education,
  family = binomial, data = Wage, subset = (education != '1. < HS Grad')
)
plot(gam.lr.s, se = T, col = 'green')