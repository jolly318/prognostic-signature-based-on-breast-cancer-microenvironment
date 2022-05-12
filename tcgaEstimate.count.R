###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056

setwd("C:\\Users\\lexb4\\Desktop\\tcgaEstimate\\21.barplot")       #设置工作目录
rt=read.table("string_interactions.tsv", header=T, sep="\t", comment.char = "", check.names =FALSE)
tb=table(c(as.vector(rt[,1]),as.vector(rt[,2])))
tb=sort(tb,decreasing =T)
write.table(tb,file="count.xls",sep="\t",quote=F,col.names=F)

n=as.matrix(tb)[1:30,]   #定义可视化的基因数目
pdf(file="barplot.pdf",width=8,height=6)
par(mar=c(3,10,3,3),xpd=T)
bar=barplot(n,horiz=TRUE,col="skyblue",names=FALSE)
text(x=n-0.5,y=bar,n)
text(x=-0.2,y=bar,label=names(n),xpd=T,pos=2)
dev.off()

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056