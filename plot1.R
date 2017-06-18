
#set working directory otherwise use current working directory
#setwd("C:/Users/Vincent/Cousera/Exploratory Data Analysis")

library(data.table)
library(dplyr)

Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dir <- "./data"
dest <- "./data/electric.zip"


if(!file.exists(dir)){
dir.create(dir)

download.file(Url,dest)

downloadDate <- date()
downloadDate 

data.files <- unzip(dest,exdir = "./data")
}



electricity <- tbl_df(fread("./data/household_power_consumption.txt"))

electricity$Date <- as.Date(electricity$Date,"%d/%m/%Y")


electrictySubset <- filter(electricity,Date == "2007/02/01" | Date == "2007/02/02")

str(electrictySubset)


#plot.1

png("./plot1.png")
par(bg = "grey")
hist(as.numeric(electrictySubset$Global_active_power), main = "Global Active Power",
ylab = "Frequency",
xlab = "Global Active Power (kilowatts)",
col = "red")
dev.off()

