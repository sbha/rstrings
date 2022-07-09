reverse_string <- function(x){
  s <- paste(rev(strsplit(tolower(x), '\\s')[[1]]), collapse = ' ')
  s <- gsub('\\.', ' ', s)
  gsub('\\s+', ' ', s)
}

#stringr::str_remove_all(paste(rev(strsplit(stringr::str_to_lower(slogan), '\\s')[[1]]), collapse = ' '), '\\.')



