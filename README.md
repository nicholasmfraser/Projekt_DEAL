## No Deal: Investigating the Influence of Restricted Access to Elsevier Journals on German Researchers’ Publishing and Citing Behaviours

### Overview

This repository contains the underlying code and data for the study:

Fraser, N., Hobert, A., Jahn, N., Mayr, P., and Peters, I. (2021). No Deal: Investigating the Influence of Restricted Access to Elsevier Journals on German Researchers’ Publishing and Citing Behaviours. [**To do:** Insert link to preprint].

An overview of the most important files and directories is provided below:

- [`data_extraction.Rmd`](data_extraction.Rmd) documents the main processes for extracting article metadata from Dimensions.
- [`analysis.Rmd`](analysis.Rmd) contains the entire manuscript written in Rmarkdown format, including all code used for analyses ([`helpers.R`](helpers.R) contains some additional functions that are imported into `analysis.Rmd`).
- [`figures/`](figures) contains all figures generated from [`analysis.Rmd`](analysis.Rmd). Figures are divided into two directories:
  - [`main/`](figures/main) contains all the figures that are displayed in the main manuscript.
  - [`supplement/`](figures/suppement) contains all supplemental figures.
- [`queries/`](queries) contains all the SQL queries used for transforming and extracting data from Google BigQuery. R packages `DBI` and `bigrquery` were used to interface directly with BigQuery from [`analysis.Rmd`](analysis.Rmd).
- [`data/`](data) contains the following sub-directories: [**To do:** decide which data should be included and write descriptions of directions]
  * [`analysis/`](data/analysis)
  * [`deal/`](data/deal) 
  * [`dimensions/`](data/dimensions)
  * [`scihub/`](data/scihub)

### License

[**To do:** Choose a license and complete]

### Contact

Nicholas Fraser, Postdoctoral Researcher, ZBW - Leibniz Information Centre for Economics, Kiel, Germany. [n.fraser@zbw.eu](mailto:n.fraser@zbw.eu)

