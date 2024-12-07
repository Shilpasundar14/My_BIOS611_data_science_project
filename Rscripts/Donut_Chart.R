# Loading relevant libraries
library(dplyr)
library(ggplot2)

# Figure 1: Donut chart for the two associations in the edges subset data set

edges_subset <- read.csv("/home/rstudio/work/my_611_data_science_project/derived_data/edges_subset.csv")
nodes_subset <- read.csv("/home/rstudio/work/my_611_data_science_project/derived_data/nodes_subset.csv")

# Summarize data
donut_data <- edges_subset %>%
  group_by(predicate, category) %>%
  summarise(count = n(), .groups = "drop") %>%
  mutate(percentage = count / sum(count) * 100) # Add percentage for labels

# Add an additional column for positioning (layer)
donut_data <- donut_data %>%
  mutate(layer = ifelse(is.na(category), "inner", "outer"))

# Donut chart
png("figures/donut_chart.png")
ggplot(donut_data, aes(x = ifelse(is.na(category), 1, 2), y = count, fill = interaction(predicate, category))) +
  geom_bar(stat = "identity", width = 1, color = "white") + # Create the layers
  coord_polar(theta = "y") + # Make it circular
  theme_void() + # Remove background and axis
  theme(legend.title = element_blank()) + # Remove legend title
  xlim(0.5, 2.5) + # Create the hollow center for the donut
  labs (
    fill = "Predicate and Category",
    title = "Distribution of Gene-to-Disease Association Types") +
  geom_text(data = donut_data %>% filter(!is.na(category)), # Add labels for the outer layer
            aes(label = paste0(round(percentage, 1), "%")),
            position = position_stack(vjust = 0.5),
            color = "black")
dev.off()
