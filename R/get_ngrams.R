find_ngrams_base <- function(x, n) {
  if (n == 1) return(x)
  c(x, apply(embed(x, n), 1, function(row) paste(rev(row), collapse=' ')))
}

get_ngrams <- function(str){
  
  tk <- str_split(str, '\\s+')[[1]]
  
  1:length(tk) %>% 
    map(~find_ngrams_base(tk, .)) %>% 
    unlist() %>% 
    unique()
  
}


