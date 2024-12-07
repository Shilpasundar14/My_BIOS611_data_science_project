# Loading libraries
library(dplyr)
library(utils)

# Loading the data for analysis
data <- readRDS("/home/rstudio/work/my_611_data_science_project/data/monarch_kg.rds")

# Creating a subset of the data for analysis - The original data set is huge
edges_subset <- data$edges %>% filter(category==c("biolink:CausalGeneToDiseaseAssociation","biolink:CorrelatedGeneToDiseaseAssociation"))
nodes_subset <- data$nodes %>% filter(in_taxon_label==c("Mus musculus","Homo sapiens"))

# Saving the data subset for further analysis
write.csv(edges_subset,"/home/rstudio/work/my_611_data_science_project/derived_data/edges_subset.csv")
write.csv(nodes_subset,"/home/rstudio/work/my_611_data_science_project/derived_data/nodes_subset.csv")
