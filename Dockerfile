# Use the rocker/rstudio or rocker/verse as the base image
FROM rocker/rstudio:latest

# Update apt, run unminimize with automated 'yes' response, install man-db, and clean up after
RUN apt update && \
    yes | unminimize && \
    apt install -y man-db && \
    rm -rf /var/lib/apt/lists/*

# Expose the necessary port for RStudio
EXPOSE 8787

# Set up environment variables for RStudio (optional)
ENV PASSWORD=yourpassword

# Set the working directory inside the container
WORKDIR /home/rstudio/work

# Install system dependencies for R packages and utilities
RUN apt-get update -y && \
    apt-get install -y \
        curl \
        libxml2-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        build-essential && \
    apt-get clean

# Install R packages from CRAN
RUN R -e "install.packages(c('readr', 'ggplot2', 'dplyr', 'patchwork', 'kableExtra', 'pheatmap', 'R.utils', 'stringr'))"

# Install Bioconductor and GitHub packages
RUN R -e "install.packages('BiocManager')" && \
    R -e "BiocManager::install(c('ComplexHeatmap'))" && \
    R -e "remotes::install_github('griffithlab/GenVisR')"

# Copy project files into the container
COPY src/ /home/rstudio/work/src/
COPY data/ /home/rstudio/work/data/
COPY report.Rmd /home/rstudio/work/

# Set permissions for the working directory
RUN chown -R rstudio:rstudio /home/rstudio/work

# Clean up unnecessary files
RUN rm -rf /var/lib/apt/lists/* /tmp/*
