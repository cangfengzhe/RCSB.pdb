check_len <- function(pdb_list, l){
  len <- sapply(pdb_list, length)
  which(len!=l)
}