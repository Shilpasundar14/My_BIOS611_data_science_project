# Use the rocker/rstudio or rocker/verse as the base image
FROM rocker/rstudio:latest

# Update apt, run unminimize with automated 'yes' response, install man-db, and clean up after
# RUN apt update && \
#    yes | unminimize && \
#    apt install -y man-db && \
#   rm -rf /var/lib/apt/lists/*
RUN apt update \
&& apt install vim-tiny libmagick++-dev libudunits2-dev cargo libavfilter-dev libgdal-dev -y \
&& rm -rf /var/lib/apt/lists/*

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
RUN R -e "install.packages(c('ggplot2', 'dplyr', 'klaR', 'Rtsne' , 'umap', 'fastDummies'))"

# Copy project files into the container
# COPY src/ /home/rstudio/work/src/
# COPY data/ /home/rstudio/work/data/
# COPY report.Rmd /home/rstudio/work/

# Set permissions for the working directory
# RUN chown -R rstudio:rstudio /home/rstudio/work

# Clean up unnecessary files
# RUN rm -rf /var/lib/apt/lists/* /tmp/*
