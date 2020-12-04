library(tidyverse)
library(R.matlab)

diagCov <- readMat("Repositories/RP_edinburgh_master/PMR/go_players_skill_model/diag_covar.mat")
fullCov <- readMat("Repositories/RP_edinburgh_master/PMR/go_players_skill_model/full_covar.mat")

attach(diagCov)
# vector x_k
x_k = rep(0, n.players)
x_k[alpha.go.id] = 1/sqrt(2)
x_k[ke.jie.id] = -1/sqrt(2)

val_diag <- (approx.mean%*%as.matrix(x_k))/
  sqrt((t(as.matrix(x_k))%*%diag(c(approx.covar))%*%as.matrix(x_k))+1)
pnorm(val_diag)
detach(diagCov)

attach(fullCov)
# vector x_k
x_k = rep(0, n.players)
x_k[alpha.go.id] = 1/sqrt(2)
x_k[ke.jie.id] = -1/sqrt(2)

val_ful <- (approx.mean%*%as.matrix(x_k))/
  sqrt((t(as.matrix(x_k))%*%approx.covar%*%as.matrix(x_k))+1)
pnorm(val_ful)
detach(fullCov)