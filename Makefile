# Define directories
DATA_DIR = data
FIGURES_DIR = figures

# Target to clean intermediate files
clean:
	rm -rf $(DATA_DIR)/* $(FIGURES_DIR)/*

# Target to build the report (currently empty)
build:
	Rscript -e "rmarkdown::render('report.Rmd')"

data/monarch-kg_edges.tsv data/monarch-kg_nodes.tsv:
	mkdir -p data
	wget https://kg-hub.berkeleybop.io/kg-monarch/20231028/monarch-kg.tar.gz
	tar -xvf monarch-kg.tar.gz
	rm monarch-kg.tar.gz
	mv monarch-kg_edges.tsv monarch-kg_nodes.tsv data/   