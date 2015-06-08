get_unreleased <- function(structure_id = NA){
  if(is.na(structure_id) == T){
    url_path <- 'http://www.rcsb.org/pdb/rest/getUnreleased'
  } else{
    structure_id <- check_current(structure_id)
    url_path_pre <- 'http://www.rcsb.org/pdb/rest/getUnreleased?structureId='
    url_path <- paste(c(url_path_pre, structure_id), collapse = ',')
  }

  xml_txt <- htmlParse(url_path)


  xml_record <- getNodeSet(xml_txt, '//record')
  out <- ldply(xml_record, function(x){
    pdb_attr <- xmlAttrs(x)
    other_attr <- xmlChildren(x)
    attr_list <- sapply(other_attr, function(y){
      xmlValue(y)
    })
    c(pdb_attr, attr_list)
  })

}
