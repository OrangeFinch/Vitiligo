#setwd("Z:/Vitiligo") for university 
setwd("~/Documents/Informaticks/Vitiligo/Scripts") #for home 
BiocManager::install("affy")
library(affy)
#read all CEL files in the folder
data <- ReadAffy()
#Normalize the data
eset <- rma(data)
#Save the data to an output file to be used by other programs(Data will be log2 transformed and normalized)
GeneExp = exprs(eset)
#Load annotation Library
#BiocManager::install("hgu133plus2.db")
library(hgu133plus2.db)
#Only keep the ENTREZID, GENE NAME and GENE Symbol
tab = select(hgu133plus2.db, keys = keys(hgu133plus2.db), columns = c("ENTREZID","GENENAME","SYMBOL"))
#Getting mean of multiple affy Id mapping to the same GENE
exprSet = t(sapply(split(tab[,1], tab[,4]), function(ids){
  colMeans(GeneExp[ids,,drop=FALSE])
}))
# Check out all our conditions
C_name <- colnames(exprSet)