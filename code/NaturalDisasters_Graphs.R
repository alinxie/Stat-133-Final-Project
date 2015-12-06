library(dplyr)
library(ggplot2)
setwd("/Users/alicewang/Desktop/STAT133/finalproject/code")

###Correlations between Pokemon, Natural Disasters and Economic Cost
####Reading in the clean data and making the oranized data tables 
nd <- read_csv("../data/NaturalDisasters.csv")
econ <- read_csv("../data/Econ.csv")
poke <- read_csv("../data/types.csv")

###Question: Is there a correlation between types of Pokemon damage and its corresponding 
####natural disasters?
####We can see it by comparing the types vs their power and then the types 
####vs their economic damage
####First, organize the Pokemon types into subgroups and create vectors that
####correspond to the damage and power

nd_types <- nd[,"poke_type"][[1]]
nd_disasters <- nd[,"type"][[1]]

poke_power <- c()
for (t in nd_types) {
  type_row <- subset(poke, type == t)
  poke_power <- c(poke_power, as.numeric(type_row[,"total_power"]))
}
power_damage <- data.frame("natural" = nd_disasters, "types" =
nd[,"poke_type"], "avg_power" = poke_power, "economic_damage" = nd[,"cost"])

poke_type <- unique(nd_types)

ice <- subset(power_damage, types == "ice")
fire <- subset(power_damage, types == "fire")
flying <- subset(power_damage, types == "flying")
water <- subset(power_damage, types == "water")
electric <- subset(power_damage, types == "electric")
ground <- subset(power_damage, types == "ground")
poison <- subset(power_damage, types == "poison")
rock <- subset(power_damage, types == "rock")
dragon <- subset(power_damage, types == "dragon")
dark <- subset(power_damage, types == "dark")

damage <- c(sum(dark[,"cost"]), sum(dragon[,"cost"]), sum(electric[,"cost"]),
sum(fire[,"cost"]), sum(flying[,"cost"]), sum(ground[,"cost"]),
sum(ice[,"cost"]), sum(poison[,"cost"]), sum(rock[,"cost"]),
sum(water[,"cost"]))

power <- poke[,"total_power"]

test <- data.frame("type" = poke[,"type"], "damage" = damage, "power" = power)

####Pokemon type vs. Pokemon power
####This graph sees the relationship  between type of Pokemon and their economic damage 
####which is the corresponding economic cost that the corresponding natural disasters
####caused.
ggplot(test, aes(x = poke[,"type"][[1]])) + geom_bar(aes(y =
test[,"total_power"], fill = poke[,"type"][[1]]), stat = "identity") +
ggtitle("Pokemon type and their power") + xlab("Type") +
ylab("Power")+scale_fill_manual(values = c('black', 'turquoise', 'yellow',
'red', 'maroon', 'brown', 'white', 'purple', 'grey', 'blue'))
ggsave("../images/PokemonType_Power.png")
ggsave("../images/PokemonType_Power.pdf")

####Pokemon type vs. economic damage
####This graph sees the relationship  between type of Pokemon and their power 
####which is the attack and special attack of each pokemon.
ggplot(test, aes(x = poke[,"type"][[1]])) + geom_bar(aes(y = test[,"damage"],
fill = poke[,"type"][[1]]), stat = "identity") + ggtitle("Pokemon type and
their economic damage") + xlab("Type") +
ylab("Damage")+scale_fill_manual(values = c('black', 'turquoise', 'yellow',
'red', 'maroon', 'brown', 'white', 'purple', 'grey', 'blue'))
ggsave("../images/PokemonType_EconDamage.png")
ggsave("../images/PokemonType_EconDamage.pdf")

#### As you can see, there is no relationship, but water type which is the most common 
####Pokemon type, caused the second most economic damage and have the most power.

####What is the most occurring natural disaster?
sort(table(nd[,"type"]), decreasing = TRUE)[1]

####Convective storms are the most occurring natural disaster, however their economic
####damage and power are not very high. It's corresponding Pokemon type is "flying" 
####and it is the type with the least power.
#### Conclusion: There is no relationship between Pokemon types' damage and their
#### power.

