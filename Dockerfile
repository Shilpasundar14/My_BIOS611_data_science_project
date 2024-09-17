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

