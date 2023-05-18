#setwd("Z:/Vitiligo") #for university 
setwd("~/Documents/Informaticks/Vitiligo/Scripts") #for home 

#BiocManager::install("affy")
#BiocManager::install("genefilter")
#BiocManager::install("hgu133plus2.db")
#BiocManager::install("GOstats")
library(affy)
library(genefilter)
library(hgu133plus2.db)
library(GOstats)
library(RColorBrewer)
#read all CEL files in the folder
raw_data <- ReadAffy()
norm_data <- rma(raw_data) # correct, normalize and calculate expression

tt = rowttests(norm_data) # t test

hist(tt$p.value) #cheaking 
length(which(tt$p.value<0.000000000001)) 

tt <- cbind(tt, Symbol = unlist(mget(rownames(tt),
                                     hgu133plus2SYMBOL)), Description = unlist(mget(rownames(tt),
                                                                                    hgu133plus2GENENAME)))

# there are some NA in symbols here

head(tt[order(tt$p.value),])
# filter and make expression set again 
norm_data_filt <- nsFilter(norm_data, remove.dupEntrez=TRUE)
norm_data_filt <- norm_data_filt$eset

# bonferroni method 
tt <- cbind(tt, p.value.corrected = p.adjust(tt$p.value,
                                             method='bonf'))
length(which(tt$p.value.corrected<0.05))


tt <- sort(tt$p.value.corrected,)

subset(tt, tt$p.value.corrected[1:500], drop = FALSE)

tt$p.value.corrected[1:500]
# draw a cart
dat<-exprs(norm_data)[rownames(tt)[tt$p.value.corrected<0.05],]
rownames(dat)<-tt[match(rownames(dat), rownames(tt)),"Symbol"]
rbpal <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
rbpal <- rev(rbpal)
#pat.col<-as.character()
#pat.col[pat.col=="NEG"]="black"
#pat.col[pat.col=="BCR/ABL"]="red"
library(gplots)
heatmap.2(dat, col=rbpal, trace="none",density.info="none")
heatmap.2(dat)
