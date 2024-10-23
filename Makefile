# Define directories
DATA_DIR = data
FIGURES_DIR = figures

# Target to clean intermediate files
clean:
    rm -rf $(DATA_DIR)/* $(FIGURES_DIR)/*

# Target to build the report (currently empty)
build:
    Rscript -e "rmarkdown::render('report.Rmd')"

