###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056
#install.packages("pheatmap")

setwd("C:\\Users\\lexb4\\Desktop\\tcgaEstimate\\15.ImmuneHeatmap")      #设置工作目录
rt=read.table("heatmap.txt",sep="\t",header=T,row.names=1,check.names=F)    #读取文件
rt=log2(rt+0.001)
outpdf="heatmap.pdf"

library(pheatmap)
Type=read.table("type.txt",sep="\t",header=T,row.names=1,check.names=F)

pdf(outpdf,height=14,width=16)
pheatmap(rt, annotation=Type, 
         color = colorRampPalette(c("green", "black", "red"))(50),
         cluster_cols =F,
         fontsize=14,
         fontsize_row=1,
         fontsize_col=3)
dev.off()

###Video source: http://study.163.com/provider/1026136977/index.htm?share=2&shareId=1026136977
######Video source: http://www.biowolf.cn/shop/
######生信自学网: http://www.biowolf.cn/
######合作邮箱：2749657388@qq.com
######答疑微信: 18520221056