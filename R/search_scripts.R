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

search_scripts <- function(file_name, search_string){
  read_file <- function(file_name){
    con <- file(file_name, open="r")
    on.exit(close(con))
    # warn is included because some scripts do not end with an EOL character 
    readLines(con, warn = FALSE)
  }
  
  check_string <- function(file_name, search_string){
    file <- read_file(file_name)
    cnt <- length(grep(search_string, file))
    dir_path <- gsub('(^.+/)(.+\\.R$)', '\\1', file_name)
    file_name <- gsub('(^.+/)(.+\\.R$)', '\\2', file_name)
    df <- data.frame(directory = dir_path, file_name = file_name, pattern_count = cnt, stringsAsFactors = FALSE)
    df
  }
  
  df <- check_string(file_name, search_string)
  
  return(df)
}


