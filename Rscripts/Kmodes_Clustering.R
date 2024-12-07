# Loading relevant libraries
library(dplyr)
library(ggplot2)
library(klaR) #for k-modes clustering
library(Rtsne) #using Rtsne as FactoMinR and factoextra are not downloadable: some issue with the dependencies
library(umap)
library(fastDummies) # for one hot encoding

# K-Modes clustering

edges_subset <- read.csv("/home/rstudio/work/my_611_data_science_project/derived_data/edges_subset.csv")
nodes_subset <- read.csv("/home/rstudio/work/my_611_data_science_project/derived_data/nodes_subset.csv")

# Merging edges and nodes datasets on the "category" column
combined_data <- edges_subset %>%
  inner_join(nodes_subset, by = c("subject"="id"))

# Convert all columns to factors
combined_data <- combined_data %>%
  mutate(across(everything(), as.factor))

# Prepare data for clustering
# Select relevant columns for clustering
clustering_data <- combined_data %>%
  dplyr::select(predicate,aggregator_knowledge_source,primary_knowledge_source,xref,symbol)

# Convert all selected columns to factors (if not already factors)
clustering_data <- clustering_data %>%
  mutate(across(everything(), as.factor))

# Determine optimal number of clusters using the "simple matching" dissimilarity measure
wss <- c() # Initialize within-cluster sum of squares

for (k in 2:10) {
  km <- kmodes(clustering_data, modes = k, iter.max = 10, weighted = FALSE)
  wss[k] <- km$withindiff
}

# Plot to find the elbow point
png("figures/elbow_plot.png")
plot(2:10, wss[2:10], type = "b", pch = 19, frame = FALSE,
     xlab = "Number of Clusters",
     ylab = "Within-Cluster Dissimilarity",
     main = "Elbow Method for Optimal k")
dev.off()

#Perform the clustering
# Run k-modes clustering with k = 3(adjust based on elbow plot)
set.seed(123) # For reproducibility
kmodes_result <- kmodes(clustering_data, modes = 3, iter.max = 10, weighted = FALSE)

# View cluster assignments
kmodes_result$cluster

# Add cluster assignments to the original dataset
clustering_data <- clustering_data %>%
  mutate(cluster = as.factor(kmodes_result$cluster))

encoded_data <- dummy_cols(clustering_data, 
                           remove_first_dummy = TRUE, # Avoid dummy variable trap
                           remove_selected_columns = TRUE) # Remove original columns

# Remove duplicate rows
encoded_data_unique <- encoded_data %>%
  distinct()

# Normalize the data (optional but recommended for t-SNE and UMAP)
normalized_data <- as.data.frame(scale(encoded_data_unique))

# One-hot encode all categorical columns in clustering_data
# Run t-SNE on normalized one-hot encoded data
set.seed(123)
tsne_result <- Rtsne(as.matrix(normalized_data), dims = 2, perplexity = 30, verbose = TRUE)

# Create a data frame for visualization
tsne_plot_data <- data.frame(
  X = tsne_result$Y[, 1],
  Y = tsne_result$Y[, 2],
  Cluster = clustering_data$cluster[!duplicated(encoded_data)]
)

# Visualize the t-SNE clusters
png("figures/tsne_plot.png")
ggplot(tsne_plot_data, aes(x = X, y = Y, color = Cluster)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Cluster Visualization Using t-SNE",
       x = "Dimension 1",
       y = "Dimension 2",
       color = "Cluster") +
  theme_minimal()
dev.off()

# Add the cluster labels to the original data
original_data_with_clusters <- clustering_data %>% distinct() %>%
  mutate(tsne_cluster = tsne_plot_data$Cluster)

# Summarize the data within each cluster to understand its characteristics
cluster_summary <- original_data_with_clusters %>%
  group_by(tsne_cluster) %>%
  summarise(across(everything(), ~ paste(unique(.), collapse = ", ")))

# Combine cluster labels with original data
original_data_with_clusters <- clustering_data %>% distinct() %>%
  mutate(cluster = tsne_plot_data$Cluster)

# Calculate feature distribution within clusters
predicate_distribution <- original_data_with_clusters %>%
  group_by(cluster, predicate) %>%
  summarise(count = n(), .groups = "drop") %>%
  mutate(percentage = count / sum(count) * 100)

# Relabel clusters based on categories
# Create a mapping for cluster labels
cluster_labels <- data.frame(
  cluster = c(1, 2, 3, 4), # Replace with your actual cluster IDs
  label = c("Gene associated with condition", "Gene associated with condition", "Causes", "Contributes To")
)

cluster_labels$cluster <- as.factor(cluster_labels$cluster)

# Merge the labels back into the dataset
original_data_with_clusters <- original_data_with_clusters %>%
  left_join(cluster_labels, by = "cluster")

#Update the tsne plot with the labels
png("figures/labelled_tsne_plot.png")
ggplot(tsne_plot_data, aes(x = X, y = Y, color = as.factor(Cluster))) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Cluster Visualization Using t-SNE",
       x = "Dimension 1",
       y = "Dimension 2",
       color = "Cluster") +
  scale_color_manual(values = c("1" = "red", "2" = "blue", "3" = "purple"), # Optional
                     labels = c("Gene associated with condition", "Causes", "Contributes To")) +
  theme_minimal()
dev.off()

# Run UMAP
set.seed(123)
umap_result <- umap(as.matrix(normalized_data))

# Create a data frame for visualization
umap_plot_data <- data.frame(
  X = umap_result$layout[, 1],
  Y = umap_result$layout[, 2],
  Cluster = clustering_data$cluster[!duplicated(encoded_data)]
)

# Visualize the UMAP clusters
png("figures/umap_plot.png")
ggplot(umap_plot_data, aes(x = X, y = Y, color = Cluster)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(title = "Cluster Visualization Using UMAP",
       x = "Dimension 1",
       y = "Dimension 2",
       color = "Cluster") +
  theme_minimal()
dev.off()

# Saving the original_data_with_clusters for further analysis
write.csv(original_data_with_clusters,"/home/rstudio/work/my_611_data_science_project/derived_data/original_data_with_clsuters.csv")