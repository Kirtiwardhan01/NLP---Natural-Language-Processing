
library(tm)
library(wordcloud)
library(stringr)

cs<-readLines("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/Customer Service Support.txt")

cs_text<-paste(readLines("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/Customer Service Support.txt"),collapse = " ")

cs_text<-toupper(cs_text)

print(stopwords())

cs_text2<-removeWords(cs_text,stopwords())

cs_bag_of_words<-str_split(cs_text2," ")
 
str(cs_bag_of_words)        #### str function is used to cjeck the internal structure (list)

cs_bag_of_words<-unlist(cs_bag_of_words)

wordcloud(cs_bag_of_words,min.freq = 5)
