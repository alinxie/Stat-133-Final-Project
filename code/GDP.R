library(dplyr)
library(readr)
setwd("/users/alicewang/desktop/stat133/finalproject/")
Raw_GDP <- read.csv("../rawdata/GDP_Data.csv", stringsAsFactors = FALSE,col.names = c("Quarter","GDP"))
Quarterly_GDP_Data <- Raw_GDP[-1:-10,]
Quarterly_GDP_Data <- data.frame(
  'Quarter' = Quarterly_GDP_Data[,1], 
  'GDP' = Quarterly_GDP_Data[,2], stringsAsFactors = FALSE)
Quarterly_GDP_Data[,"GDP"] <- as.numeric(Quarterly_GDP_Data[,"GDP"])
Annual_GDP_Data <- data.frame(
  'Years' = 1995:2015,
  'GDP' = Quarterly_GDP_Data[c(seq(0,nrow(Quarterly_GDP_Data),by = 4),nrow(Quarterly_GDP_Data)),'GDP'])
if (!dir.exists("../data")) dir.create("../data") 
file.create("../data/Econ.csv")
write.csv(x = Annual_GDP_Data, file = "../data/Econ.csv", row.names = FALSE)
