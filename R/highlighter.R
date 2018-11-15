#' @title highlighter
#'
#' @description Function to highlight a substring in a string
#'
#' @param txt, substring
#'
#' @return highlighted string
#'
#' @examples search_binder
#'
#' @export highlighter

highlighter <- function(txt, substring){
  if (grepl(substring, txt, fixed = TRUE)){
    highlight_substring <- crayon::red$bold(substring)
    cat(unlist(strsplit(test_string, test_substring)), sep = highlight_substring)
  } else {
    highlight_substring <- crayon::red$bold(substring)
    cat(paste0("the substring '", highlight_substring, "' does not exist in the target string"))
  }
}
