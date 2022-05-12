###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056
#install.packages("VennDiagram")

library(VennDiagram)                                           #引用包
setwd("C:\\Users\\lexb4\\Desktop\\tcgaEstimate\\16.venn")      #设置工作目录

#上调venn图
files=c("StromalUp.txt","ImmuneUp.txt")
targetList=list()
for(i in 1:length(files)){
    inputFile=files[i]
    rt=read.table(inputFile,header=T)
    header=unlist(strsplit(inputFile,"Up|\\.|\\-"))
    targetList[[header[1]]]=as.vector(rt[,1])
    uniqLength=length(unique(as.vector(rt[,1])))
    print(paste(header[1],uniqLength,sep=" "))
}
venn.diagram(targetList,filename="up.tiff",imagetype = "tiff",main="Up",main.cex = 2,
             fill=rainbow(length(targetList)),cat.cex=1)
upGenes=Reduce(intersect,targetList)

#下调venn图
files=c("StromalDown.txt","ImmuneDown.txt")
targetList=list()
for(i in 1:length(files)){
    inputFile=files[i]
    rt=read.table(inputFile,header=T)
    header=unlist(strsplit(inputFile,"Down|\\.|\\-"))
    targetList[[header[1]]]=as.vector(rt[,1])
    uniqLength=length(unique(as.vector(rt[,1])))
    print(paste(header[1],uniqLength,sep=" "))
}
venn.diagram(targetList,filename="down.tiff",imagetype = "tiff",main="Down",main.cex = 2,
             fill=rainbow(length(targetList)),cat.cex=1)
downGenes=Reduce(intersect,targetList)

#输出交集基因
upGenes=cbind(upGenes,"up")
downGenes=cbind(downGenes,"down")
intersectGenes=rbind(upGenes,downGenes)
colnames(intersectGenes)=c("Gene","Regulation")
write.table(file="intersectGenes.txt",intersectGenes,sep="\t",quote=F,row.names=F)

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056