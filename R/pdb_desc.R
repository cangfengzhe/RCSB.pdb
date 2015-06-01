
pdb_desc <- function(structureId){
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/describePDB?structureId='
  query_txt <- paste(structureId, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
  xml_txt <- htmlParse(url_path)
  xml_list <- xmlToList(xml_txt)
  title <- names(xml_list$body$pdbdescription$pdb)
  out <- ldply(xml_list$body$pdbdescription, function(x) {
    sapply(title, function(y){
      assign(y, x[[y]])
    })
  } )
 out
}




