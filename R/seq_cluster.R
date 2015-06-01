seq_cluster <- function(structure.chain){
 # http://www.rcsb.org/pdb/rest/sequenceCluster?cluster=40&structureId=4hhb.A
  # structure_id <- check_current(structure_id)
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/sequenceCluster?cluster=40&structureId='

  query_txt <- paste(structure_id, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
  url_path <- 'http://www.rcsb.org/pdb/rest/hmmer?structureId=4hhb'

  xml_txt <- htmlParse(url_path)


  xml_hit <- getNodeSet(xml_txt, '//pfamhit')
}