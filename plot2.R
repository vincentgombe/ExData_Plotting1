#set working directory otherwise use current one
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

electricity <- fread("./data/household_power_consumption.txt")
electricity <- as.data.table(electricity)

electricity$DateTime <- paste(electricity$Date, electricity$Time, sep=" ")
electricity$Date <- as.Date(electricity$Date,"%d/%m/%Y")
electricity$Day <- weekdays(electricity$Date)

##################################

plot2 <- filter(electricity,Date == "2007/02/01" | Date == "2007/02/02" & electricity$Global_active_power != "?")%>%
	select(Day,Date,DateTime,Global_active_power)

plot2$DateTime <- strptime(plot2$DateTime,"%d/%m/%Y %H:%M:%S")
plot2$Global_active_power <- as.numeric(plot2$Global_active_power)


png("./plot2.png",height =480,width =480)
par(bg = "grey")		
plot(plot2$DateTime, plot2$Global_active_power,
type="l",
xlab="", 
ylab="Global Active Power (kilowatts)")
dev.off()


