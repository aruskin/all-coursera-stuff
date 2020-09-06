# Get data
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "electric_power.zip", method = "curl")
unzip("electric_power.zip")
power <- fread("household_power_consumption.txt", header=TRUE, sep=";")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- power[Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))]

# Columns read in as text; convert to number
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)

# Deal with time
power[,DateTime :=  strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# Make plot
png("plot3.png")
plot(power$DateTime, power$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
