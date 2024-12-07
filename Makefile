.PHONY: clean

# Target to clean intermediate files
clean:
	rm -f *.png
	rm -f *.html
	rm -f figures/*.png
	rm -rf derived_data/

all: Report.html \
		donut_chart.png \
		elbow_plot.png \
		tsne_plots.png \
		labelled_tsne_plot.png \
		summary_plot.png

# Target to build the report (currently empty)
# build:
#	Rscript -e "rmarkdown::render('report.Rmd')" 

# Final Project Report

Report.html: Rscripts/Data_Preparation.R \
						Rscripts/Donut_Chart.R \
						Rscripts/Kmodes_Clustering.R \
						Rscripts/Summary_Plot.R\
						Report.Rmd
	Rscript Rscripts/Data_Preparation.R
	Rscript Rscripts/Donut_Chart.R
	Rscript Rscripts/Kmodes_Clustering.R
	Rscript Rscripts/Summary_Plot.R
	Rscript -e "rmarkdown::render('Report.Rmd')"

# Create Figures

donut_chart.png: Rscripts/Data_Preparation.R Rscripts/Donut_Chart.R
	Rscript Rscripts/Data_Preparation.R
	Rscript Rscripts/Donut_Chart.R

elbow_plot.png:  Rscripts/Data_Preparation.R  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Data_Preparation.R
	Rscript  Rscripts/Kmodes_Clustering.R
	
tsne_plot.png:  Rscripts/Data_Preparation.R  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Data_Preparation.R
	Rscript  Rscripts/Kmodes_Clustering.R
	
laballed_tsne_plot.png:  Rscripts/Data_Preparation.R  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Data_Preparation.R
	Rscript  Rscripts/Kmodes_Clustering.R
	
umap_plot.png:  Rscripts/Data_Preparation.R  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Data_Preparation.R
	Rscript  Rscripts/Kmodes_Clustering.R

summary_plot.png:  Rscripts/Data_Preparation.R  Rscripts/Kmodes_Clustering.R  Rscripts/Summary_Plot.R
	Rscript  Rscripts/Data_Preparation.R
	Rscript  Rscripts/Kmodes_Clustering.R
	Rscript  Rscripts/Summary_Plot.R
	