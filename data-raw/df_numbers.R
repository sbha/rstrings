
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


df_numbers <- data.frame(number_name = number_names,
                         number = numbers, stringsAsFactors = FALSE)


dir.create('./data/')
#save(df_numbers,file="./data/df_numbers.Rda")

