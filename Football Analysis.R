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
