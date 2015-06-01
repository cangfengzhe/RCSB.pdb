go_term <- function(structure_id){
  structure_id <- check_current(structure_id)
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/goTerms?structureId='
  url_path <- paste(c(url_path_pre, common_pdb), collapse = ',')
  url_path <- 'http://www.rcsb.org/pdb/rest/goTerms?structureId=4HHB,3qv1'
  xml_txt <- htmlParse(url_path)
  xml_go <- getNodeSet(xml_txt, '//term')
  ldply(xml_go, function(x){
    go_attr <- xmlAttrs(x)
    structureID <- go_attr['id']
    go_id <- go_attr['id']
    chainid <- go_attr['chainid']
    other_attr <- xmlChildren(x)
    attr_list <- sapply(other_attr, function(y){
      xmlAttrs(y)
    })
    c(structureID, chainid, go_id, attr_list['name', 1], attr_list['definition', 1], attr_list['ontology', 1])
  })
}