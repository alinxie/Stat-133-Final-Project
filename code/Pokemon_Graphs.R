library(ggplot2)
library(dplyr)
library(readr)

#importing the tables from Clean Data
pokemon_types <- read_csv("../data/types.csv")
natural_disasters <- read_csv("../data/NaturalDisasters.csv")
economic_data <- read_csv("../data/Econ.csv")

### POKEMON ANALYSIS ###

#Number of pokemon per type
ggplot(data = pokemon_types, aes(type, 
                                 pokemon_count, fill = type)) + 
  geom_bar(stat = "identity") + 
  scale_fill_manual(values = pokemon_types$color) +
  ggtitle("Number of Pokemon per Type") +
  xlab("Type") +
  ylab("Pokemon Count")

#Type with greatest # of pokemon
most_pokemon <- with(pokemon_types, type[which.max(pokemon_count)])

#Type with least # of pokemon
least_pokemon <- with(pokemon_types, type[which.min(pokemon_count)])

#Total Destructive Power of pokemon per type
ggplot(data = pokemon_types, aes(type, total_power, fill = type)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = pokemon_types$color) +
  ggtitle("Total Destructive Power per Type") +
  xlab("Type") +
  ylab("Power")

#Most destructive pokemon type considering number of pokemon of each type
most_destructive <- with(pokemon_types, type[which.max(total_power)])

#Least destructive pokemon type considering number of pokemon of each type
least_destructive <- with(pokemon_types, type[which.min(total_power)])

#Average Destructive Power of Pokemon per Type
ggplot(data = pokemon_types, aes(type, avg_power, fill = type)) + 
  geom_bar(stat = "identity") + 
  scale_fill_manual(values = pokemon_types$color) +
  ggtitle("Average Power per Type") +
  xlab("Type") +
  ylab("Power")

#Most destructive pokemon type not considering number of pokemon of each type
avg_most_destructive <- with(pokemon_types, type[which.max(avg_power)])

#Least destructive pokemon type not considering number of pokemon of each type
avg_least_destructive <- with(pokemon_types, type[which.min(avg_power)])


### NATURAL DISASTERS ###

#occurrences of natural disasters per year
occurrences <- group_by(natural_disasters, year) %>%
  summarise(count = length(casualty))
ggplot(data = occurrences, aes(year, count)) + 
  geom_line(color = '#FF3456', size = 2) + 
  geom_point(color = '#FF3456', size = 5) +
  ggtitle("Number of Natural Disasters per Year from 1995-2015") +
  labs(x = "Year", y = "Occurences", xlim = seq(1995,2016))

#Year with the most natural disasters
most_disastrous_year <- with(occurrences, year[which.max(count)])

# Let's now plot the number of casualties from natural disasters per year
ggplot(data = natural_disasters, aes(year, casualty)) + geom_bar(stat = "identity") 

#Year with most casualties and how many
total_casualties <- group_by(natural_disasters, year) %>%
  summarise(casualty = sum(casualty))
year_most_casualties <- with(total_casualties, year[which.max(casualty)])
year_most_casualties_count <- with(total_casualties, casualty[which.max(casualty)])

#Economic cost of natural disasters over the years.
total_cost <- group_by(natural_disasters, year) %>%
  summarise(cost = sum(cost))
ggplot(data = total_cost, aes(year, cost)) +
  geom_line(color = '#FF3456', size = 2) + 
  geom_point(color = '#FF3456', size = 5) +
  ggtitle("Cost of Natural Disasters by Year") +
  labs(x = "Year", y = "Cost")

#Most expensive year
most_expensive_year <- with(total_cost, year[which.max(cost)])

#Most casualties by disaster
disaster_casualties <- group_by(natural_disasters, type) %>% summarise(casualty = sum(casualty))
barplot(disaster_casualties$casualty,  main = "Number of Casualties per Disaster",
        names.arg = disaster_casualties$type, 
        horiz = TRUE, col = "#A311F1", las = 1,
        ylab = 'Disaster', xlab = 'Number Casualties')

#Disaster with most casualties
disaster_most_casualties <- with(disaster_casualties, type[which.max(casualty)])

#Economic cost by disaster
disaster_cost <- group_by(natural_disasters, type) %>% summarise(cost = sum(cost))
barplot(disaster_cost$cost,  main = "Total Cost per Disaster",
        names.arg = disaster_cost$type, 
        horiz = TRUE, col = "#A311F1", las = 1,
        ylab = 'Disaster', xlab = 'Cost')

#Most expensive Disaster
most_expensive_disaster <- with(disaster_cost, type[which.max(cost)])

#Occurences of each disaster
disaster_occurrences <- group_by(natural_disasters, type) %>% summarise(count = length(casualty))
barplot(disaster_occurrences$count,  main = "Occurrences per Disaster",
        names.arg = disaster_occurrences$type, 
        horiz = TRUE, col = "#A311F1", las = 1,
        ylab = 'Disaster', xlab = 'Occurrences')

#Most occurrent Disaster
most_occurring <- with(disaster_occurrences, type[which.max(count)])
