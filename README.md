# rstrings
## Overview
Functions for working with strings in R. Easier binding when searching for multiple terms with `search_binder()`. Easier replacement of multiple values with `str_replacer()`. 

## Installation
``` r
# install.packages("devtools")
devtools::install_github("sbha/rstrings")
```

## Usage
```r
# The default is to bind search terms on both sides: 
library(rstrings)
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

# search_binder is meant to be used in function calls like a grepl() or stringr::str_detect():
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

```
