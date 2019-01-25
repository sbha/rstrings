# rstrings
## Overview
Functions for working with strings in R: 

* Easier word boundary binding when searching for multiple terms with `search_binder()`
* Easier replacement of multiple values with `str_replacer()`
* Replace numbers with number names or number names with numbers with `number_replacer()`
* Parse structured text into sentences with `split_into_sentences()`
* Search R scripts for a string with `search_scripts()`
* Simple substring highlighting with `highlighter()`


## Installation
``` r
# install.packages("devtools")
devtools::install_github("sbha/rstrings")
```

## Usage
```r
library(rstrings)

# search_binder() is meant to be used in functions like grepl() or stringr::str_detect() where it may be necessary to search for multiple terms that need word boundaries:
sample_terms = c('multiple', 'sample', 'search', 'terms')
grepl(search_binder(sample_terms), target_text)
stringr::str_detect(target_text, search_binder(sample_terms))

# The default is to bind search terms on both sides: 
search_binder(sample_terms)
#> "\\b(multiple|sample|search|terms)\\b"

# The side to bind search terms can be set with side: 
search_binder(sample_terms, side = 'trailing')
#> "(multiple|sample|search|terms)\\b"

# left bind can be set by side = 'leading', 'lead', 'left', or 'l'
# right bind can be set by side = 'trailing', 'right', or 'r'
# no binding can be set by side = 'none'

# The input can be a column from a data frame:
search_binder(unique(iris$Species))
#> "\\b(setosa|versicolor|virginica)\\b"

# Or a list:
search_binder(list(sample_terms))
#> "\\b(multiple|sample|search|terms)\\b"


# str_replacer() takes target strings and replaces them with corresponding values:
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
sample_text <- 'Dr. John Johnson, Ph.D. worked for X.Y.Z. Inc. for 4.5 years. He earned $2.5 million when it sold! Now he works at www.website.com.'
sentences <- split_into_sentences(sample_text)
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


# search_scripts() finds R scripts in a directory and any subdirectories that contain a search pattern. The following example returns a dataframe for any scripts in the test_dir that has the string 'mutate':
test_dir <- '~/dir/path/R/Scripts' # no trailing forward slash
test_string <- 'mutate'

df_scripts <- search_scripts(test_dir, test_string)
head(df_scripts, 2)
#> # A tibble: 2 x 3
#>    directory                                 file_name         pattern_count
#>    <chr>                                     <chr>                     <int>
#>  1 ~/dir/path/R/Scripts/                     sample_script1.R              2
#>  2 ~/dir/path/R/Scripts/sub_directory        test_script2.R                1


# highlighter() prints highlighted substrings from a target string in the console:
test_string <- 'this sample string contains three matching substrings of the target string to be highlighted'
test_substring <- 'string'

highlighter(test_string, test_substring)
#> this sample string contains three matching substrings of the target string to be highlighted
# note that this example will not display in markdown as it will in the console

# get all possible sub string combinations of a string with sub_stringer():
#> str_combos('Russ')
#[1] "Ru"   "Rus"  "Russ" "us"   "uss"  "ss" 
```
