# Loading relevant libraries
library(dplyr)
library(ggplot2)

# Visualizing the plot for summarizing knowledge source and predicate
original_data_with_clusters <- read.csv("/home/rstudio/work/my_611_data_science_project/derived_data/original_data_with_clsuters.csv")

# Summarize groups by predicate and primary knowledge source
summary_data <- original_data_with_clusters %>%
  group_by(predicate, primary_knowledge_source) %>%
  summarise(count = n(), .groups = "drop") %>%
  arrange(desc(count)) # Arrange by descending count for better readability

# Create a bar plot for the summary data
png("figures/summary_plot.png")
ggplot(summary_data, aes(x = primary_knowledge_source, y = count, fill = predicate)) +
  geom_bar(stat = "identity", width = 0.4) + 
  labs(
    title = "Distribution of Predicates by Primary Knowledge Source",
    x = "Primary Knowledge Source",
    y = "Count",
    fill = "Predicate"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 8)
  ) +
  geom_text(
    aes(label = count),
    vjust = 1.5, # Place text slightly above the bar
    size = 3, # Adjust text size
    color = "black" # Set text color
  )
dev.off()
