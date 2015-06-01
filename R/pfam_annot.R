pfam_annot <- function(structure_id){
  structure_id <- check_current(structure_id)
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/hmmer?structureId='

  query_txt <- paste(structure_id, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
  url_path <- 'http://www.rcsb.org/pdb/rest/hmmer?structureId=4hhb'

  xml_txt <- htmlParse(url_path)


  xml_hit <- getNodeSet(xml_txt, '//pfamhit')
  ldply(xml_hit, function(x){
    xmlAttrs(x)
  })
}