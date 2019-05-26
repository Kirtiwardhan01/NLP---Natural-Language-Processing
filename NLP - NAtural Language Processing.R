
install.packages("tm")
library(tm)

install.packages("stringr")
library(stringr)

install.packages("wordcloud")
library(wordcloud)

aa<-readLines("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/MrModi_Speech_IndependenceDay_20171.txt")
getwd()    ### getwd helps in locating the path of the file 
aa

text<-paste(readLines("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/MrModi_Speech_IndependenceDay_20171.txt"),collapse = " ")
text

text<-tolower(text)    ### Since R is case sensitive we either convert the doc to lowercase or uppercase ###
text

print(stopwords())

text2<-removeWords(text,stopwords())
text2

bag_of_word1<-str_split(text2," ")
bag_of_word1

str(bag_of_word1)

bag_of_word1<-unlist(bag_of_word1)

wordcloud(bag_of_word1,min.freq = 10) 

