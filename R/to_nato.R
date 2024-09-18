to_nato <- function(x){
  
  str_split_1(x, '') %>% 
    str_to_upper() %>% 
    str_replace_all(nato_letters) %>% 
    paste(collapse = ' ')

}



