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
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Prepare plot layout
par(mfrow=c(2,2))

# Display plot 1
plot(data$DateTime, data$Global_active_power, xlab="", 
     ylab="Global Active Power", type="l")

# Display plot 2
plot(data$DateTime, data$Voltage, xlab="datetime", 
     ylab="Voltage", type="l")

# Display plot 3
plot(data$DateTime, data$Sub_metering_1, xlab="", ylab="Energy sub metering", 
     type="n")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","red","blue"), bty="n", cex=0.9)

# Display plot 4
plot(data$DateTime, data$Global_reactive_power, xlab="datetime", 
     ylab="Global_reactive_power",type="l")

# Copy histogram to a PNG file
dev.copy(png,filename="plot4.png")
dev.off ()