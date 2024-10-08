# https://en.wikipedia.org/wiki/List_of_numbers


number_names <- c(
  'zero',
  'one',
  'two',
  'three',
  'four',
  'five',
  'six',
  'seven',
  'eight',
  'nine',
  'ten',
  'eleven',
  'twelve',
  'thirteen',
  'fourteen',
  'fifteen',
  'sixteen',
  'seventeen',
  'eighteen',
  'nineteen',
  'twenty',
  'thirty',
  'forty',
  'fifty',
  'sixty',
  'seventy',
  'eighty',
  'ninety',
  'hundred',
  'thousand'
)

numbers <- c(0:20, 30, 40, 50, 60, 70, 80, 90, 100, 1000)
types <- c('zero', rep('ones', 9), rep('tens', 18), 'hunderds', 'thousands')

df_numbers <- data.frame(number_name = number_names,
                         number = numbers, stringsAsFactors = FALSE, 
                         type = types)


#dir.create('./data/')
#save(df_numbers,file="./data/df_numbers.Rda")

usethis::use_data(df_numbers, overwrite = TRUE)
