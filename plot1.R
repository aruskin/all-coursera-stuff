# Get data
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "electric_power.zip", method = "curl")
unzip("electric_power.zip")
power <- fread("household_power_consumption.txt", header=TRUE, sep=";")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- power[Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))]

# Column read in as text; convert to number
power$Global_active_power <- as.numeric(power$Global_active_power )

# Make plot
png("plot1.png")
hist(power$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
