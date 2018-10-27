# rstrings
## Overview
Functions for working with strings in R. 

* Easier binding when searching for multiple terms with `search_binder()`
* Easier replacement of multiple values with `str_replacer()`
* Parse structured text into sentences with `split_into_sentences()`
* Search R scripts for a string with `search_scripts()`

## Installation
``` r
# install.packages("devtools")
devtools::install_github("sbha/rstrings")
```

## Usage
```r
library(rstrings)

# The default is to bind search terms on both sides: 
sample_terms = c('sample', 'words')
search_binder(sample_terms)
#> "\\b(sample|words)\\b"

# The side to bind search terms can be set with side: 
search_binder(sample_terms, side = 'trailing')
#> "(sample|words)\\b"

# left bind can be set by side = 'leading', 'lead', 'left', or 'l'
# right bind can be set by side = 'trailing', 'right', or 'r'
# no binding can be set by side = 'none'

# The input can be a column from a data frame:
search_binder(unique(iris$Species))
#> "\\b(setosa|versicolor|virginica)\\b"

# Or a list:
search_binder(list(sample_terms))
#> "\\b(sample|words)\\b"

# search_binder() is meant to be used in function calls like a grepl() or stringr::str_detect():
grepl(search_binder(sample_terms), target_text)
stringr::str_detect(target_text, search_binder(sample_terms))


# str_replacer() takes target strings and replaces them with corresponding values
test_string <- 'Jane was born last month on mon jan 1st'
to_replace = c('mon', 'jan')
replace_with = c('Monday', 'January')
str_replacer(test_string, to_replace, replace_with)
#> "Jane was born last month on Monday January 1st"

# str_replacer() works well with a data frame that can serve as a replacement key table with a column 
# of strings that are to be replaced and a column of strings that will be the replacements:
df <- data.frame(to_replace = to_replace,
                 replace_with = replace_with, stringsAsFactors = FALSE)
str_replacer(test_string, df$to_replace, df$replace_with)
#> "Jane was born last month on Monday January 1st"


# split_into_sentences() can parse structured text into individual sentences:
test_text <- 'Dr. John Johnson, Ph.D. worked for X.Y.Z. Inc. for 4.5 years. He earned $2.5 million when it sold! Now he works at www.website.com.'
sentences <- split_into_sentences(test_text)
sentences$sentence
#> [1] "Dr. John Johnson, Ph.D. worked for X.Y.Z. Inc. for 4.5 years."
#> [2] "He earned $2.5 million when it sold!"                         
#> [3] "Now he works at www.website.com." 

# with dplyr::bind_rows() the output from split_into_sentences() can easily be converted into a dataframe:
df_sentences <- dplyr::bind_rows(sentences) 
#> # A tibble: 3 x 1
#>   sentence                                                     
#>   <chr>                                                        
#> 1 Dr. John Johnson, Ph.D. worked for X.Y.Z. Inc. for 4.5 years.
#> 2 He earned $2.5 million when it sold!                         
#> 3 Now he works at www.website.com. 

# search_scripts() finds R scripts in a directory and any subdirectories that contain a search pattern. It really shines with purrr::map_df(). The following example returns a dataframe for any scripts in the test_dir that has the string 'mutate':
library(dplyr)
library(purrr)

test_dir <- '~/dir_path/R/Scripts/'
test_string <- 'mutate'

list.files(test_dir, pattern = '\\.R$', full.names = TRUE, recursive = TRUE) %>% 
  map_df(~search_scripts(., test_string)) %>% 
  filter(pattern_count > 0)

```
