library(dplyr)
library(readr)
setwd("/users/alicewang/desktop/stat133/finalproject/")
rawnd <- read.csv("./rawdata/naturaldisasters.csv")
types <- c()
type <- as.character(rawnd[,2])
subtype <- as.character(rawnd[,3])
subsubtype <- as.character(rawnd[,11])
for (i in 1:155) {
  if (subsubtype[i] == "--"|| subsubtype[i] == "") {
    if (subtype[i] == "--") {
      types <- c(types, type[i])
    } else if (subtype[i] != "--") {
      types <- c(types, subtype[i])
    }
  } else if (subsubtype[i] != "--") {
    types <- c(types, subsubtype[i])
  }
}

poke_types <- c("ice","fire", "flying", "water", "water", "electric", 
                "flying","ice", "fire", "fire","electric", "flying", "water", 
                "fire", "ice", "ground", "ice", "poison", "rock", 
                "fire", "fire", "ice", "dragon", "dark")
nd_types <- c("Cold wave", "Heat wave", "Storm", "Riverine flood", 
              "Flood","Convective storm", "Tropical cyclone", 
              "Winter storm/Blizzard", "Forest fire", 
              "Land fire (Brush, Bush, Pastur", "Lightning", 
              "Tornado", "Flash flood", "Drought", "Hail", 
              "Ground movement","Extreme temperature ", "Viral disease", 
              "Landslide", "Wildfire","Ash fall", "Severe winter conditions",
              "Extra-tropical storm", "Severe storm")

new_types <- c()
for (t in types) {
  index <- which(nd_types == t)
  if (length(which(nd_types == t)) == 0) {
    print(t)
  }
  new_types <- c(new_types, poke_types[index])
}

nd <- data.frame("year" = rawnd[,1], "type" = types,"poke_type" = new_types, "casualty" = rawnd[,5]+rawnd[,6]+rawnd[,7], "cost" = rawnd[,10])

file.create("./data/NaturalDisasters.csv")
write.csv(nd,"./data/NaturalDisasters.csv")
