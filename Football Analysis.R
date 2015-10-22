library(XML)
library(jsonlite)
library(ggplot2)
library(plyr)
library(dplyr)

playerpull <- function(name, ID){
  URL1 <- "http://www.transfermarkt.co.uk/"
  URL2 <- "/leistungsdatendetails/spieler/"
  URL3 <- "/saison/2014/verein/631/liga//wettbewerb//pos//trainer_id//plus/1"
  FinalURL <- paste0(URL1 , name , URL2 , ID , URL3)
  
  return(readHTMLTable(FinalURL, header = TRUE, which = 6))
}

player <- playerpull("eden-hazard", "50202")
player <- rbind(player, playerpull("gary-cahill", "27511"))



##################

URL <- "http://www.foxsports.com/soccer/players?competition="
players <- data.frame(readHTMLTable(paste0(URL, 1)))
players <- players[1,]
for (i in 1:34){
  player <- data.frame(readHTMLTable(paste0(URL, i)))
  players <- rbind(players, player)
}
players <- players[c(2:851),]


################# ---- FOX all players-----
#for season 2015
players.2015 <- data.frame(readHTMLTable(paste0(URL1, team[1], URL2, "season[1]","2015", URL3), stringsAsFactors = FALSE, header = TRUE))
players.2015$team <- team[1]
players.2015 <- players.2015[1,]

for( i in 1:length(team)){
  player <- data.frame(readHTMLTable(paste0(URL1, team[i], URL2, "2015", URL3), stringsAsFactors = FALSE, header = TRUE))
  player$team <- team[i]
  players.2015 <- rbind(players.2015, player)
}

players.2015$season <- 2015
players.2015 <- players.2015[c(2:length(players.2015$team)),]

#for season 2014
players.2014 <- data.frame(readHTMLTable(paste0(URL1, team[1], URL2, "2014", URL3), stringsAsFactors = FALSE, header = TRUE))
players.2014$team <- team[1]
players.2014 <- players.2014[1,]

for( i in 1:length(team)){
  player <- data.frame(readHTMLTable(paste0(URL1, team[i], URL2, "2014", URL3), stringsAsFactors = FALSE, header = TRUE))
  player$team <- team[i]
  players.2014 <- rbind(players.2014, player)
}

players.2014$season <- 2014
players.2014 <- players.2014[c(2:length(players.2014$team)),]







