###Is there a trend between Natural Disaster and GDP? 
####First, I'll need to read in the Data sets
Econ <- read.csv('../data/Econ.csv')
Natural_Disasters <- read.csv('../data/NaturalDisasters.csv')

####Next, I'll need to manipulate the Data sets so I can merge the. The thing about Natural Disasters, is that I only need to know the total amount of damage done in a year--the type of disaster isn't necessary at the moment. 
####We'll use dplyr for this
#identify/create variables
Year <- 1995:2015
Damages <- c()

for (i in 1995:2015) {
  Dmg_per_year <- sum(filter(Natural_Disasters, year == i)[,'cost'])
  Damages <- c(Damages,Dmg_per_year)
}

####create the data frame for total damage caused per year
Natural_Disaster_Damages <- data.frame(
  'Years' = Year,
  'Damages' = Damages
)
Econ[,'GDP']<- Econ[,'GDP'] *1000000

####merge data frames
Econ_vs_ND_Damages <- merge(Econ,Natural_Disaster_Damages,by = "Years")

###Create the Graph 

####Note that GDP is measured in Billions, and the Damage is measured in dollar value.
library(ggplot2)

#Trend of GDP per Year
ggplot(Econ_vs_ND_Damages, aes(Years,GDP)) + 
  geom_point(color = '#ff0000', size = 3) + 
  ggtitle("GDP vs Years")

ggsave("../images/1GDPvsYears.png")
ggsave("../images/1GDPvsYears.pdf")

#Trend of Damages per Year
ggplot(Econ_vs_ND_Damages, aes(Years,Damages)) + 
  geom_point(color = '#ff0000', size = 3) + 
  ggtitle("Damages vs Years")

ggsave("../images/2DamagesvsYears.png")
ggsave("../images/2DamagesvsYears.pdf")


####There appears to be no correlation between GDP and Damages per year. 
####Even though GDP is rising each year, Damages per Year does not seem to be affecting it.

###Which Natural Disaster causes the most damage/influence in GDP
####Well, in the previous analysis, there is no clear distinction on the 
####relationship between GDP and Natural Damages year by year. 
####Regardless, it would still be interesting to see how the yearly data of natural disasters!
# x-axis = year
# y- axis = total damage that year 
# variable = type of natural disaster
ggplot(Natural_Disasters,aes(year,cost)) + 
  geom_bar(aes(fill = type),stat = 'identity') +
  ggtitle("Most Damaging Natural Disaster per Year")
