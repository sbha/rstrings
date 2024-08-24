# https://stackoverflow.com/questions/21536015/remove-duplicate-linebreaks-in-a-string

replace_multi_linebreaks <- function(x, replace_with = '\r\n'){
  
  str_replace_all(x, '(\r\n.?)+', replace_with)
  
}


# text =  '<ul>\r\n \r\n <li><a href="#">link</a></li>\r\n \r\n <li><a href="#">link</a></li>\r\n <li><a href="#">link</a></li>\r\n \r\n <li><a href="#">link</a></li>\r\n \r\n </ul>\r\n'
# text %>% replace_multi_linebreaks()
