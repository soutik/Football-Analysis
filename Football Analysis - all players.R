library(jsonlite)
library(XML)

URL1 <- "http://www.foxsports.com/soccer/"
URL2 <- "-team-stats?competition=1&season="
URL3 <- "&type=1&category=STANDARD"

#URL used as reference
#http://www.foxsports.com/soccer/arsenal-team-stats?competition=1&season=2014&type=1&category=STANDARD

team <- c("arsenal", "liverpool", "chelsea", "manchester-united", "manchester-city", "everton", "tottenham-hotspur",
          "west-ham-united", "newcastle-united", "aston-villa", "leicester-city", "southampton","crystal-palace",
          "swansea-city", "west-bromwich-albion", "stoke-city", "sunderland")

season <- c("2015", "2014", "2013")

players <- data.frame(readHTMLTable(paste0(URL1, team[1], URL2, season[1], URL3), stringsAsFactors = FALSE, header = TRUE))
players$team <- team[1]
players <- players[1,]
players$season <- season[1]

for (j in 1:length(season)){
  for( i in 1:length(team)){
    player <- data.frame(readHTMLTable(paste0(URL1, team[i], URL2, season[j], URL3), stringsAsFactors = FALSE, header = TRUE))
    player$team <- team[i]
    player$season <- season[j]
    players <- rbind(players, player)
  }
  
}
players <- players[c(2:length(players$season)),]
rm(player, i, j)


