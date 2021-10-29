reverse_string <- function(x){
  s <- paste(rev(strsplit(tolower(x), '\\s')[[1]]), collapse = ' ')
  s <- gsub('\\.', ' ', s)
  gsub('\\s+', ' ', s)
}

