sms_spam_df<-read.csv("file:///C:/Users/hp/Desktop/kirtiwardhan/may25/spam.csv")
dim(sms_spam_df)

sms_spam_df<-sms_spam_df[,c(1,2)]
dim(sms_spam_df)

colnames(sms_spam_df)<-c("type","text")
View(sms_spam_df)

library(tm)
library(stringr)
library(wordcloud)

sms_corpus<-Corpus(VectorSource(sms_spam_df$text))  ### Corpus is a collection of documents (here I have 6778 documents) ###
class(sms_corpus)

clean_corpus<-tm_map(sms_corpus,tolower)   ### format the corpus to lowercase or uppercase ###

clean_corpus<-tm_map(clean_corpus,removeNumbers)      ### remove the numbers from the corpus ###

clean_corpus<-tm_map(clean_corpus,removePunctuation)    ### Remove the Punctuatuion such as comma, <,>,. ###

clean_corpus<-tm_map(clean_corpus,removeWords,stopwords())   ### Remove the stopwords ###
 
clean_corpus<-tm_map(clean_corpus,stripWhitespace)   ### to remove white spcaes ###

inspect(clean_corpus[6])        #### to inspect the corpus and [5] indicates the 5th document from corpus ###

sms_dtm<-DocumentTermMatrix(clean_corpus)
dim(sms_dtm)        ### In DTM,each word becomes a colunm and DTM is always a sparse matrix ###


sms_raw_train<-sms_spam_df[1:4169,]   ### sampling on sms_spam_df dataset ###
sms_raw_test<-sms_spam_df[4170:6778,]

sms_dtm_train<-sms_dtm[1:4169,]
sms_dtm_test<-sms_dtm[4170:6778,]

sms_corpus_train<-clean_corpus[1:4169]  ### COmma is not used as Corpus is a collection of document ###
sms_corpus_test<-clean_corpus[4170:6778]   ### COmma is not used as Corpus is a collection of document ### 

five_times_words<-findFreqTerms(sms_dtm_train,5)  ### selecting the words that are appearing atleast 5 times in document ###
length(five_times_words)     #### it give yout the collection of counts of words that appeared atleast 5 times ####

library(tm)
sms_train<-DocumentTermMatrix(sms_corpus_train,control = list(dictionary = five_times_words))
dim(sms_train)

sms_test<-DocumentTermMatrix(sms_corpus_test,control = list(dictionary = five_times_words))
dim(sms_test)
                                     ### User defined function ###
convert_count<-function(x){
  y<-ifelse(x>0,1,0)
  y<-factor(y,levels = c(0,1),labels = c("No","Yes"))
  y
}
 
sms_train<-apply(sms_train,2,convert_count)   ### 2 is for column
sms_test<-apply(sms_test,2,convert_count)

View(sms_train)
View(sms_test)

library(e1071)

#### building a model ###
sms_classifier<-naiveBayes(sms_train,factor(sms_raw_train$type))    #### why naivebayes? (NB works on conditional probaility)

sms_test_pred<-predict(sms_classifier,newdata=sms_test)

sms_test_actual<-data.frame(sms_test_pred,sms_raw_test$type)

colnames(sms_test_actual)<-c('PR','AC')
sms_test_actual

table_sms<-table(sms_test_actual$PR,sms_test_actual$AC) ### work it as spam details went to ham ### 

accu_sms<-sum(diag(table_sms)/sum(table_sms))

#### run code only once especially while training and testing the data ###

