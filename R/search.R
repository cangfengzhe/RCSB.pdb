
search <- setClass('search', slot = c(type = 'character', keyword = 'character'))

setGeneric("work",function(object) standardGeneric("work"))

setMethod("work", signature(object = "search"), function(object){


} )

library(rvest)
html_txt <- html('http://www.rcsb.org/pdb/software/rest.do')
select_node <- html_nodes(html_txt, 'select')
html_nodes(select_node, 'option')
class(select_node)
html_tag(select_node)

option <- html_children(select_node[[1]])
html_attr(option, 'value')

select_node %>% str
