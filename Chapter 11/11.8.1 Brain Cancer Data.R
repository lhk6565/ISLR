# Chapter 11 Survival Analysis and Censored Data
## 11.8 Lab: Survival Analysis

### 11.8.1 Brain Cancer Data

library(ISLR2)

names(BrainCancer)

attach(BrainCancer)
table(sex)
table(diagnosis)
table(status)

library(survival)
fit.surv <- survfit(Surv(time, status) ~ 1)
plot(fit.surv, xlab = 'Months', ylab = 'Estimated Probability of Survival')

fit.sex <- survfit(Surv(time, status) ~ sex)
plot(fit.sex, xlab = 'Months', ylab = 'Estimated Probability of Survival',
     col = c(2,4))
legend('bottomleft', levels(sex), col = c(2,4), lty = 1)

logrank.test <- survdiff(Surv(time, status) ~ sex)
logrank.test

fit.cox <- coxph(Surv(time, status) ~ sex)
summary(fit.cox)

summary(fit.cox)$logtest[1]
summary(fit.cox)$waldtest[1]
summary(fit.cox)$sctest[1]

logrank.test$chisq

fit.all <- coxph(Surv(time, status) ~ sex + diagnosis + loc + ki + gtv + stereo)
fit.all

modaldata <- data.frame(
  diagnosis = levels(diagnosis),
  sex = rep('Female', 4),
  loc = rep('Supratentorial', 4),
  ki = rep(mean(ki), 4),
  gtv = rep(mean(gtv), 4),
  stereo = rep('SRT', 4)
)
survplots <- survfit(fit.all, newdata = modaldata)
plot(survplots, xlab = 'Months', ylab = 'Survival Probability', col = 2:5)
legend('bottomleft', levels(diagnosis), col = 2:5, lty = 1)