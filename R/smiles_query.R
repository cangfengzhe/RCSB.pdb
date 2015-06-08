#' Chemical Structure searches with SMILES or SMARTS strings
#'
#' This query performs chemical structure searches using SMILES and SMARTS linear notations.
#'
#' @param smiles a character of smiles
#' @param type
#' @return For \code{str_match}, a character matrix. First column is the
#'   complete match, followed by one column for each capture group.
#'   For \code{str_match_all}, a list of character matrices.
#'
#' @seealso \code{\link{str_extract}} to extract the complete match,
#'   \code{\link[stringi]{stri_match}} for the underlying
#'   implementation.
#' @export
#' @references
#' @author
#' @examples
#' structure_info <- smiles_query('OC(=O)c1ccc(OCc2ccccc2)cc1', type = 'similarity', similarity = 0.7)


smiles_query <- function(smiles, type = c('exact', 'substructure', 'superstructure', 'similarity'), similarity = NA){
  search_type <- match.arg(type, c('exact', 'substructure', 'superstructure', 'similarity'))
  if((search_type == 'similarity' & is.na(similarity) == T ) | is.numeric(similarity) == F) stop('the type of similarity must input the similarity.')

  #structure_id <- check_current(structure_id)
  url_path_pre <- 'http://www.rcsb.org/pdb/rest/smilesQuery?smiles='
  if(search_type == 'similarity' & is.na(similarity) == F){
    query_txt <- paste(c(smiles, '&search_type=', search_type, '&similarity=', similarity), collapse = '')
    } else {
    query_txt <- paste(c(smiles, '&search_type=', search_type), collapse = '')
  }
  url_path <- paste(c(url_path_pre, query_txt), collapse = '')
  xml_txt <- htmlParse(url_path)
  xml_ligand <- getNodeSet(xml_txt, '//ligand')
  out <- ldply(xml_ligand, function(x){

    ligand_attr <- xmlAttrs(x)
    structure_id <- ligand_attr['structureid']
    chem_id <- ligand_attr['chemicalid']
    type <- ligand_attr['type']
    molweight <- ligand_attr['molecularweight']
    other_attr <- xmlChildren(x)
    attr_list <- sapply(other_attr, function(y){
      xmlValue(y)
    })
  c(structure_id, chem_id, type, molweight, attr_list)

 })
  out

}


