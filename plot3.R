# Data source:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# QuickStart--
#   Unzip dataset file in same directory as 'plot3.R' script
#   Execute 'plot3.R' script

dsFile <- "household_power_consumption.txt"
outFile <- "plot3.png"

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
png(outFile, width=480, height=480)  # open PNG graphics device

with(pc07, {
  plot(datetime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", legend=colnames(pc07[7:9]), col=c("black", "red", "blue"), lty=1)
})

dev.off()  # close PNG graphics device
