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

search_scripts <- function(search_string, 
                           dir_path = getwd(), 
                           file_ext = '(R|r)', 
                           sort = TRUE, 
                           search_string2 = NULL,
                           string2_in_both = TRUE,
                           file_name_only = FALSE){
  
  file_ext <- paste0('\\.', file_ext, '$')
  
  if (is.null(search_string2)){
    
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
    
    if (sort == TRUE){
      df_sort <- df_out %>%
        arrange(desc(last_modified))
      
      if (file_name_only){
        df_sort <- df_sort %>% select(file_name)
      }
      
      return(df_sort)
      
    } else {
      
      if (file_name_only){
        df_out <- df_out %>% select(file_name)
      }
      
      return(df_out)
    }
    
  } else if (!is.null(search_string2)){
    
    # included in both
    if (string2_in_both == TRUE){
      
      search_scripts(search_string) %>% 
        inner_join(search_scripts(search_string2),
                   by = c('directory', 'file_name', 'last_modified'),
                   suffix = c("_str1", "_str2")) %>% 
        select(directory, file_name, pattern_count_str1, pattern_count_str2, last_modified)
      
      # string 2 not in string 1 matches  
    } else if (string2_in_both == FALSE){
      
      search_scripts(search_string) %>% 
        anti_join(search_scripts(search_string2),
                  by = c('directory', 'file_name', 'last_modified'))

    }
    
  }

}
