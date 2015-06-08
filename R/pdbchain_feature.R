#' Title
#'
#' @param pdb.chain
#' @param type
#'
#' @return
#' @export
#'
#' @examples
#'
pdbchain_feature <- function(pdb.chain, type = c('features', 'sequence')){
  type <- match.arg(type, c('features', 'sequence'))

  if(type == 'features'){
    url_path_pre <- 'http://www.rcsb.org/pdb/rest/das/pdbchainfeatures/features?segment='
    url_path <- paste(c(url_path_pre, pdb.chain), collapse = '')
    xml_txt <- htmlParse(url_path)
    xml_feature <- getNodeSet(xml_txt, '//feature')
    out <- ldply(xml_feature, function(x){
      ii<<- ii+1
      print(ii)
      feat_attr <- xmlAttrs(x)
      other_attr <- xmlChildren(x)
      attr_list <- sapply(other_attr, function(y){

        c(xmlAttrs(y), xmlValue(y))
      })
      category <- check_null(attr_list$type['category'][1])
      method_id <- check_null(attr_list$method['id'])
      start <- check_null(attr_list$start)
      end <- check_null(attr_list$end)
      score <- check_null(attr_list$score)
      note <- check_null(attr_list$note[1])
      link <- check_null(attr_list$link[1])
      text <- check_null(attr_list$text[1])
      c(category = category, method = method_id, start = start, end = end, score = score, note = note, link = link, text = text)

    })
    out
  } else {
    url_path_pre <- 'http://www.rcsb.org/pdb/rest/das/pdbchainfeatures/sequence?segment='
    url_path <- paste(c(url_path_pre, pdb.chain), collapse = '')
    xml_txt <- htmlParse(url_path)
    xml_feature <- getNodeSet(xml_txt, '//sequence')
    out <- ldply(xml_feature, function(x){
      c(xmlAttrs(x), xmlValue(x))
    })
    colnames(out)[6] <- 'sequence'
      out
  }
  out
}