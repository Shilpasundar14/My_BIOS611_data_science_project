install.packages("readr")
library(readr)
untar("data/monarch-kg.tar.gz", exdir="data") 

nodes <- read_table("data/monarch-kg_nodes.tsv")
edges <- read_table("data/monarch-kg_edges.tsv")
saveRDS(list(nodes=nodes, edges=edges),"data/monarch_kg.rds")