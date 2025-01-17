#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("limma")

library(limma)

expFile="symbol.txt"                                         #表达数据文件
cliFile="time.txt"                                           #临床数据文件
geneFile="intersectGenes.txt"                                #基因列表文件
setwd("C:\\Users\\lexb4\\Desktop\\TMEimmune\\21.preCox")     #工作目录（需修改）

#读取表达文件，并对输入文件整理
rt=read.table(expFile,sep="\t",header=T,check.names=F)
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
data=data[rowMeans(data)>0,]

#读取基因列表
gene=read.table(geneFile,header=T,sep="\t",check.names=F)
data=data[as.vector(gene[,1]),]

#删掉正常样品
group=sapply(strsplit(colnames(data),"\\-"),"[",4)
group=sapply(strsplit(group,""),"[",1)
group=gsub("2","1",group)
data=data[,group==0]
colnames(data)=gsub("(.*?)\\-(.*?)\\-(.*?)\\-(.*?)\\-.*","\\1\\-\\2\\-\\3",colnames(data))
data=t(data)
data=avereps(data)

#读取生存数据
cli=read.table(cliFile,sep="\t",check.names=F,header=T,row.names=1)     #读取临床文件

#数据合并并输出结果
sameSample=intersect(row.names(data),row.names(cli))
data=data[sameSample,]
cli=cli[sameSample,]
out=cbind(cli,data)
out=cbind(id=row.names(out),out)
write.table(out,file="expTime.txt",sep="\t",row.names=F,quote=F)


######生信自学网: https://www.biowolf.cn/
######课程链接1: https://shop119322454.taobao.com
######课程链接2: https://ke.biowolf.cn
######课程链接3: https://ke.biowolf.cn/mobile
######光俊老师邮箱：seqbio@foxmail.com
######光俊老师微信: seqBio
