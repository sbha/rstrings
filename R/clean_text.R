clean_str <- function(x, rm_case = TRUE, rm_punct = TRUE, rm_num = FALSE, rm_tokens = NULL){
  if (isTRUE(rm_case)) x <- tolower(x)
  if (isTRUE(rm_punct)) x <- gsub('[[:punct:] ]', ' ', x)
  if (isTRUE(rm_num)) x <- gsub('\\d+', ' ', x)
  if (hasArg(rm_tokens)) x <- gsub(search_binder(rm_tokens), ' ', x)
  x <- gsub('\\s+', ' ', x)
  x <- trimws(x)
  x
}

# clean_str <- function(x, rm_case = FALSE, rm_punct = FALSE, rm_num = FALSE, ...){
#   if (isTRUE(rm_case)) x <- str_to_lower(x)
#   if (isTRUE(rm_punct)) x <- str_replace_all(x, '[[:punct:] ]', ' ')
#   if (isTRUE(rm_num)) x <- str_replace_all(x, '\\d+', ' ')
#   #if (hasArg(rm_tokens)) x <- str_replace_all(x, rm_tokens, ' ')
#   x <- str_replace_all(x, '\\s+', ' ')
#   x <- str_trim(x)
#   x
# }


# https://stackoverflow.com/questions/9877271/how-to-check-existence-of-an-input-argument-for-r-functions
