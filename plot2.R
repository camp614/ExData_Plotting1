# Data source:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# QuickStart--
#   Unzip dataset file in same directory as 'plot2.R' script
#   Execute 'plot2.R' script

dsFile <- "household_power_consumption.txt"
outFile <- "plot2.png"

# Check for presence of dataset
if(!file.exists(dsFile)) {
  stop(paste0("Dataset file '", dsFile, "' not found."), call.=F)
}

# Load dataset
pc <- read.table(dsFile, header=T, sep=";", na.strings="?", colClasses=c("character", "character", rep("numeric", 7)))

# Only examine Feb 1 & 2 from 2007
# ** original date format = day/month/year **
pc07 <- subset(pc, Date=="1/2/2007" | Date=="2/2/2007")

# Create timestamp variable
pc07$datetime <- strptime(paste(pc07$Date, pc07$Time), "%d/%m/%Y %H:%M:%S")

# Construct plot
png(outFile, width=480, height=480, type="cairo")  # open PNG graphics device

with(pc07, {
  plot(datetime, Global_active_power, col="black", type="l", xlab="", ylab="Global Active Power (kilowatts)")
})

dev.off()  # close PNG graphics device
