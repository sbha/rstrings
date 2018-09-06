#' @title search_binder
#'
#' @description Function to bind search terms
#'
#' @param terms
#'
#' @return bounded search terms
#'
#' @examples search_binder
#'
#' @export search_binder

search_binder <- function(terms, side = 'both'){
  #terms <- paste(terms, collapse = '|')
  terms <- paste(unlist(terms), collapse = '|')
  if (side %in% c('all', 'both', 'lr')) {
    terms <- paste0('\\b(', terms, ')\\b')
  } else if (side %in% c('leading', 'lead', 'left', 'terms')) {
    terms <- paste0('\\b(', terms, ')')
  } else if (side %in% c('trailing', 'right', 'r')){
    terms <- paste0('(', terms, ')\\b')
  } else if (side == 'none'){
    terms <- paste0('(', terms, ')')
  }
  return(terms)
}

