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
png("plot2.png")

# Generate the chart
plot(pow$DateTime, pow$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
# Close the device
dev.off()
