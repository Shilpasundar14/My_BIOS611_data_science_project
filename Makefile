.PHONY: clean

# Target to clean intermediate files
clean:
	rm -f *.png
	rm -f *.html
	rm -f figures/*.png
	rm -f derived_data/*.csv

all: Report.html \
		donut_chart.png \
		elbow_plot.png \
		tsne_plots.png \
		labelled_tsne_plot.png \
		summary_plot.png

# Target that downloads the dataset
data/monarch-kg.tar.gz:
	wget https://kg-hub.berkeleybop.io/kg-monarch/20231028/monarch-kg.tar.gz -O data/monarch-kg.tar.gz
	
# Creating the target that produces the rds file from tar.gz download
data/monarch_kg.rds: data/monarch-kg.tar.gz Rscripts/Data_Conversion.R
	Rscript Rscripts/Data_Conversion.R
# Target to build the report (currently empty)
# build:
#	Rscript -e "rmarkdown::render('report.Rmd')" 

# Final Project Report
Report.html:\
						figures/donut_chart.png \
						figures/elbow_plot.png \
						figures/tsne_plot.png \
						figures/laballed_tsne_plot.png \
						figures/umap_plot.png \
						figures/summary_plot.png \
						Report.Rmd
	Rscript -e "rmarkdown::render('Report.Rmd')"

# Create Figures
figures/donut_chart.png: derived_data/nodes_subset.csv derived_data/edges_subset.csv Rscripts/Donut_Chart.R
	Rscript Rscripts/Donut_Chart.R

figures/elbow_plot.png derived_data/original_data_with_clsuters.csv:  derived_data/nodes_subset.csv derived_data/edges_subset.csv  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Kmodes_Clustering.R
	
figures/tsne_plot.png derived_data/original_data_with_clsuters.csv:  derived_data/nodes_subset.csv derived_data/edges_subset.csv  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Kmodes_Clustering.R
	
figures/laballed_tsne_plot.png derived_data/original_data_with_clsuters.csv:  derived_data/nodes_subset.csv derived_data/edges_subset.csv  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Kmodes_Clustering.R
	
figures/umap_plot.png derived_data/original_data_with_clsuters.csv:  derived_data/nodes_subset.csv derived_data/edges_subset.csv  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Kmodes_Clustering.R

figures/summary_plot.png:  derived_data/original_data_with_clsuters.csv Rscripts/Summary_Plot.R
	Rscript  Rscripts/Summary_Plot.R
	