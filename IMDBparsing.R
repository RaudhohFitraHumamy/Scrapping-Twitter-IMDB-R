#load data and package

library('rvest')
url <- 'https://www.imdb.com/search/title/?year=2019&title_type=feature&'

#Reading the HTML code from the website
webpage <- read_html(url)

#get list of film "container" 
container <- webpage %>% html_nodes(".lister-item")


#make variables for every variable

ranks <- c()
titles <- c()
descs <- c()
metascores <- c()
stars <- c()
directors <- c()
votes <- c()
grosses <- c()
i <-1

#loop all container to get all variable value

for (c in container){
  ranking_dt <- c %>% html_nodes('.text-primary') %>% html_text %>% as.numeric
  title_dt <- c %>% html_nodes('.lister-item-header a') %>% html_text
  description_dt <- c %>% html_nodes('.ratings-bar+ .text-muted') %>% html_text(trim=TRUE)
  metascore_dt <- c %>% html_nodes(".ratings-metascore span") %>% html_text %>% as.numeric
  star_dt <- c %>% html_nodes('.lister-item-content p a:nth-child(n+2)') %>% html_text
  director_dt <- c %>% html_nodes('.lister-item-content p a') %>% html_text
  vote_dt <- c %>% html_nodes('p.sort-num_votes-visible span:nth-child(2)') %>% html_text %>% as.numeric
  gross_dt<-c %>% html_nodes('.sort-num_votes-visible span:nth-child(5)') %>% html_text %>% as.numeric
  
  
  #if value not found, return 0 or "NA"
  
  ranking = ifelse(length(ranking_dt)==0,0,ranking_dt)
  title = ifelse(length(title_dt)==0,"NA",title_dt)
  description = ifelse(length(description_dt)==0,"NA",description_dt)
  metascore = ifelse(length(metascore_dt)==0,0,metascore_dt)
  star = ifelse(length(star_dt)==0,"NA",star_dt)
  director = ifelse(length(director_dt)==0,"NA",director_dt)
  vote = ifelse(length(vote_dt)==0,0,vote_dt)
  gross = ifelse(length(gross_dt)==0,0,gross_dt)
  
  ranks[[i]] <- ranking
  titles[[i]] <- title
  descs[[i]] <- description
  metascores[[i]] <- metascore
  stars[[i]] <- star
  directors[[i]] <- director
  votes[[i]] <- vote
  grosses[[i]] <- gross
  
  i <- i + 1
}

#convert into dataframe
df <- data.frame(
  ranks,titles,descs, metascores, stars, directors, votes, grosses
)

head(df)

#write into csv
write.csv(df, "top100moviesin2019.csv")

