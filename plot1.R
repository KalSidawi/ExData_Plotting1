## this script plot1.R produces the plot1.png in the root directory
## which is the histogram showing frequency vs Global Active Power in Kilowatts
## the statistical data of power consumption is present in the file 
## "household_power_consumption.txt"
library(data.table)
library(tibble)
library(tidyverse)
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

hist(x = sub$Global_active_power, freq = TRUE, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
## copy the plot to a png file
dev.copy(png, file = "plot1.png")
browser()
dev.off()
dev.off()

