#' Title
#'
#' @param structure.chain
#' @param cluster
#'
#' @return
#' @export
#'
#' @examples
seq_cluster <- function(structure.chain, cluster = 40){
 # http://www.rcsb.org/pdb/rest/sequenceCluster?cluster=40&structureId=4hhb.A
  # structure_id <- check_current(structure_id)
  if(!any(grepl('\\.', sturcture.chain)))
  if(length(structure_id) > 1) stop('only one ')
  if(!any(grepl('\\.', sturcture.chain))) stop('Did not request a structure.Chain ID!')
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/sequenceCluster?'

  query_txt <- paste(structure_id, collapse = ',')
  url_path <- paste(c(url_path_pre, 'cluster=', cluster, 'structureId=', query_txt), collapse = '')
  url_path <- 'http://www.rcsb.org/pdb/rest/sequenceCluster?cluster=40&structureId=4HHB.A'

  xml_txt <- htmlParse(url_path)
  xml_hit <- getNodeSet(xml_txt, '//sequencecluster')
  xml_attr <- xmlAttrs(xml_hit[[1]])
  xml_child <- xmlChildren(xml_hit[[1]])
  out <- ldply(xml_child, function(x){
      c(structure.chain, xml_attr, xmlAttrs(x))
  })
  colnames(out)[2] <- 'structure.chain'
  out <- out[, -1]

}