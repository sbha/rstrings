# rstrings
## Overview
Functions for working with strings in R

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

# The input can a column from a data frame:
search_binder(unique(iris$Species))
#> "\\b(setosa|versicolor|virginica)\\b"

# Or a list:
search_binder(list(sample_terms))
#> "\\b(sample|words)\\b"

# search_bind is meant to be used in function calls like a grepl() or stringr::str_detect():
grepl(search_binder(sample_terms), target_text)

stringr::str_detect(target_text, search_binder(sample_terms))



```


search_binder(c('sample', 'words'))



test_string <- 'today is mon jan 1'

str_replacer(test_string, c('mon', 'jan'), c('Monday', 'January'))

df <- data_frame(to_replace = c('mon', 'jan'),
                 replace_wwith = rw)

str_replacer(test_string, df$to_place, df$replace_with)
