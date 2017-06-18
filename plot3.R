#set working directory otherwise use current
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

plot3 <- filter(electricity,Date == "2007/02/01" | Date == "2007/02/02" & Sub_metering_1  != "?" & Sub_metering_2  != "?" & Sub_metering_3  != "?")%>%
	select(Day,Date,DateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3)

plot3$DateTime <- strptime(plot3$DateTime,"%d/%m/%Y %H:%M:%S")
plot3$Sub_metering_1 <- as.numeric(plot3$Sub_metering_1)
plot3$Sub_metering_2 <- as.numeric(plot3$Sub_metering_2)

png("./plot3.png",height =480,width =480)
par(bg = "grey")
plot(plot3$DateTime, plot3$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(plot3$DateTime, plot3$Sub_metering_2, type="l", col="red")
lines(plot3$DateTime, plot3$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()



