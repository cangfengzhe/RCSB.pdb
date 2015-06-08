setClass('pdb_input', slots = list(pdb_id = 'character', structure_id = 'character', has_chain = 'logical', chain_id = 'character', current = 'character', obsolete = 'character', query_id = 'character'), prototype = list(has_chain = F))
data(current_pdb, envir=environment())

setGeneric("init",function(object) standardGeneric("init"))
setMethod('init',signature = (object = 'pdb_input'), function(object){

  if(object@has_chain){
    structure_tmp <- toupper(object@pdb_id)
    structure_df <- do.call('rbind',strsplit(structure_tmp, split = '\\.'))
    exist_list <- structure_df[,1] %in% current_pdb
    object@current <- structure_df[exist_list, 1]
    object@chain_id <- structure_df[exist_list, 2]
    object@obsolete <- structure_df[!exist_list, 1]
    if(length(object@obsolete)>0){
      tmp <- paste(object@obsolete, collapse = ', ')
      warn_txt <- paste(c(tmp, 'has obsoleted.'), collapse = '')
      warning(warn_txt)
    }
    object@query_id <- sapply(1:length(object@current), function(ii){
      paste(c(object@current[ii], '.', object@chain_id[ii]), collapse = '')
    })
  } else{
    structure_tmp <- toupper(object@pdb_id)
    if(any(grepl('\\.', structure_tmp))) warning('Your input perhaps have chain, please let the has_chain = T')
    exist_list <- structure_tmp %in% current_pdb
    object@current <- structure_tmp[exist_list]
    object@obsolete <- structure_tmp[!exist_list]
    if(length(object@obsolete)>0) {
      tmp <- paste(object@obsolete, collapse = ', ')
      warn_txt <- paste(c(tmp, ' has obsoleted.'), collapse = '')
      warning(warn_txt)
    }
    object@query_id <- object@current
  }
  object
})



aa <- new('pdb_input', pdb_id = '5pti.A', has_chain = T)
init(aa)@query_id
