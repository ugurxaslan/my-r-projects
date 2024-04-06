#1.1
download.file(
  "https://raw.githubusercontent.com/scizmeli/Red/master/MapsThatChangedOurWorld_StoryMap_Data.csv",
  destfile = "MapsThatChangedOurWorld_StoryMap_Data.csv"
  )
#1.2
maps <- read.csv("MapsThatChangedOurWorld_StoryMap_Data.csv", sep=";" , header = TRUE)

#1.3
maps$Latitude <- as.numeric(gsub("N", "", maps$Latitude))

#1.4
idx <- which(grepl("W", maps$Longitude))

#1.5
maps$Longitude <- as.numeric(gsub("[EW]", "", maps$Longitude))

#1.6
maps$Year <- as.numeric(gsub(" AD", "", maps$Year))

#1.7
maps$Latitude <- as.numeric(maps$Latitude)
maps$Longitude <- as.numeric(maps$Longitude)

#1.8
hist(maps$Year, breaks = 10, main = "Histogram of Year", xlab = "Year" ,col="yellow")

#1.9
maps$Longitude[idx] <- maps$Longitude[idx] * -1

#1.10
finalResult <- maps[c("Longitude", "Latitude", "Year")]



