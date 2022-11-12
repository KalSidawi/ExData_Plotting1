## this script plot2.R produces the plot2.png in the root directory
## which is the xy plot showing Global Active Power in Kilowatts vs time
## the statistical data of power consumption is present in the file 
## "household_power_consumption.txt"
## and is filtered to the target range of Feb 1 and 2 of 2007

library(data.table)
library(tibble)
library(tidyverse)
rm(list = ls())
setwd("C:/code/Rprog/exploration/ExData_Plotting1")
varclasses <- c("character", "character", rep("numeric",7) )
if(file.exists("household_power_consumption.txt"))
   {
     consumption <- read.table("household_power_consumption.txt", 
                header = TRUE, sep = ";", na.strings = "?", dec = ".",
                colClasses = varclasses)
   } else {
    stop("file \"household_power_consumption.txt\" does not exist!")
  }
# read the data set
classes <- c(rep(x = "character",2),rep(x = "numeric", 7))
dataset <- as.data.table(read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = classes))
# subsetting to get data for Feb 1 and Feb 2, 2007
sub <- subset(x = dataset, Date == "1/2/2007" | Date == "2/2/2007" )
# concatenating Date and Time fields and then converting to POSIXlt Date/Time format field
DateTime <- strptime(paste(sub$Date, sub$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
# adding the new DateTime field to the Data set in column 1
sub <- data.table(DateTime, sub)

###############################
# Data is now ready to be plotted
###############################
browser()
with(sub, plot(y = Global_active_power, x = DateTime, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
## copy the plot to a png file
dev.copy(png, file = "plot2.png")
dev.off()
dev.off()

