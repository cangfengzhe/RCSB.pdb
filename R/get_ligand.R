get_ligand <- function(structure_id){
  structure_id <- check_current(structure_id)

  url_path_pre <- 'http://www.rcsb.org/pdb/rest/getEntityInfo?structureId='

  query_txt <- paste(structure_id, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
 # url_path <- 'http://www.rcsb.org/pdb/rest/ligandInfo?structureId=4HHB'
  xml_txt <- htmlParse(url_path)
  xml_ligand <- getNodeSet(xml_txt, '//structureid')
  out <- ldply(xml_ligand, function(x){
    ligand <- xmlChildren(xmlChildren(x)[[1]])
    ligand_out <- ldply(ligand, function(x){
      ligand_attr <- xmlAttrs(x)
      structureId <- ligand_attr['structureid']
      chem_id <- ligand_attr['chemicalid']
      type <- ligand_attr['type']
      weight <- ligand_attr['molecularweight']
      other_attr <- xmlChildren(x)
      attr_list <- sapply(other_attr, function(y){
        xmlValue(y)
      })
      c(structureId, chem_id, attr_list['chemicalname'], attr_list['formula'], type, weight, attr_list['inchikey'], attr_list['inchi'], attr_list['smiles'])
    })
  })

  out
}