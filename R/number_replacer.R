#' @title number_replacer
#'
#' @description Wrapper of str_replacer() to convert numbers to number names or number names to numbers in strings
#'
#' @param x, number_name
#'
#' @return number_out
#'
#' @examples number_replacer
#'
#' @export number_replacer


number_replacer <- function(x, number_name = TRUE){
  #load("data/df_numbers.Rda")
  if(number_name == TRUE){
    rstrings::str_replacer(x, df_numbers$number, df_numbers$number_name)
  } else if (number_name == FALSE){
    rstrings::str_replacer(x, df_numbers$number_name, df_numbers$number)
  }
}


