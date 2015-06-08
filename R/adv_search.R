adv_search <- function(xml_file){
  url1 <- 'http://www.rcsb.org/pdb/rest/search'
  xml_text <- paste(readLines(xml_file), collapse = '\n')

  h = basicTextGatherer()
httpheader=c(Accept="*/*",
  "Content-Type"="application/x-www-form-urlencoded")

result <- curlPerform(url = url1,
  httpheader=httpheader,
  postfields=xml_text,
  writefunction = h$update,
  verbose = TRUE
)
out <- strsplit(h$value(), '\\n')[[1]]
}