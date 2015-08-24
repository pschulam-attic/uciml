download <- function(dataset, destination) {
  no_destination <- missing(destination)

  if (no_destination) {
    destination <- stringr::str_replace_all(dataset, " ", "_")
    destination <- tolower(destination)
  }

  dir.create(destination)

  files <- dataset_files(dataset)

  for (fn in files) {
    bn <- basename(fn)
    download.file(fn, file.path(destination, bn))
  }
}
