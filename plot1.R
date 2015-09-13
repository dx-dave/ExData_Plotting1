# Function for getting a subset of the Household Power data
readHouseholdPowerData <- function(startDate = "2007-02-01", endDate = "2007-02-02") {
  setClass("dmyDate")
  setAs("character","dmyDate", function(from) as.Date(from, format="%d/%m/%Y") )
  
  pow <- read.table("household_power_consumption.txt", 
                    sep = ";", 
                    header = TRUE, 
                    colClasses = c("dmyDate","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), 
                    na.strings = "?")
  
  subset(pow, Date >= startDate & Date <= endDate)
}

# Read the data
pow <- readHouseholdPowerData()

# Set up the PNG graphics device
png("plot1.png")

# Generate the chart
hist(pow$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# Close the device
dev.off()
