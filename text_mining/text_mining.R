library(rtweet)
library(ggplot2)
library(dplyr)
library(tm)
library(wordcloud)

get_token()


rstat_tweets <- search_tweets(q="Ketahanan Pangan", n= 1000)

head(rstat_tweets, n=5)
textdata <- head(rstat_tweets$text)
textdata <- rstat_tweets$text
tweet_doc <- Corpus(VectorSource(textdata))

# clean corpus
tweet_doc <- tm_map(tweet_doc, content_transformer(tolower))
tweet_doc <- tm_map(tweet_doc, removeNumbers)
tweet_doc <- tm_map(tweet_doc, removeWords)
tweet_doc <- tm_map(tweet_doc, removePunctuation)
tweet_doc <- tm_map(tweet_doc, stripWhitespace)

# convert corpus for futher manipulation
dtm <- TermDocumentMatrix(tweet_doc)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(frequency=v)
d <- data.frame(word=names(v), frequency=v)
head(d,10)


# plot most frequent
barplot(d[1:15,]$frequency, las=2, names.arg = d[1:15,]$word, col = "salmon", 
        main = "Top 15 Most Frequent Words", ylab = "word frequencies" )

# wordcloud
set.seed(1234)
wordcloud(words=d$word, freq = d$frequency, min.freq = 5, max.words = 1000, 
          random.order = F, colors = brewer.pal(8, "Dark2"), rot.per = 0.3)
