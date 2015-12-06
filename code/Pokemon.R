library(dplyr)
library(readr)
setwd("/users/alicewang/desktop/stat133/finalproject/code")
type_reference <- read_csv("../rawdata/types.csv")
pokemon_stats <- read_csv("../rawdata/pokemon_stats.csv")
pokemon_types <- read_csv("../rawdata/pokemon_types.csv")
stat_names <- read_csv("../rawdata/stat_names.csv")
types <-  c('water', 'fire', 'flying', 'ground', 'poison', 'dragon', 'dark', 'ice', 'electric', 'rock' )
get_type_by_id <- function(id) {
  return(type_reference[type_reference$id == id,]$identifier[1])
}
get_first <- function(arr) {
  return(arr[1])
}
pokemon_id_types <- group_by(pokemon_types, pokemon_id) %>% 
  summarise(
    type_id = get_first(type_id)
  ) %>%
  mutate(
    type = sapply(type_id, get_type_by_id)
  ) %>%
  select(-type_id)
type_counts <- group_by(pokemon_id_types, type) %>%
  summarise(
    pokemon_count = length(pokemon_id)
  ) %>%
  filter(type %in% types)


stats_and_types <- left_join(pokemon_id_types, pokemon_stats) %>%
  filter(stat_id %in% c(2,4)) %>%
  group_by(pokemon_id) %>% 
  summarise(
    power = sum(base_stat), type = get_first(type)
  )
type_power <- group_by(stats_and_types, type) %>%
  summarise(total_power = sum(power))

result <- left_join(type_counts, type_power) %>%
  mutate(
    avg_power = as.integer(floor(total_power / pokemon_count))
  )

result$color <- c('black', 'turquoise', 'yellow', 'red', 'maroon', 'brown', 'white', 'purple', 'grey', 'blue')
if (!dir.exists("../data")) dir.create("../data") 
file.create("../data/types.csv")
write.csv(x = result, file = "../data/types.csv", row.names = FALSE)


