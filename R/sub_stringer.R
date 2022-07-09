#' @title sub_stringer
#'
#' @description Function to replace multiple string combinations
#'
#' @param str_target, to_replace, replace_with
#'
#' @return str_out
#'
#' @examples str_replacer
#'
#' @export sub_stringer

sub_stringer <- function(x, bar = FALSE){
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


# sub_stringer2 <- function(x, bar = FALSE){
#   x <- trimws(x)
#   a <- NULL
#   chars <- nchar(x)
#   for (i in 1:chars) {
#     j = i:chars
#     for (k in j){
#       if (i != k){
#         a <- c(a, substr(x, i, k))
#       }
#     }
#   }
#   if (bar == TRUE) return(unique(trimws(paste(a, collapse = '|'))))
#   else return(unique(trimws(a)))
# }
# 
# sub_stringer2('harty')

