download_fasta <- function(structure_id, file){
  # data()
  structure_id <- check_current(structure_id)
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/getStatusSequence?structureId='
  url_path <- paste(c(url_path_pre, structure_id), collapse = ',')
  download.file(url_path, file)
}