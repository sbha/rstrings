clean_str <- function(x, rm_case = TRUE, rm_punct = TRUE, rm_num = FALSE, rm_tokens = NULL){
  if (isTRUE(rm_case)) x <- tolower(x)
  if (isTRUE(rm_punct)) x <- gsub('[[:punct:] ]', ' ', x)
  if (isTRUE(rm_num)) x <- gsub('\\d+', ' ', x)
  if (hasArg(rm_tokens)) x <- gsub(search_binder(rm_tokens), ' ', x)
  x <- gsub('\\s+', ' ', x)
  x <- trimws(x)
  x
}

