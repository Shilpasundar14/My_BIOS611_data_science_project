# MONARCH KNOWLEDGE GRAPH ANALYSIS PROJECT

------------------------------------------------------------

## Project Overview

This is a part of my PhD biostatistics course BIOS 611: Introduction to Data Science. This project aims to analyze a biomedical knowledge graph comprising nodes and edges, representing relationships between entities such as genes and diseases. Each node and edge have specific attributes that provide detailed information about the entities and their interactions. The primary focus is on analyzing the data, testing the relationships between genes and diseases, and exploring patterns of gene-disease associations using clustering techniques. The hypothesis is that certain genes may cluster around specific diseases based on shared attributes such as cross-references (Xref) and taxonomic labels. The goal here is to identify clusters of genes associated with diseases, potentially revealing shared biological functions or pathways. The approach followed here is to use clustering algorithms (e.g.: K-means, hierarchical clustering) to visualize the results with heat maps, dendrograms, and scatter plots.


## About the Dataset

The dataset is from the Monarch Initiative, an international consortium recognized for its leadership in advancing key global standards and semantic data integration technologies. Its resources and integrated data serve as a foundational framework for numerous downstream applications and diverse contexts. The aim of the consortium is to accelerate precision medicine through open source. More about that here: https://monarchinitiative.org/.


### Key insights about the knowledge graph dataset

* The nodes represent biological entities like genes, diseases, and more; such as Id, Category, Name, Xref, Description, and more.
* The edges represent the relationships or interactions between these entities, detailing various attributes such as the type of relationship, evidence supporting it, and related publications; such as Id, Predicate, Provided By, Publications, and others.
* The structure allows for the integration of complex biological and medical information from various sources, facilitating deeper analysis and insights.
* This dataset can be used to study how different biological entities, particularly genes, interact with each other and other types of nodes, like diseases.
* The availability of multiple knowledge sources and publication references adds credibility and depth to the dataset, making it a valuable resource for research and analysis in biomedical fields.

The link to the dataset: https://kg-hub.berkeleybop.io/kg-monarch/20231028/monarch-kg.tar.gz.


# Repository Structure

The repository includes the following files:

- Dockerfile: Defines the containerized environment for reproducibility.
- Makefile: Automates the project tasks such as data preparation, analysis, and figure generation.
- README.md: Documentation for the project.
- report.Rmd: R Markdown file that contains the analysis and generates the final report.
- data: Directory containing the dataset files.


## Prerequisites Required

Ensure the following are installed:

* Docker
* R (version >= 4.0)
* RStudio
* Make
* Git


## Getting Started

Instructions to build the docker file:

#### 1. Clone the repository 

Clone the repository in git bash using the repository URL:

```
git clone https://github.com/Shilpasundar14/My_BIOS611_data_science_project.git
```
Set the current working directory in a new terminal/window to the cloned folder:

```
cd My_BIOS611_data_science_project
```

#### 2. Build a docker image 

Build the docker container using the docker build command with the image name. For example, to build an image named 611, use the following command:

```
docker build -t bios611_project .
```

#### 3. Run the docker container

For Mac/terminal, use the following command to run the container:

```
docker run -v $(pwd):/home/rstudio/work -p 8787:8787 -it bios611_project
```

For Powershell, use the following command to run the container:

```
docker run -v ${pwd}:/home/rstudio/work -p 8787:8787 -it bios611_project
```
Replace 611 with the image name used to build the container.

#### 4. Running Rstudio Docker container

Once the container is built and run, open the rstudio container image in a web browser. 

Type http://localhost:8787  in a browser window. 
Use "rstudio" as the username and the password that is generated in the terminal from the previous step. This Rstudio image should have the libraries and dependencies required for this project.

Once you are in the studio docker container, set the 'work' directory as the working directory using the terminal interface:

```
cd work
ls
```

The `ls` command should list all the files in the repository, including a Dockerfile and Makefile.

#### 5. Makefile

The Makefile is used to create the report and images. Please see the makefile for information about the script and output relationship. The outputs will be created in the "work" folder. Please check the files in the work folder for output. 

To prepare the data:

```
make prepare_data
```
To perform the analysis:

```
make analyze
```
To generate the final report, run "make Report.html". This will create "Final_report.html" in the work folder:

```
make Report.html
```
  
To generate the figures, run "make Demographics.png":
	
```
make Demographics.png
```

To run all the scripts in the Makefile:
  
```
make all
```

# Contributors
Shilpa Sundar (LinkedIN: https://www.linkedin.com/in/drshilpasundar/)
