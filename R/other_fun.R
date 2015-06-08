check_null <- function(x){
  ifelse(is.null(x), NA, x)
}

# use system to open the file
openFileInOS <- function(f) {

  if (missing(f))
    stop('No file to open!')

  f <- path.expand(f)

  if (!file.exists(f))
    stop('File not found!')

  if (grepl("w|W", .Platform$OS.type)) { # we are on Windows
    shell.exec(f)
  } else {
    if (grepl("darwin", version$os))   # Mac
      system(paste(shQuote("open"), shQuote(f)), wait = FALSE, ignore.stderr = TRUE)
    else                               # Linux-like
      system(paste(shQuote("/usr/bin/xdg-open"), shQuote(f)), wait = FALSE, ignore.stdout = TRUE)
  }

}

check_current <- function(structure_id, has_chain = F){
 # devtools::use_data(current_pdb, internal = T)
  data(current_pdb, envir=environment())
  if(has_chain == T){
    structure_id <- do.call('rbind',strsplit(structure_id, split = '\\.'))
    structure_id[,1] <- toupper(structure_id[, 1])
    common_pdb <- intersect(current_pdb, structure_id[,1])
    proc <- structure_id[match(common_pdb, structure_id[,1]),]
    sapply(1:nrow(proc), function(ii){
      paste(proc[ii,], collapse = '.')
    })
    obso_pdb <- setdiff(structure_id, common_pdb)
    if(length(obso_pdb) > 0) warning(paste(obso_pdb), ' is obsoleted.')
  }else{
    structure_id <- toupper(unique(structure_id[, 1]))
    common_pdb <- intersect(current_pdb, structure_id)
    obso_pdb <- setdiff(structure_id, common_pdb)
    if(length(obso_pdb) > 0) warning(paste(obso_pdb), ' is obsoleted.')
    common_pdb
  }


}


