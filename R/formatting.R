state_to_st <- function(x, 
                        ignore_case = TRUE,
                        dc_names = c("District of Columbia", 'Washington DC')
){
  
  if (ignore_case){
    x <- str_to_upper(x)
    state.name <- str_to_upper(state.name)
    dc_names <- str_to_upper(dc_names)
  }
  
  c(state.abb, rep("DC", length(dc_names)))[match(x, c(state.name, dc_names))]
}



st_to_state <- function(x, 
                        dc_name = "District of Columbia"){
  c(state.name, dc_name)[match(x, c(state.abb, "DC"))]
}
