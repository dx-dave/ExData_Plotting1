# Function for getting a subset of the Household Power data
readHouseholdPowerData <- function(startDate = "2007-02-01", endDate = "2007-02-02") {
  # Class for reading D/M/YYYY dates
  setClass("dmyDate")
  setAs("character","dmyDate", function(from) as.Date(from, format="%d/%m/%Y") )
  
  pow <- read.table("household_power_consumption.txt", 
                    sep = ";", 
                    header = TRUE, 
                    colClasses = c("dmyDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), 
                    na.strings = "?")
  
  # Subset the desired dates only
  p <- subset(pow, Date >= startDate & Date <= endDate)
  
  # Combine Date and Time into a single DateTime
  p$DateTime <- strptime(paste(p$Date, p$Time), "%Y-%m-%d %H:%M:%S")
  
  p
}

# Read the data
pow <- readHouseholdPowerData()

# Set up the PNG graphics device
png("plot4.png")

# Generate the charts - 2 columns, 2 rows
par(mfcol = c(2, 2))
# Global Active Power
plot(pow$DateTime, pow$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Sub_metering
plot(pow$DateTime, pow$Sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Engergy sub metering")

lines(pow$DateTime, pow$Sub_metering_1, col="black")
lines(pow$DateTime, pow$Sub_metering_2, col = "red")
lines(pow$DateTime, pow$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering1", "Sub_metering2", "Sub_metering3"), 
       lwd = c(1,1,1), 
       col = c("black", "red", "blue"))

# Voltage
plot(pow$DateTime, pow$Voltage, 
     type = "l", 
     xlab = "",
     ylab = "Voltage")

# Global Reactive Power
plot(pow$DateTime, pow$Global_reactive_power, 
     type = "l", 
     xlab = "",
     ylab = "Global_reactive_power")

# Close the device
dev.off()
