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

