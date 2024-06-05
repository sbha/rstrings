# https://github.com/standardebooks/tools/blob/effcf0f6db0572950375e7b2fd748fb1ae675e6c/se/formatting.py#L270

# section 8 handling y surrounded by consonants

count_syllables <- function(word){
  
  chars_first2 <- str_sub(word, 1,2)
  chars_first3 <- str_sub(word, 1,3)
  chars_first4 <- str_sub(word, 1,4)
  chars_first5 <- str_sub(word, 1,5)
  chars_first6 <- str_sub(word, 1,6)
  
  chars_3 <- str_sub(word, 3,3)
  chars_4 <- str_sub(word, 4,4)
  chars_5 <- str_sub(word, 5,5)
  
  chars_last1 <- str_sub(word, start= -1)
  chars_last2 <- str_sub(word, start= -2)
  chars_last3 <- str_sub(word, start= -3)
  chars_last4 <- str_sub(word, start= -4)
  
  vowels <- c('a', 'e', 'i', 'o', 'u')
  consonants <- letters[!letters %in% vowels]
  
    # See http://eayd.in/?p=232
  exception_add = c("serious", "crucial")
  exception_stu = c("rodeo", "hierarchical", "hierarchy")
  exception_add = c(exception_add, exception_stu)
  exception_del = c("fortunately", "unfortunately")
  
  co_one = c("cool", "coach", "coat", "coal", "count", "coin", "coarse", "coup", "coif", "cook", "coign", "coiffe", "coof", "court")
  co_two = c("coapt", "coed", "coinci")
  
  pre_one = c("preach")
  
  syls = 0 # Added syllable number
  disc = 0 # Discarded syllable number
  
  # 1) if letters < 3: return 1
  if (nchar(word) <= 3){
    
    syls = 1
    
    return(syls)
    
  } else {
    
    # 2) if doesn't end with "ted" or "tes" or "ses" or "ied" or "ies", discard "es" and "ed" at the end.
    # if it has only 1 vowel or 1 set of consecutive vowels, discard. (like "speed", "fled" etc.)
    if (chars_last2 == "es" | chars_last2 == "ed"){
      
      double_and_triple_1 = str_count(word, '[eaoui][eaoui]')
      
      if (double_and_triple_1 > 1 | str_count(word, '[eaoui][^eaoui]') > 1)  {
        
        if (chars_last3 == "ted" | chars_last3 == "tes" | chars_last3  == "ses" | chars_last3  == "ied" |chars_last3 == "ies"){
          #pass
        } else {
          disc = disc + 1
        }
      }
    }
    
    # 3) discard trailing "e", except where ending is "le"
    le_except = c("whole", "mobile", "pole", "male", "female", "hale", "pale", "tale", "sale", "aisle", "whale", "while")
    
    if (chars_last1 == "e"){
      
      if (chars_last2 == "le" & !(word %in% le_except)){
        #pass
      } else {
        
        disc = disc + 1
        
      } 
    }
    
    # 4) check if consecutive vowels exists, triplets or pairs, count them as one.
    double_and_triple = str_count(word, '[eaoui][eaoui]')
    tripple = str_count(word, '[eaoui][eaoui][eaoui]')
    disc = disc + double_and_triple + tripple
    
    # 5) count remaining vowels in word.
    num_vowels = str_count(word, '[eaoui]')
    
    # 6) add one if starts with "mc"
    if (chars_first2 == "mc") syls = syls + 1
    
    # 7) add one if ends with "y" but is not surrouned by vowel
    if (chars_last1 == "y" & (!chars_last2 %in% vowels)) syls = syls + 1
    
    # 8) add one if "y" is surrounded by non-vowels and is not in the last word.
    # not ready to port yet - need to figure out python enumerate 
    # rey <-'[b-df-hj-np-tv-z]y[b-df-hj-np-tv-z]'
    # 
    # syls_y <- str_split(word, '') %>% 
    #   unlist() %>% 
    #   enframe() %>% 
    #   filter(!(value == 'y' & row_number() == max(row_number()))) %>% 
    #   mutate(leading = lead(value)) %>% 
    #   mutate(lagging = lag(value)) %>% 
    #   unite(value, leading, value, lagging, sep = '', na.rm = TRUE) %>% 
    #   filter(str_detect(value, rey)) %>% 
    #   nrow()
    syls_y = length(stri_match_all_regex(word, '(?=([b-df-hj-np-tv-z]y[b-df-hj-np-tv-z]))')[[1]][,2])
    
    syls = syls + syls_y
    
    # 9) if starts with "tri-" or "bi-" and is followed by a vowel, add one.
    if (chars_first3 == "tri" & chars_4 %in% vowels) syls = syls + 1
    
    if (chars_first2 == "bi" & chars_3 %in% vowels) syls = syls + 1
    
    # 10) if ends with "-ian", should be counted as two syllables, except for "-tian" and "-cian"
    if (chars_last3 == "ian"){
      # and (word[-4:] != "cian" or word[-4:] != "tian"):
      if (chars_last4 == "cian" | chars_last4 == "tian"){
        #pass
      } else {
        
        syls = syls + 1
        
      } 
    }
    
    # 11) if starts with "co-" and is followed by a vowel, check if exists in the double syllable dictionary, if not, check if in single dictionary and act accordingly.
    if (chars_first2 == "co" & chars_3 %in% vowels){
      
      if (chars_first4 %in% co_two | chars_first5 %in% co_two | chars_first6 %in% co_two){
        
        syls = syls + 1
        
      } else if (chars_first4 %in% co_one | chars_first5 %in% co_one | chars_first6 %in% co_one){
        #pass
      } else {
        
        syls = syls + 1
        
      }
      
    }
    
    # 12) if starts with "pre-" and is followed by a vowel, check if exists in the double syllable dictionary, if not, check if in single dictionary and act accordingly.
    if (chars_first3 == "pre" & chars_4 %in% vowels){
      
      if (chars_first6 %in% pre_one){
        # pass
      } else {
        
        syls = syls + 1
        
      }
      
    }
    
    # 13) check for "-n't" and cross match with dictionary to add syllable.
    negative = c("doesn't", "isn't", "shouldn't", "couldn't", "wouldn't", "doesn’t", "isn’t", "shouldn’t", "couldn’t", "wouldn’t")
    
    if (chars_last3 == "n't" | chars_last3 == "n’t"){
      
      if (word %in% negative){
        
        syls = syls + 1
        
      } else {
        # pass
      }
    }
    
    # # 14) Handling the exceptional words.
    if (word %in% exception_del) disc <- disc + 1
    
    if (word %in% exception_add) syls = syls + 1
    
    # Calculate the output
    return(num_vowels - disc + syls)
    
  }

}

# test_word <- 'stuart'
# test_word <- 'inhabitant'
# 
# get_syllable_count(test_word)
# 
# test_word <- 'stuart'
# test_word <- 'stuartheart'
# test_word <- 'tertiary'
# test_word <- 'consciousness'
# test_word <- 'constantinople'
# 
# str_sub(test_word, start= -2)
# str_count(test_word, '[eaoui][^eaoui]')
# str_sub(test_word, start= 1,3)
# str_sub(test_word, start= 3,3)
# 
# mylist <- strsplit(test_word, "")[[1]]
# 
# for (i in seq_along(mylist)){
#    print(i)
# }
# 
# enumerate <- function(...) {
#   zip(ix=seq_along(..1), ...)
# }
# 

#re <- paste0('(', paste(consonants, collapse = '|'), ')y(', paste(consonants, collapse = '|'), ')')
# re <- '[b-df-hj-np-tv-z]y[b-df-hj-np-tv-z]'
# 
# #str_count(tw, paste0('(', paste(consonants, collapse = '|'), ')y(', paste(consonants, collapse = '|'), ')'))
# str_count(tw, re)
# 
# # monosyllable 
# # polysyllable
# # hierarchical
# 
# 
# 
# 
# stringi::stri_match_all_regex('ACCACCACCAC', '(?=([AC]C))')[[1]][,2]
# length(stringi::stri_match_all_regex('polysyllable', '(?=([b-df-hj-np-tv-z]y[b-df-hj-np-tv-z]))')[[1]][,2])
# 
