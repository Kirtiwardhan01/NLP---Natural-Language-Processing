install.packages("tidyverse")
library(tidyverse)

install.packages("tokenizers")
library(tokenizers)

text <- paste("Now, I understand that because it's an election season",
              "expectations for what we will achieve this year are low.",
              "But, Mister Speaker, I appreciate the constructive approach",
              "that you and other leaders took at the end of last year",
              "to pass a budget and make tax cuts permanent for working",
              "families. So I hope we can work together this year on some",
              "bipartisan priorities like criminal justice reform and",
              "helping people who are battling prescription drug abuse",
              "and heroin abuse. So, who knows, we might surprise the",
              "cynics again")

words<-tokenize_words(text)

length(words)       # The reason that the length is equal to 1 is that the function "tokenize_words" returns 
                    #  a list object with one entry per document in the input #

length(words[[1]])  # The result is 89, indicating that there are 89 words in this paragraph of text #

tab<-table(words[[1]])                                       
tab<-data_frame(word = names(tab),count=as.numeric(tab))
tab    

# The output from this command should look like this in your console 
# (a tibble is a specific variety of a data frame created by the tidydata package)

# The separation of the document into individual words 
#  makes it possible to see how many times each word was used in the text. 
#To do so, we first apply the table function to the words in the first (and here, only) document 
# and then split apart the names and values of the table into a single object called a data frame. 

arrange(tab,desc(count))

# We can also sort the table using the arrange function. 
# The arrange function takes the dataset to be worked on, here tab, and then the name of the column to arrange by. 
# The desc function in the second argument indicates that we want to sort in descending order

# The most common words are pronouns and functions words such as "and", "i", "the", and "we".
# Notice how taking the lower-case version of every word helps in the analysis here.
# The word "We" at the start of the sentence is not treated differently than the "we" in the middle of a sentence

sentences<-tokenize_sentences(text)

length(sentences[[1]])

# Detecting Sentence Boundaries #
# the function "tokenize_sentences" that splits a text into sentences rather than words #

sentences_words<-tokenize_words(sentences[[1]])
sentences_words
length(sentences_words)

# If we pass the sentences split from the paragraph to the tokenize_words function, 
# each sentence gets treated as its own document 

sapply(sentences_words,length)

# We can see that we have four sentences that are length 19, 32, 29 and 9
# We will use this function to manage larger documents


