library(ggplot2)
library(dplyr)
library(readr)

#First, import the tables from Clean Data
pokemon_types <- read_csv("../data/types.csv")
natural_disasters <- read_csv("../data/NaturalDisasters.csv")
economic_data <- read_csv("../data/Econ.csv")

#INSERT TITLE AND DESCRIPTION
#Number of pokemon per type
ggplot(data = pokemon_types, aes(type, pokemon_count, 
                                 fill = type)) + geom_bar(stat = "identity") 
+ scale_fill_manual(values = pokemon_types$color)
# From here, we can see that there is an overwhelming amount of water pokemon in
# the world and not that many flying types. All the other types have pretty much
# the same amount of pokemon.

#INSERT TITLE AND DESCRIPTION
#Total Destructive Power of pokemon per type
ggplot(data = pokemon_types, aes(type, total_power, fill = type)) +
geom_bar(stat = "identity") + scale_fill_manual(values = pokemon_types$color)
# This looks relatively the same as the last plot. It seems that no matter what
# type, it is strength in numbers that prevail for the total amount of data

#INSERT TITLE AND DESCRIPTION
#Average Destructive Power of Pokemon per Type
ggplot(data = pokemon_types, aes(type, avg_power, fill = type)) +
geom_bar(stat = "identity") + scale_fill_manual(values = pokemon_types$color)
# Now we see a different trend. It seems that now dragon types have the most
# average power per pokemon. Most of the other types have a power metric around
# 150 units.

#INSERT TITLE AND DESCRIPTION
#Exploratory analysis of Natural Disasters Data Set
#Let's first plot the occurrences of natural disasters per year
occurrences <- group_by(natural_disasters, year) %>% summarise(count = length(casualty))
ggplot(data = occurrences, aes(year, count)) + geom_line() + geom_point() +
labs(x = "year", y = "occurences", xlim = seq(1995,2016))
# From this we see a steady rise and fall in natural disasters in the US over the years.

#INSERT TITLE AND DESCRIPTION
# Let's now plot the number of casualties from natural disasters per year
ggplot(data = natural_disasters, aes(year, casualty)) + geom_bar(stat = "identity") 
# Wow, it looks like 2008 had an abnormally large amount of casualties from
# natural disasters over the years. 

#INSERT TITLE AND DESCRIPTION
#Let's now plot the economic cost of natural disasters over the years.
ggplot(data = natural_disasters, aes(year, cost)) + geom_bar(stat = "identity")
# It looks like 2005 has one of the greatest economic cost from disasters. This
# is possibly from the occurrences of hurrican katrina. It is also interesting
# to note how although the number of casualties in 2008 was abnormally high, the
# economic cost was not as great. Let's see the most casualties affected by each
# disaster

#INSERT TITLE AND DESCRIPTION
ggplot(data = natural_disasters, aes(type, casualty)) + geom_bar(stat = "identity")
# From this, it can be seen a bulk of the disasters stem from fires.
# Now, let's assess economic cost per disaster.

#INSERT TITLE AND DESCRIPTION
ggplot(data = natural_disasters, aes(type, cost)) + geom_bar(stat = "identity")
# It seems that forest fires had an abnormally large amount of costs compared
# with the other types of disasters
