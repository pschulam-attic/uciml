#' List the dataset files in the repository
#'
#' @param dataset The name of the dataset.
#'
dataset_files <- function(dataset) {
  folder <- homepage_url(dataset) %>% data_folder
  all_files <- folder_files(folder)
  is_data <- grep(DATA_FILES_REGEX, all_files)
  file.path(folder, all_files[is_data])
}

folder_files <- function(folder) {
  nodes <- rvest::html(folder) %>% rvest::html_nodes("table td a")
  rvest::html_attr(nodes, "href")
}

data_folder <- function(homepage) {
  nodes <- rvest::html(homepage) %>% rvest::html_nodes("table td span a")
  links <- nodes %>% rvest::html_attr("href")

  is_folder <- stringr::str_detect(links, FOLDER_REGEX)
  relative_folder <- links[is_folder]
  folder_branch <- stringr::str_replace(relative_folder, "../", "")

  file.path(UCI_ROOT, folder_branch)
}

homepage_url <- function(dataset) {
  no_spaces <- stringr::str_replace_all(dataset, " ", "+")
  file.path(UCI_ROOT, "datasets", no_spaces)
}
