library(dplyr)
library(readr)
library(ggplot2)
#Cleaning the Data:
#Reading in the raw data
rawnd <- read.csv("../rawdata/naturaldisasters.csv")
#Creating the column type and specifying them precisely
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

#Creating the corresponding pokemon types as another column in data frame
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

#Making the final data frame called nd(Natural Disasters) 
#Contains the columns:
# year
# type of natural disaster
# type of pokemon correspondence
# casualties
# ecoomic cost

nd <- data.frame("year" = rawnd[,1], 
                 "type" = types,
                 "poke_type" = new_types, 
                 "casualty" = rawnd[,5]+rawnd[,6]+rawnd[,7], 
                 "cost" = rawnd[,10])

#Writing the data frame into a file
file.create("../data/NaturalDisasters.csv")
write.csv(nd,"../data/NaturalDisasters.csv")

####Economic Cost Data
#####Process to Cleaning the Economics Data: 
#####1) Reading in the File
Raw_GDP <- read.csv("../rawdata/GDP_Data.csv", stringsAsFactors = FALSE)
#####2) Clean Data:
#####I wanted to remove the introductory piece, specifically, where this Data was obtained from (sorry), so that only the numbers remain. 
Quarter = Raw_GDP[-1:-10,1]
GPD = as.numeric(Raw_GDP[-1:-10,2])
Quarterly_GDP_Data <- data.frame(
  'Quarter' = Quarter, 
  'GDP' = GPD, stringsAsFactors = FALSE)
#####3) Create Yearly GDP
Every_4th <- seq(0,nrow(Quarterly_GDP_Data),by = 4)
Last_Row <- nrow(Quarterly_GDP_Data)
Annual_GDP_Data <- data.frame(
  'Years' = 1995:2015,
  'GDP' = Quarterly_GDP_Data[c(Every_4th,Last_Row),2])
#####4) Export Data
file.create("../data/Econ.csv")
write.csv(x = Annual_GDP_Data, file = "../data/Econ.csv", row.names = FALSE)

#Read raw data
type_reference <- read_csv("../rawdata/types.csv")
pokemon_stats <- read_csv("../rawdata/pokemon_stats.csv")
pokemon_types <- read_csv("../rawdata/pokemon_types.csv")
stat_names <- read_csv("../rawdata/stat_names.csv")

#Wanted types
types <-  c('water', 'fire', 'flying', 'ground', 'poison', 'dragon',
            'dark', 'ice', 'electric', 'rock' )

#Returns a pokemon's character-form type from a numeric id
get_type_by_id <- function(id) {
  return(type_reference[type_reference$id == id,]$identifier[1])
}

#Returns the first element of an array
get_first <- function(arr) {
  return(arr[1])
}

#Pokemon character-form types per id
pokemon_id_types <- group_by(pokemon_types, pokemon_id) %>% 
  summarise(
    type_id = get_first(type_id)
  ) %>%
  mutate(
    type = sapply(type_id, get_type_by_id)
  ) %>%
  select(-type_id)

#Number of pokemon per type that is in types (defined above)
type_counts <- group_by(pokemon_id_types, type) %>%
  summarise(
    pokemon_count = length(pokemon_id)
  ) %>%
  filter(type %in% types)

#Table of pokemon id's corresponding to their type and power (attack + special
#attack stats)
stats_and_types <- left_join(pokemon_id_types, pokemon_stats) %>%
  filter(stat_id %in% c(2,4)) %>%
  group_by(pokemon_id) %>% 
  summarise(
    power = sum(base_stat), type = get_first(type)
  )

#Group stats_and_types table by stats
type_power <- group_by(stats_and_types, type) %>%
  summarise(total_power = sum(power))

#result table joins the pokemon counts and power metric by type
result <- left_join(type_counts, type_power) %>%
  mutate(
    avg_power = as.integer(floor(total_power / pokemon_count))
  )

#Add a color corresponding to each type (For data visualization purposed)
result$color <- c('#000000', '#00e5ee', '#ffff00', '#ff0000', '#800000', 
                  '#f4a460', '#ffffff', '#551a8b', '#d3d3d3', '#0000ff')

#Create resulting table
file.create("../data/types.csv")

#Write result table to created file
write.csv(x = result, file = "../data/types.csv", row.names = FALSE)



