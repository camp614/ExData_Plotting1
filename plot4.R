# Data source:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# QuickStart--
#   Unzip dataset file in same directory as 'plot4.R' script
#   Execute 'plot4.R' script

dsFile <- "household_power_consumption.txt"
outFile <- "plot4.png"

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

# Construct plots
png(outFile, width=480, height=480)  # open PNG graphics device

par(mfrow=c(2, 2))

with(pc07, {
  ## plot 1
  plot(datetime, Global_active_power, col="black", type="l", xlab="", ylab="Global Active Power")

  ## plot 2
  plot(datetime, Voltage, col="black", type="l")
  
  ## plot 3
  plot(datetime, Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", legend=colnames(pc07[7:9]), col=c("black", "red", "blue"), lty=1, bty="n")

  ## plot 4
  plot(datetime, Global_reactive_power, col="black", type="l")
})

dev.off()  # close PNG graphics device
