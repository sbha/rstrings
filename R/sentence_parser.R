split_into_sentences <- function(text){
  caps = "([A-Z])"
  digits = "([0-9])"
  prefixes = "(Mr|St|Mrs|Ms|Dr|Prof|Capt|Cpt|Lt|Mt)\\."
  suffixes = "(Inc|Ltd|Jr|Sr|Co)"
  acronyms = "([A-Z][.][A-Z][.](?:[A-Z][.])?)"
  starters = "(Mr|Mrs|Ms|Dr|He\\s|She\\s|It\\s|They\\s|Their\\s|Our\\s|We\\s|But\\s|However\\s|That\\s|This\\s|Wherever)"
  websites = "\\.(com|edu|gov|io|me|net|org|biz)"
  
  text = gsub("\n|\r\n"," ", text)
  text = gsub(prefixes, "\\1<prd>", text)
  text = gsub(websites, "<prd>\\1", text)
  text = gsub('www\\.', "www<prd>", text)
  text = gsub("Ph.D.","Ph<prd>D<prd>", text)
  text = gsub(paste0("\\s", caps, "\\. "), " \\1<prd> ", text)
  text = gsub(paste0(acronyms, " ", starters), "\\1<stop> \\2", text)
  text = gsub(paste0(caps, "\\.", caps, "\\.", caps, "\\."), "\\1<prd>\\2<prd>\\3<prd>", text)
  text = gsub(paste0(caps, "\\.", caps, "\\."), "\\1<prd>\\2<prd>", text)
  text = gsub(paste0(" ", suffixes, "\\. ", starters), " \\1<stop> \\2", text)
  text = gsub(paste0(" ", suffixes, "\\."), " \\1<prd>", text)
  text = gsub(paste0(" ", caps, "\\."), " \\1<prd>",text)
  text = gsub(paste0(digits, "\\.", digits), "\\1<prd>\\2", text)
  text = gsub("...", "<prd><prd><prd>", text, fixed = TRUE)
  text = gsub('\\.”', '”.', text)
  text = gsub('\\."', '\".', text)
  text = gsub('\\!"', '"!', text)
  text = gsub('\\?"', '"?', text)
  text = gsub('\\.', '.<stop>', text)
  text = gsub('\\?', '?<stop>', text)
  text = gsub('\\!', '!<stop>', text)
  text = gsub('<prd>', '.', text)
  sentence = strsplit(text, "<stop>\\s*")
  names(sentence) <- 'sentence'
  return(sentence)
}

