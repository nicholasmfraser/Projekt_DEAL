## No Deal: Investigating the Influence of Restricted Access to Elsevier Journals on German Researchers’ Publishing and Citing Behaviours

### Overview

This repository contains the underlying code and data for the study:

Fraser, N., Hobert, A., Jahn, N., Mayr, P., and Peters, I. (2021). No Deal: Investigating the Influence of Restricted Access to Elsevier Journals on German Researchers’ Publishing and Citing Behaviours. *arXiv:2105.12078 [cs]*. https://arxiv.org/abs/2105.12078

The code and data contained in this repository is also archived via Zenodo: https://doi.org/10.5281/zenodo.4771576

An overview of the most important files and directories is provided below:

- [`data_extraction.Rmd`](data_extraction.Rmd) documents the main processes for extracting article metadata from Dimensions. Note that using the Dimensions API requires an API key. Data from Dimensions were uploaded to Google BigQuery and matched to records from Crossref and Unpaywall. Documentation of the processing and storage of Crossref and Unpaywall datasets is contained in [Jahn et al. (2021)](https://arxiv.org/abs/2102.04789) and [Hobert et al. (2021)](https://edoc.hu-berlin.de/handle/18452/23336).
- [`analysis.Rmd`](analysis.Rmd) contains the entire manuscript written in Rmarkdown format, including all code used for analyses and visualisation. [`helpers.R`](helpers.R) contains some additional functions that are imported into [`analysis.Rmd`](analysis.Rmd). The final copiled manuscript is contained in [`analysis.pdf`](analysis.pdf) 
- [`figures/`](figures) contains all figures (in .png format) generated from [`analysis.Rmd`](analysis.Rmd). Figures are divided into two directories:
  - [`main/`](figures/main) contains all the figures that are displayed in the main manuscript.
  - [`supplement/`](figures/suppement) contains all supplemental figures.
- [`queries/`](queries) contains all the SQL queries used for transforming and extracting data from Google BigQuery. R packages `DBI` and `bigrquery` were used to interface directly with BigQuery from [`analysis.Rmd`](analysis.Rmd).
- [`data/`](data) contains all input and aggregated output data used throughout the analysis. As Dimensions is a proprietary data source, raw article metadata is not included. A description of the data in each sub-directory is as follows:
  * [`analysis/`](data/analysis) contains all aggregated datasets generated and used for analysis in the context of the study. Note that each dataset corresponds to (and has the same name as) a query contained in the [`queries/`](queries) directory. Datasets with the prefix `items` refer to datasets used for analysis of publishing behaviour, and those with the prefix `references` to datasets used for analysis of citing behaviour. 
  * [`deal/`](data/deal) contains a single file, [`deal_grid_mapping.csv`](data/deal/deal_grid_mapping.csv), that documents the mapping of DEAL institution information from public webpages to their [GRID](https://www.grid.ac/) identifiers, which were used for retrieving metadata from Dimensions.
  * [`dimensions/`](data/dimensions) contains some basic information relevant for the parsing and analysis of Dimensions data, namely a list of Dimensions Fields of Research categories ([`dimensions_fields_of_research.csv`](data/dimensions/dimensions_fields_of_research.csv)) and a dataset of annual global research output (i.e. number of articles published per year - [`dimensions_items_per_year.csv`](data/dimensions/dimensions_items_per_year.csv)).
  * [`scihub/`](data/scihub) contains logs of SciHub downloads from Germany in 2017 (in .tab format). These logs are a subset of the existing dataset of [Strecker (2018)](http://doi.org/10.5281/zenodo.1286284).

### Contact

Nicholas Fraser, Postdoctoral Researcher, ZBW - Leibniz Information Centre for Economics, Kiel, Germany. [n.fraser@zbw.eu](mailto:n.fraser@zbw.eu)

