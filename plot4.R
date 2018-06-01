### Plots the following graphs in a 2x2 arrangement, saving to a png file:
### * Line chart of global active power over time
### * Line chart of energy sub metering 1, 2 and 3 (separate lines for each)
###   over time
### * Line chart of voltage over time
### * Line chart of global reactive power over time

## Load data, downloading it if necessary
data_name <- "household_power_consumption"
data_zip <- paste(data_name, ".zip", sep = "")
data_txt <- paste(data_name, ".txt", sep = "")
if(!file.exists(data_zip)) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = url, destfile = data_zip, method = "curl")
}
data_con <- unz(data_zip, data_txt)
dataset <- read.table(data_con, sep = ";", header = TRUE, 
                      stringsAsFactors = FALSE)

## Create datetime variable
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), 
                             "%d/%m/%Y %H:%M:%S")

## Subset to keep only relevant dates
keep <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
dataset <- subset(dataset, as.Date(datetime) %in% keep)

## Plot graphs, saving to a png file
png(filename = "plot4.png")
par(mfcol = c(2, 2))
# Plot line chart of global active power over time
plot(dataset$datetime, 
     dataset$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
# Plot line chart of energy sub metering 1, 2 and 3 (separate lines for each)
# over time
plot(dataset$datetime, 
     dataset$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(dataset$datetime, 
      dataset$Sub_metering_2, 
      col = "red")
lines(dataset$datetime, 
      dataset$Sub_metering_3, 
      col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), lwd = c(1, 1, 1), bty = "n")
# Plot line chart of voltage over time
plot(dataset$datetime,
     dataset$Voltage,
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")
# Plot line chart of global reactive power over time
plot(dataset$datetime,
     dataset$Global_reactive_power,
     type = "l",
     xlab = "datetime", 
     ylab = "Global_reactive_power")
# Shut down graphics device
dev.off()