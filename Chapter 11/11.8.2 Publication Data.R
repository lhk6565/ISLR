# Chapter 11 Survival Analysis and Censored Data
## 11.8 Lab: Survival Analysis

### 11.8.2 Publication Data

fit.posres <- survfit(Surv(time, status) ~ posres, data = Publication)
plot(fit.posres, xlab = 'Months', ylab = 'Probability of Not Being Published',
     col = 3:4)
legend('topright', c('Negative Result', 'Positive Result'),
       col = 3:4, lty = 1)

fit.pub <- coxph(Surv(time, status) ~ posres, data = Publication)
fit.pub

logrank.test <- survdiff(Surv(time, status) ~ posres, data = Publication)
logrank.test

fit.pub2 <- coxph(Surv(time, status) ~ . - mech, data = Publication)
fit.pub2