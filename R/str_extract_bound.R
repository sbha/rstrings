# extract string between two boundaries

str_extract_bound <- function(str, 
                              str_start, 
                              str_end = str_start, 
                              pattern = '.+?', 
                              replace_str_start = '',
                              replace_str_end = '',
                              trim = TRUE, 
                              squish = TRUE,
                              missing_value = NA){
  
  x <- 
    str_extract(str, paste0(str_start, pattern, str_end)) %>% 
    str_replace(str_start, replace_str_start) %>% 
    str_replace(str_end, replace_str_end) 

  if (trim == TRUE){
    
    x <- str_trim(x)
    
  }
  
  if (squish == TRUE){
    
    x <- str_squish(x)
    
  }
  
  if (is.na(x)){
    
    x <- missing_value
    
  }

  return(x)
}



# ts <- 'Stuart Barfield Harty'
# 
# str_extract_bound(ts, 'Stuart', 'Harty')
# str_extract_bound(ts, 'Stuart', 'Harrty', missing_value = 'nope')
# str_extract_bound(ts, 'Stuart', 'Harty', replace_str_start = 'Stu')

