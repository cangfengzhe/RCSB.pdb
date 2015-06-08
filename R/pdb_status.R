
pdb_status <- function(structure_id){
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/idStatus?structureId='
  url_path <- paste(c(url_path_pre, structure_id), collapse = ',')
  xml_txt <- htmlParse(url_path)
  xml_record <- getNodeSet(xml_txt, '//record')
  out <- ldply(xml_record, function(x){
    record_attr <- xmlAttrs(x)
    structure_id <- record_attr['structureid']
    status <- record_attr['status']
    replaces <- record_attr['replaces']
    c(structure_id, status, replaces)
  })
  colnames(out)[3] <- 'replaces'
  out
}

