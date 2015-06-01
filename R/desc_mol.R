desc_mol <- function(structure_id){
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/describeMol?structureId='

  query_txt <- paste(structure_id, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
  url_path <- 'http://www.rcsb.org/pdb/rest/describeMol?structureId=1LS6,1Z28,2D06,3QVU,3QVV,1hhb'
  xml_txt <- htmlParse(url_path)
  xml_pdb <- getNodeSet(xml_txt, '//structureid')

  out <- ldply(xml_pdb, function(x){
    structure_id <- xmlAttrs(x)
    polymer <- xmlChildren(x)
    polymer_list <- ldply(polymer, function(y){
      polymer_attr <- xmlAttrs(y)
      polymer_entitynr <- polymer_attr['entitynr']
      polymer_length <- polymer_attr['length']
      polymer_type <- polymer_attr['type']
      polymer_weight <- polymer_attr['weight']

      y_doc <- xmlDoc(y)
      chain <- getNodeSet(y_doc, '//chain')
      chain_list <- paste(sapply(chain, xmlAttrs), collapse = ',')

      macro_mol_list <- sapply( getNodeSet(y_doc, '//macromolecule'), function(z){
       macro_mol_name <- xmlAttrs(z)
       macro_mol_id <- xmlAttrs(xmlChildren(z)[[1]])

       paste(c(macro_mol_id, macro_mol_name), collapse = ',')
      } )
      macro_mol <- paste(macro_mol_list, collapse = ';')

      y_list <- xmlToList(y)
      description <- check_null(y_list$polymerdescription)
      enzclass <- check_null(y_list$enzclass)
      synonym <- check_null(y_list$synonym)
      mutation <- check_null(y_list$mutation)
      fragment <- check_null(y_list$fragment)
     polymer_out <-  c(structure_id = structure_id, polymer_entitynr = polymer_entitynr, synonym = synonym, description = description, polymer_length = polymer_length, polymer_type = polymer_type, polymer_weight = polymer_weight, chain = chain_list, macroMolecule = macro_mol, mutation = mutation ,fragment = fragment)

     })
    polymer_list
  })
#  cc <- do.call('rbind', out)
 out #<- as.data.frame(out)

}


