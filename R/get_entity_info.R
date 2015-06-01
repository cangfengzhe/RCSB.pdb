get_entity_info <- function(structureId){
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/getEntityInfo?structureId='

  query_txt <- paste(structureId, collapse = ',')
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
 # url_path <- 'http://www.rcsb.org/pdb/rest/getEntityInfo?structureId=1LS6,1Z28,2D06,3QVU,3QVV,1hhb'

  xml_txt <- htmlParse(url_path)


    xml_pdb <- getNodeSet(xml_txt, '//pdb')
    attr_len <- 4

    out <-  ldply(xml_pdb, function(x){
      pdb_attr <- xmlAttrs(x)

      # if(length(pdb_attr) != attr_len) warning(paste(pdb_attr[1], 'has problem'))
      tryCatch({
      pdb_child <- xmlChildren(x)
      pdb_method <- xmlAttrs(pdb_child$method)['name']
      pdb_type <- xmlAttrs(pdb_child$entity)['type']
      pdb_chain <- xmlChildren(pdb_child$entity)
      chain <- sapply(pdb_chain, function(y){
        xmlAttrs(y)
      })

      pdb_chain_paste <- paste(chain, collapse = ',')
      c(structure_id=pdb_attr['structureid'],
        bioassemblies = pdb_attr['bioassemblies'],
        release_date = pdb_attr['release_date'],
        resolution = pdb_attr['resolution'],
        method = pdb_method,
        type = pdb_type,
        chain = pdb_chain_paste
      )
      }, error = function(e){
        warning(paste(pdb_attr[1], 'has problem, please check.'))
        c(structureID=pdb_attr['structureid'],
          bioassemblies = NA,
          release_date = NA,
          resolution = NA,
          method = NA,
          type = NA,
          chain = NA
        )
      })

  })
  colnames(out) <- c('structureid', 'bioassemblies', 'release_date', 'resolution', 'method', 'type', 'chain')
  out
}