#title: "Twitter Scraping With R"
#author : "RaudhohFitrah"


#load necessary library
library(rtweet)

#Setup customer secret key and access token  (Replace with yours)
token <- create_token(
  consumer_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  consumer_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  access_token = "xxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  access_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")


#Define (Developer) Username
my_username : 'raudhohfitra_h'


#Scrapping process using "TAEMINinJKT" which has 22.1 K Tweets by 23/8/19
tweet <- search_tweets(q = "#TAEMINinJKT", n = 1000)


#Inspect scrapping result (I)
colnames(tweet)


#Inspect scrapping result 
res <- tweet[,c("created_at", "screen_name", "text", "country","place_full_name")]
head(res)

#And Finally export to CSV
write.csv(res, "Taemin.csv")

