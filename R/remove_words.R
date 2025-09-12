remove_words <- function(str, 
                         remove_words, 
                         split_on = ' ',
                         seperate_words = ' ') {
  
      split_str <- unlist(strsplit(str, split_on))
      paste(split_str[!split_str %in% remove_words], collapse = seperate_words)
}

# https://stackoverflow.com/a/35790768/3058123
# https://stackoverflow.com/a/74879342/3058123

# str <- c("I have zero a accordance about anything")
# stopwords = c("a", "able", "about", "above", "abst", "accordance", "yourself",
#               "yourselves", "you've", "z", "zero")
# remove_words(str, stopwords)
