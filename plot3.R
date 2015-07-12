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
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Display plot
plot(data$DateTime, data$Sub_metering_1, xlab="", ylab="Energy sub metering", 
     type="n")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")

# Add legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red","blue"))

# Copy histogram to a PNG file
dev.copy(png,filename="plot3.png")
dev.off ()