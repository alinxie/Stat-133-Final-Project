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
power_damage <- data.frame("natural" = nd_disasters, 
                           "types" = nd[,"poke_type"], 
                           "avg_power" = poke_power, 
                           "economic_damage" = nd[,"cost"],
                           "casualty" = nd[,"casualty"])

poke_type <- unique(nd_types)

ice <- subset(power_damage, poke_type == "ice")
fire <- subset(power_damage, poke_type == "fire")
flying <- subset(power_damage, poke_type == "flying")
water <- subset(power_damage, poke_type == "water")
electric <- subset(power_damage, poke_type == "electric")
ground <- subset(power_damage, poke_type == "ground")
poison <- subset(power_damage, poke_type == "poison")
rock <- subset(power_damage, poke_type == "rock")
dragon <- subset(power_damage, poke_type == "dragon")
dark <- subset(power_damage, poke_type == "dark")

damage <- c(sum(dark[,"cost"]), 
            sum(dragon[,"cost"]), 
            sum(electric[,"cost"]), 
            sum(fire[,"cost"]), 
            sum(flying[,"cost"]), 
            sum(ground[,"cost"]), 
            sum(ice[,"cost"]), 
            sum(poison[,"cost"]), 
            sum(rock[,"cost"]), 
            sum(water[,"cost"]))
casualties <- c(sum(dark[,"casualty"]), 
                sum(dragon[,"casualty"]), 
                sum(electric[,"casualty"]), 
                sum(fire[,"casualty"]), 
                sum(flying[,"casualty"]), 
                sum(ground[,"casualty"]), 
                sum(ice[,"casualty"]), 
                sum(poison[,"casualty"]), 
                sum(rock[,"casualty"]), 
                sum(water[,"casualty"]))
power <- poke[,"total_power"]

test <- data.frame("type" = poke[,"type"], 
                   "damage" = damage, 
                   "power" = power, 
                   "casualty" = casualties)

####Pokemon type vs. Pokemon power
####This graph sees the relationship  between type of Pokemon and their economic damage 
####which is the corresponding economic cost that the corresponding natural disasters
####caused.
ggplot(test, aes(x = poke[,"type"][[1]])) + 
  geom_bar(aes(y = test[,"total_power"], 
               fill = poke[,"type"][[1]]), 
           stat = "identity") +
  ggtitle("Pokemon type and their power") + 
  xlab("Type") +
  ylab("Power") + 
  scale_fill_manual(name = "types",
                    values = 
                      c('#000000', '#00e5ee', '#ffff00', '#ff0000', '#800000', 
                  '#f4a460', '#ffffff', '#551a8b', '#d3d3d3', '#0000ff')) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

ggsave("../images/PokemonType_Power.png")
ggsave("../images/PokemonType_Power.pdf")

####Pokemon type vs. economic damage
####This graph sees the relationship  between type of Pokemon and their power 
####which is the attack and special attack of each pokemon.
ggplot(test, aes(x = poke[,"type"][[1]])) + 
  geom_bar(aes(y = test[,"damage"], 
               fill = poke[,"type"][[1]]), 
           stat = "identity") + 
  ggtitle("Pokemon type and their economic damage") + 
  xlab("Type") + 
  ylab("Damage") + 
  scale_fill_manual(name = "types", 
                    values = 
                      c('#000000', '#00e5ee', '#ffff00', '#ff0000', '#800000', 
                  '#f4a460', '#ffffff', '#551a8b', '#d3d3d3', '#0000ff')) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

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

ggplot(test, aes(x = poke[,"type"][[1]])) + geom_bar(aes(y = test[,"casualty"],
fill = poke[,"type"][[1]]), stat = "identity") + ggtitle("Pokemon type and
their casualty damage") + xlab("Type") + ylab("Casualties") +  scale_fill_manual(name = "types", 
                    values = 
                      c('#000000', '#00e5ee', '#ffff00', '#ff0000', '#800000', 
                  '#f4a460', '#ffffff', '#551a8b', '#d3d3d3', '#0000ff')) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

ggsave("../images/PokemonType_Casualties.png")
ggsave("../images/PokemonType_Casualties.pdf")

####The total variation distance is not going to be 0. 

