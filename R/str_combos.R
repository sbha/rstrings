#' @title str_combos
#'
#' @description Function to replace multiple string combinations
#'
#' @param str_target, to_replace, replace_with
#'
#' @return str_out
#'
#' @examples str_replacer
#'
#' @export str_combos

str_combos <- function(x, bar = FALSE){
  a <- NULL
  chars <- nchar(x)
  for (i in 1:chars) {
    j = i:chars
    for (k in j){
      if (i != k){
        a <- c(a, substr(x, i, k))
      }
    }
  }
  if (bar == TRUE) return(paste(a, collapse = '|'))
  else return(a)
}

