# Set working directory
setwd("D:/GitHub/ExData_Plotting1")

# Read data from source file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
fileData <- read.table(unz(temp, "household_power_consumption.txt"), 
                       header=TRUE, sep=";", stringsAsFactors = FALSE)
unlink(temp)

# Use local file if existing in local
#fileData <- read.table("files/household_power_consumption.txt", 
#                       header=TRUE, sep=";", stringsAsFactors = FALSE)

# Format Date column to date format
fileData$Date <- as.Date(fileData$Date, "%d/%m/%Y") 

# Get data subset data from 2007-02-01 to 2007-02-02
data <- fileData[fileData$Date == "2007-02-01" | 
                   fileData$Date == "2007-02-02",]

# Create new field DateTime that shows both Date & Time
data$DateTime <- strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S")

# Format numeric values
data$Global_active_power <- as.numeric(data$Global_active_power)

# Display plot
plot(data$DateTime, data$Global_active_power, xlab="", 
     ylab="Global Active Power (kilowatts)", type="l")

# Copy histogram to a PNG file
dev.copy(png,filename="plot2.png")
dev.off ()