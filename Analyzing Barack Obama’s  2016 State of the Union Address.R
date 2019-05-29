
              #### Analyzing Barack Obama's 2016 State of the Union Address ####


base_url <- "https://programminghistorian.org/assets/basic-text-processing-in-r"

url <- sprintf("%s/sotu_text/236.txt", base_url)

text <- paste(readLines(url), collapse = "\n")

# we will combine the readLines function to read the text into R and 
# the paste function to combine all of the lines into a single object
# We will build the URL of the text file using the sprintf function 
# as this format will make it easily modified to grab other addresses

library(tidyverse)
library(tokenizers)

words<-tokenize_words(text)
length(words[[1]])

tab<-table(words)
tab<-data_frame(word=names(tab),count=as.numeric(tab))
tab<-arrange(tab,desc(count))


# Once again, extremely common words such as "the", "to", "and", and "of" float to the top of the table. 
# These terms are not particularly insightful for determining the content of the speech. 
# Instead, we want to find words that are represented much more often in this text than over a 
# large external corpus of English. 
# To accomplish this we need a dataset giving these frequencies. 
# Here is a dataset from Peter Norvig using the Google Web Trillion Word Corpus, 
# collected from data gathered via Google's crawling of known English websites

wf <- read_csv(sprintf("%s/%s", base_url, "word_frequency.csv"))

# The first column lists the language (always "en" for English in this case), 
# the second gives the word and 
# the third the percentage of the Trillion Word Corpus consisting of the given word

# To combine these overall word frequencies with the dataset tab constructed from this one State of the Union speech, 
# we can utilize the inner_join function. This function takes two data sets and combines them on all commonly named columns

tab<-inner_join(tab,wf)

filter(tab,frequency < .1)

#This list is starting to look a bit more interesting. A term such as "america" floats to the top 
#because we might speculate that it is used a lot in speeches by politicians, 
#but relatively less so in other domains. 
#Setting the threshold even lower, to 0.002, gives an even better summary of the speech. 
#It will be useful to see more than the default first ten lines here, 
#so we will use the print function along with the option n set to 15 in order to print out more than the default 10 

print(filter(tab, frequency <.002),n=15)
      
#Now, these seem to suggest seem to suggest some of the key themes of the speech 
#such as "syria", "terrorist", and "qaida" (al-qaida is split into "al" and "qaida" by the tokenizer)


# Document Summarization
#To supply contextual information for the dataset we are analyzing we have provided 
#a table with metadata about each State of the Union speech.

metadata <- read_csv(sprintf("%s/%s", base_url, "metadata.csv"))
metadata

tab<-filter(tab,frequency <.002)
result<-c(metadata$president[236],metadata$year[236],tab$word[1:5])
paste(result,collapse = "; ")

# Does this line capture everything in the speech? Of course not. 
#Text processing will never replace doing a close reading of a text, 
#but it does help to give a high level summary of the themes discussed 
#(laughter come from notations of audience laughter in the speech text). 
# This summary is useful in several ways. It may give a good ad-hoc title and abstract for a document that has neither; 
# it may serve to remind readers who have read or listened to a speech what exactly 
#the key points discussed were; taking many summaries together 
#at once may elucidate large-scale patterns that get lost over a large corpus. 

#######################################################################################

