#setwd("Z:/Vitiligo") #for university 
setwd("~/Documents/Informaticks/Vitiligo/Scripts") #for home 
exprSet <- read.csv(file = "exprSet.csv", head = TRUE, sep = " ")
exprSet <- as.matrix(exprSet)
#BiocManager::install("genefilter")
library("genefilter")
library("affy")
tt = rowttests(exprSet)
exprSet <- ExpressionSet(exprSet)
hist(tt$p.value)
length(which(tt$p.value<0.05)) # all genes???
head(tt[order(tt$p.value),])
#no_double_exprSet <- nsFilter(exprSet, remove.dupEntrez=TRUE) #doesn't work because it is a matrix
tt <- cbind(tt, p.value.corrected = p.adjust(tt$p.value,
                                             method='bonf'))
length(which(tt$p.value.corrected<0.05)) #all genes again
dat <- exprs(exprSet)[rownames(tt)[tt$p.value.corrected<0.05],]
library("RColorBrewer")
rbpal <- colorRampPalette(brewer.pal(10, "RdBu"))(256)
rbpal <- rev(rbpal)
#install.packages("gplots")
#BiocManager::install("gplots")
library("gplots")
heatmap.2(dat, col=rbpal, trace="none",density.info="none",
          ColSideColors=pat.col)



BiocManager::install("ALL")
library(ALL)
dat <- ALL
sampleinfo <- pData(ALL)
bcell <- grep('B', as.character(ALL$BT))
typerear <- which(as.character(ALL$mol.biol) %in% c("NEG",
                                                    "BCR/ABL"))
intersect(bcell, typerear)
ALL_bcrneg <- ALL[, intersect(bcell, typerear)]
ALL_bcrneg$mol.biol <- droplevels(ALL_bcrneg$mol.biol)
tt = rowttests(ALL_bcrneg, "mol.biol")
hist(tt$p.value)
ALL_bcrneg.filt <- nsFilter(ALL_bcrneg, remove.dupEntrez=TRUE)
ALL_bcrneg.filt <- ALL_bcrneg.filt$eset




