clean_str <- function(x, rm_case = FALSE, rm_punct = FALSE, rm_num = FALSE, ...){
  if (isTRUE(rm_case)) x <- tolower(x)
  if (isTRUE(rm_punct)) x <- gsub('[[:punct:] ]', ' ', x)
  if (isTRUE(rm_num)) x <- gsub('\\d+', ' ', x)
  #if (hasArg(rm_tokens)) x <- str_replace_all(x, rm_tokens, ' ')
  x <- gsub('\\s+', ' ', x)
  x <- trimws(x)
  x
}

