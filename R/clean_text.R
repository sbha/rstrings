clean_text <- function(x){
  x <- tolower(x)
  
  x <- gsub('\\s+', ' ', x)
  
  x <- trimws(x)
  
  x
  
}
