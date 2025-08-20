# '<.*?>'

remove_html_tags <- function(x, 
                             replace_with = ' ', 
                             trim = TRUE,
                             squish = TRUE,
                             re_tags = '<[^>]*>'){
  
  cs <- str_replace_all(x, re_tags, replace_with)
  
  if (trim){
    cs <- str_trim(cs)
  } 
  
  if (squish){
    cs <- str_squish(cs)
  } 
  
  return(cs)
  
}
