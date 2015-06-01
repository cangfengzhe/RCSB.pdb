desc_chem <- function(chemical_id){
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/describeHet?chemicalID='

  query_txt <- paste(chemical_id, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
 url_path <- 'http://www.rcsb.org/pdb/rest/describeHet?chemicalID=NAG,EBW'

  xml_txt <- htmlParse(url_path)


  xml_chem <- getNodeSet(xml_txt, '//ligand')
  out <- ldply(xml_chem, function(x){
    chem_attr <- xmlAttrs(x)
    chem_id <- chem_attr['chemicalid']
    type <- chem_attr['type']
    weight <- chem_attr['molecularweight']
    other_attr <- xmlChildren(x)
    attr_list <- sapply(other_attr, function(y){
        xmlValue(y)
    })
    c(chem_id, attr_list['chemicalname'], attr_list['formula'], type, weight, attr_list['inchikey'], attr_list['inchi'], attr_list['smiles'])
  })
  out
}