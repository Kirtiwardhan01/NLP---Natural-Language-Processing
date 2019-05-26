bb<-readLines("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/Exercise - Speech by modi on demonetisation.txt")
bb

library(tm)
library(stringr)
library(wordcloud)

bb_text<-paste(readLines("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/Exercise - Speech by modi on demonetisation.txt"),collapse = " ")
bb_text

bb_text2<-toupper(bb_text)
bb_text2

print(stopwords())

bb_text2<-removeWords(bb_text,stopwords())
bb_text2

bag_of_word2<-str_split(bb_text2," ")
bag_of_word2

str(bag_of_word2)

bag_of_word2<-unlist(bag_of_word2)
bag_of_word2

wordcloud(bag_of_word2,min.freq = 10)    ### let's know the words that have frequently occured in the speech ###
