library(jsonlite)
library(XML)
library(plyr)
library(dplyr)

###===========PLAYER PERFORMANCE DETAIL PULL=========###
URL1 <- "http://www.foxsports.com/soccer/"
URL2 <- "-team-stats?competition=1&season="
URL3 <- "&type=1&category=STANDARD"

#URL used as reference
#http://www.foxsports.com/soccer/arsenal-team-stats?competition=1&season=2014&type=1&category=STANDARD

team <- c("arsenal", "liverpool", "chelsea", "manchester-united", "manchester-city", "everton", "tottenham-hotspur",
          "west-ham-united", "newcastle-united", "aston-villa", "southampton","crystal-palace",
          "swansea-city", "west-bromwich-albion", "stoke-city", "sunderland")

season <- c("2015", "2014", "2013")

players <- data.frame(readHTMLTable(paste0(URL1, team[1], URL2, season[1], URL3), 
                                    stringsAsFactors = FALSE, header = TRUE))
players$team <- team[1]
players <- players[1,]
players$season <- season[1]

for (j in 1:length(season)){
  for( i in 1:length(team)){
    player <- data.frame(readHTMLTable(paste0(URL1, team[i], URL2, season[j], URL3), 
                                       stringsAsFactors = FALSE, header = TRUE))
    player$team <- team[i]
    player$season <- season[j]
    players <- rbind(players, player)
  }
  
}
players <- players[c(2:length(players$season)),]
rm(player, i, j, URL1, URL2, URL3, team)

###=============PLAYER MARKET VALUE & POSITION PULL======###

#data <- readHTMLTable("http://www.transfermarkt.com/manchester-city/kader/verein/281/saison_id/2015/plus/1",
#                      which = 4)
###==========================================###
nr.name <- NULL
nr.name[1] <- 2
a <- 1:5000
for(i in 1:5000){
  nr.name[i+1] <- a[3*i+2]
}

nr.value <- NULL
nr.value[1] <- 1 
for(i in 1:5000)
  nr.value[i+1] <- a[3*i+1]

nr.pos <- NULL
nr.pos[1] <- 3
for(i in 1:5000)
  nr.pos[i+1] <- a[3*(i+1)]
###==========================================###

###======PULLING VALUE and POSITION OF PLAYERS=====###
URL4 <- "http://www.transfermarkt.com/"
URL5<- "/kader/verein/"
URL6 <- "/saison_id/"
URL7 <- "/plus/1"

teamID <- read.csv("team-ID.csv")

players.val <- data.frame(readHTMLTable(paste0(URL4, teamID$Team[1], URL5, teamID$ID[1], 
                                            URL6, season[1], URL7), which = 4,
                                     stringsAsFactors = FALSE, header = TRUE))
players.val$team <- teamID$Team[1]
players.val <- players.val[1,]
players.val$season <- season[1]
player.val$Current.club <- NULL

for (j in 1:length(season)){
  for( i in 1:length(teamID$Team)){
    playerval <- data.frame(readHTMLTable(paste0(URL4, teamID$Team[i], URL5, teamID$ID[i],
                                              URL6, season[j], URL7), which = 4,
                                       stringsAsFactors = FALSE, header = TRUE))
    playerval$Current.club <- NULL
    playerval$team <- teamID$Team[i]
    playerval$season <- season[j]
    players.val <- rbind(players.val, playerval)
  }
}

players.val <- players.val[c(2:length(players.val$season)),]
rm(player.val, i, j, URL7, URl6, URl5, URl4)


players.name <- as.data.frame(players.val[nr.name, 2])
players.name <- na.omit(players.name)

players.value <- as.data.frame(players.val[nr.value, c(10,11,12)])
players.value <- na.omit(players.value)

players.pos <- as.data.frame(players.val[nr.pos, 1])
players.pos <- na.omit(players.pos)

players.data.2 <- cbind(players.name, players.value, players.pos)

rm(players.name, players.pos, players.val, players.val, players.value, playerval, teamID,
   a, nr.name, nr.pos, nr.value, season, URL4, URL5, URL6)

###=====JOINING THE 2 DATASETS========###
players$UID <- paste(players$NULL., players$season)
players.data.2$UID <- paste(players.data.2$`players.val[nr.name, 2]`, players.data.2$season)

finaldata <- left_join(players, players.data.2, by = "UID")
