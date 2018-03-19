# EdgeR code for the creation of KEGG abundance plots.
source("http://www.bioconductor.org/biocLite.R")
biocLite("edgeR")
library(edgeR)
 
data <- read.delim("keggTable.txt", row.names=1, header=T)
#Create DGEList object with groups for the treatments C and T
group <- c(rep("C", 10) , rep("T", 10))
cds <- DGEList(data , group = group)
 
#Filter out genes with low counts, keeping those rows where the count
#per million (cpm) is at least 1 in at least 6 samples:
keep <- rowSums(cpm(cds)>1) >=6
cds <- cds[keep,]
 
#Normalize
cds <- calcNormFactors(cds)
cds <- estimateCommonDisp( cds)
cds <- estimateTagwiseDisp(cds , prior.df = 10)
 
#Draw the MDS plot
plotMDS(cds , main = "MDS Plot for Count Data", labels = colnames(cds$counts))
 
#Find Differentially Expressed genes
DEgenes <-  exactTest(cds , pair = c("C" , "T"))
summary( decideTestsDGE (DEgenes, p.value = 0.05 ) )
DEgene.table <- topTags( de.tgw , n = nrow(DEgenes$table))$table
write.table(DEgene.table, file = "DEgenes.csv" , sep = "," , row.names = TRUE )
