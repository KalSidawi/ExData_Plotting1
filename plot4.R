## this script plot4.R produces the plot4.png in the root directory
## which contains the previous plots 2 & 3 and adds to it
## Voltage vs datetime and Global reactive power vs datetime
## the statistical data of power consumption is present in the file 
## "household_power_consumption.txt"
## and is filtered to the target range of Feb 1 and 2 of 2007

library(data.table)
library(tibble)
library(tidyverse)
rm(list = ls())
setwd("C:/code/Rprog/exploration/ExData_Plotting1")
if(!file.exists("household_power_consumption.txt"))
   {
    stop("file \"household_power_consumption.txt\" does not exist!")
  }
# read the data set
classes <- c(rep(x = "character",2),rep(x = "numeric", 7))
dataset <- as.data.table(read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classes))
# subsetting to get data for Feb 1 and Feb 2, 2007
sub <- subset(x = dataset, Date == "1/2/2007" | Date == "2/2/2007" )
remove(dataset)
# concatenating Date and Time fields and then converting to POSIXlt Date/Time format field
DateTime <- strptime(paste(sub$Date, sub$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
# adding the new DateTime field to the Data set in column 1
sub <- data.table(DateTime, sub)
###############################
# Data is now ready to be plotted
###############################

par("mfcol" = c(2, 2))
with(sub, plot(y = Global_active_power, x = DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
par("lab" = c(3, 4, 7))
with(sub, plot(y = Sub_metering_1, x = DateTime, type = "l", col = "black", ylim = c(0, 30), xlab = "", ylab = "Energy sub metering"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), fill = c("black", "red", "blue"))
par("new" = TRUE)
with(sub, plot(y = Sub_metering_2, x = DateTime, type = "l", col = "red", ylim = c(0, 30), ann = FALSE, axes = FALSE))
par("new" = TRUE)
with(sub, plot(y = Sub_metering_3, x = DateTime, type = "l", col = "blue", ylim = c(0, 30), ann = FALSE, axes = FALSE))
par("new" = FALSE)
par("lab" = c(3, 7, 7))
with(sub, plot(Voltage ~DateTime, type = "l", ylim = c(234, 246)))
par("lab" = c(3, 6, 7))
with(sub, plot(Global_reactive_power ~DateTime, type = "l", ylim = c(0.0, 0.5)))
## copy the plot to a png file
dev.copy(png, file = "plot4.png")
dev.off()
dev.off()

