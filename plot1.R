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

# Format numeric values
data$Global_active_power <- as.numeric(data$Global_active_power)

# Display histogram
hist(data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Copy histogram to a PNG file
dev.copy(png,filename="plot1.png")
dev.off ()