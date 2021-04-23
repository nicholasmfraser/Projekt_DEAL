# Load a dataset into our workspace from BigQuery. If the parameter "refresh" is
# set to false, we first search for a cached dataset in the "data/analysis" 
# directory. If no file is found, or the parameter "refresh" is set to true,
# we retrieve the dataset from BigQuery and subsequently cache the new dataset
# in the "data/analysis" directory.
bq_dataset <- function(dataset, refresh = FALSE) {
  path <- stringr::str_c("data/analysis/", dataset, ".csv")
  if(file.exists(path) & refresh == FALSE) {
    message(stringr::str_c("Dataset '", dataset, "' already exists, loading from file..."))
    dataset <- readr::read_csv(path)
  } else {
    if(refresh == TRUE) {
      message(stringr::str_c("Refreshing dataset '", dataset, "' from BigQuery..."))
    } else {
      message(stringr::str_c("Dataset '", dataset, "' does not yet exist. ", 
                             "Attempting to retrieve from BigQuery..."))
    }
    query_path <- stringr::str_c("queries/", dataset, ".sql")
    dataset <- DBI::dbGetQuery(con, readr::read_file(query_path))
    readr::write_csv(dataset, path)
    return(dataset)
  }
}

factorise_publisher <- function(data) {
    dplyr::mutate(data, publisher = factor(publisher, 
                                           levels = c("Non-Elsevier", 
                                                      "Elsevier")))
}

factorise_oa_status <- function(data) {
  dplyr::mutate(data, oa_status = factor(oa_status,
                                         levels = c("closed",
                                                    "gold",
                                                    "green",
                                                    "hybrid",
                                                    "bronze"),
                                         labels = c("Closed",
                                                    "Gold",
                                                    "Green",
                                                    "Hybrid",
                                                    "Bronze")))
}

factorise_cancellation_year <- function(data) {
  dplyr::mutate(data, cancellation_year = factor(cancellation_year,
                                                 levels = 2016:2018,
                                                 labels = str_c("Contract expired in ", 2016:2018)))
}

factorise_collaboration_status <- function(data) {
  dplyr::mutate(data, collaboration_status = factor(collaboration_status,
                                                    levels = c("deal-collaboration",
                                                               "national-collaboration",
                                                               "international-collaboration"),
                                                    labels = c("DEAL collaboration",
                                                               "National collaboration",
                                                               "International collaboration")))
}