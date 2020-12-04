library(tidyverse)
library(R.matlab)
library(gridExtra)

diagCov <- readMat("Repositories/RP_edinburgh_master/PMR/go_players_skill_model/diag_covar.mat")
fullCov <- readMat("Repositories/RP_edinburgh_master/PMR/go_players_skill_model/full_covar.mat")

attach(diagCov)
s = seq(-2,4, by = .01)

alpha_go <- dnorm(s, approx.mean[alpha.go.id], sqrt(approx.covar[alpha.go.id]))
ke_jie <- dnorm(s, approx.mean[ke.jie.id], sqrt(approx.covar[ke.jie.id]))
lee_sedol <- dnorm(s, approx.mean[lee.sedol.id], sqrt(approx.covar[lee.sedol.id]))

diagcov_df <- data.frame(s, alpha_go, ke_jie, lee_sedol) %>% 
  gather(player, skill, -s)
  
p1 <- diagcov_df %>% 
  ggplot(aes(x = s, y = skill, group = player, color = player))+
  geom_line() +
  labs(title = "Distributions with diagCov")+
  theme_bw()
detach(diagCov)
attach(fullCov)
s = seq(-2,4, by = .01)

alpha_go <- dnorm(s, approx.mean[alpha.go.id], sqrt(approx.covar[alpha.go.id, alpha.go.id]))
ke_jie <- dnorm(s, approx.mean[ke.jie.id], sqrt(approx.covar[ke.jie.id, ke.jie.id]))
lee_sedol <- dnorm(s, approx.mean[lee.sedol.id], sqrt(approx.covar[lee.sedol.id, lee.sedol.id]))

fullcov_df <- data.frame(s, alpha_go, ke_jie, lee_sedol) %>% 
  gather(player, skill, -s)

p2 <- fullcov_df %>% 
  ggplot(aes(x = s, y = skill, group = player, color = player))+
  geom_line() +
  labs(title = "Distributions with fullCov")+
  theme_bw()
detach(fullCov)
  
grid.arrange(p1, p2)