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

head(electricity)
##################################

plot4 <- filter(electricity,Date == "2007/02/01" | Date == "2007/02/02" & Sub_metering_1  != "?" & Sub_metering_2  != "?" & Sub_metering_3  != "?" & Global_active_power != "?" & Voltage != "?" & Global_reactive_power != "?")%>%
	select(Day,Date,DateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3,Global_active_power,Voltage,Global_reactive_power)

plot4$DateTime <- strptime(plot4$DateTime,"%d/%m/%Y %H:%M:%S")
plot4$Sub_metering_1 <- as.numeric(plot4$Sub_metering_1)
plot4$Sub_metering_2 <- as.numeric(plot4$Sub_metering_2)
plot4$Global_active_power <- as.numeric(plot4$Global_active_power)
plot4$Voltage <- as.numeric(plot4$Voltage)
plot4$Global_reactive_power <- as.numeric(plot4$Global_reactive_power)

str(plot4)

png("./plot4.png",height =480,width =480)
par(bg = "grey",mfrow = c(2, 2))

plot(plot4$DateTime, plot4$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(plot4$DateTime, plot4$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(plot4$DateTime, plot4$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(plot4$DateTime, plot4$Sub_metering_2, type="l", col="red")
lines(plot4$DateTime, plot4$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=, lwd=2.5,col=c("black", "red", "blue"), bty="n")

plot(plot4$DateTime, plot4$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()




