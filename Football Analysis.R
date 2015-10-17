library(jsonlite)
library(dplyr)
library(XML)

player <- readHTMLTable("http://www.transfermarkt.co.uk/eden-hazard/leistungsdatendetails/spieler/50202/saison/2014/verein/631/liga//wettbewerb//pos//trainer_id//plus/1",
                        which = 6, stringsAsFactors = FALSE) 
player$V1 <- "Eden Hazard"

value <- readHTMLTable("http://www.transfermarkt.co.uk/eden-hazard/leistungsdatendetails/spieler/50202/saison/2014/verein/631/liga//wettbewerb//pos//trainer_id//plus/1"
                       ,which = 1, stringsAsFactors = FALSE)
