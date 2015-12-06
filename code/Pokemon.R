#Required Packages
library(dplyr)
library(readr)
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
result$color <- c('black', 'turquoise', 'yellow', 'red', 'maroon',
                  'brown', 'white', 'purple', 'grey', 'blue')

#Create resulting table
file.create("../data/types.csv")

#Write result table to created file
write.csv(x = result, file = "../data/types.csv", row.names = FALSE)


