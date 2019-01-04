#' @title str_replacer
#'
#' @description Function to replace multiple string combinations
#'
#' @param str_target, to_replace, replace_with
#'
#' @return str_out
#'
#' @examples str_replacer
#'
#' @export str_replacer

str_replacer <- function(str_target, to_replace, replace_with){
  library(stringr)
  to_replace <- as.character(to_replace)
  replace_with <- as.character(replace_with)
  to_replace <- paste0('\\b', to_replace)
  to_replace <- ifelse(stringr::str_detect(to_replace, '\\.$'), paste0(to_replace, '\\B'), paste0(to_replace, '\\b'))
  names(replace_with) <- to_replace
  str_out <- str_replace_all(str_target, replace_with)
  return(str_out)
}
