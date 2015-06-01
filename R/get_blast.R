get_blast <- function(sequence = NA, structure_id = NA,  chain_id = NA, cutoff = 10){

  url_path_pre <- 'http://www.rcsb.org/pdb/rest/getBlastPDB1?'
  if(is.na(sequence) & is.na(structure_id)) stop('missing sequence or structure id.')
  if(missing(sequence) & !missing(structure_id)){
    if(is.na(chain_id)) url_path <- paste(c(url_path_pre, 'structureId=', structure_id, '&eCutOff=', cutoff, '&matrix=BLOSUM62&outputFormat=HTML'), collapse = '') else url_path <- paste(c(url_path_pre, 'structureId=', structure_id, '&chainId=', chain_id, '&eCutOff=', cutoff, '&matrix=BLOSUM62&outputFormat=HTML'), collapse = '')

  } else{
   url_path <- paste(c(url_path_pre, 'sequence=', structure_id, '&eCutOff=', cutoff, '&matrix=BLOSUM62&outputFormat=HTML'), collapse = '')
  }
  browseURL(url_path)
}
