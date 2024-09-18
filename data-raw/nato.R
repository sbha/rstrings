library(stringr)
library(rvest)
library(dplyr)

pg <- read_html('https://en.wikipedia.org/wiki/NATO_phonetic_alphabet')

df_nato <- 
  pg %>% 
  html_node('table:contains("Letter code words with pronunciation")') %>% 
  html_table() %>% 
  select(letter = 1, code = 2) %>% 
  slice(-1) %>% 
  mutate(code = str_remove(code, '\\[sic\\]')) %>% 
  mutate(code = str_remove(code, ', x-ray')) %>% 
  mutate_all(str_trim)

# nato_letters <- df_nato$letter
# names(nato_letters) <- df_nato$code

nato_letters <- df_nato$code
names(nato_letters) <- df_nato$letter

usethis::use_data(nato_letters, overwrite = TRUE)
