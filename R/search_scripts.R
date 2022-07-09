#' @title search_scripts
#'
#' @description Function to search for a string in a directory of R scripts
#'
#' @param dir_path, 
#'
#' @return dataframe
#'
#' @examples search_scripts
#'
#' @export search_scripts

search_scripts <- function(search_string, dir_path = getwd(), file_ext = '(R|r)'){
  file_ext <- paste0('\\.', file_ext, '$')
  search_script <- function(file_name, search_string){
    read_file <- function(file_name){
      con <- file(file_name, open="r")
      on.exit(close(con))
      # warn is included because some scripts do not end with an EOL character 
      readLines(con, warn = FALSE)
    }
    
    check_string <- function(file_name, search_string){
      file <- read_file(file_name)
      cnt <- length(grep(search_string, file))
      file_pattern <- paste0('(^.+/)(.+', file_ext,')')
      dir_path <- gsub(file_pattern, '\\1', file_name)
      file_name <- gsub(file_pattern, '\\2', file_name)
      df <- data.frame(directory = dir_path, file_name = file_name, pattern_count = cnt, stringsAsFactors = FALSE)
      df
    }
    
    df <- check_string(file_name, search_string)
    
    return(df)
  }
  
  # aggregate all scripts in directory
  df_out <- list.files(dir_path, pattern = file_ext, full.names = TRUE, recursive = TRUE) %>%
    map_df(~search_script(., search_string)) %>%
    filter(pattern_count > 0) %>%
    mutate(last_modified = file.info(paste0(directory, file_name))$ctime) %>% 
    as_tibble()
  
  return(df_out)
  
}
