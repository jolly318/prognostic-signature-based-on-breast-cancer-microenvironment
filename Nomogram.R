install.packages("rms")
#加载安装包
library(rms)
library(foreign)
library(survival)

#修改自己的工作目录
setwd("D:\\SCI\\2\\shenger\\14.Nomogram\\SEER")
#读取数据
seer<-read.table("seer.txt",header=T,sep="\t")

#将数据转换成因子格式 
seer$age<-factor(seer$age,labels=c("<50","50-59","60-69","70-79",">=80"))
seer$pathological_stage<-factor(seer$pathological_stage,labels=c("I","II","III","IV"))
seer$stage_T<-factor(seer$stage_T,labels=c("T1","T2","T3","T4"))
seer$stage_N<-factor(seer$stage_N,labels=c("N0","N1","N2","N3"))
seer$stage_M<-factor(seer$stage_M,labels=c("M0","M1"))
seer$riskscore<-factor(seer$riskscore,labels=c("low","high"))
#将数据打包好
ddist <- datadist(seer)
options(datadist='ddist')

#构建多因素的Cox回归模型
cox <- cph(Surv(survival_time,status) ~age + pathological_stage + stage_T + stage_N + riskscore,surv=T,x=T, y=T,data=seer) 
surv <- Survival(cox)

surv <- Survival(cox)
sur_3_year<-function(x)surv(1*365*3,lp=x)#3年生存
sur_5_year<-function(x)surv(1*365*5,lp=x)#5年生存
nom_sur <- nomogram(cox,fun=list(sur_3_year,sur_5_year),lp= F,funlabel=c('3-Year Survival','5-Year survival'),maxscale=100,fun.at=c('0.9','0.8','0.7','0.6','0.5','0.4','0.3','0.2','0.1'))

#画列线图
pdf("nom.pdf")
plot(nom_sur,xfrac=0.25)
dev.off()

