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


## Convert Date variable from string to Date
dataset$Date <- as.Date(strptime(dataset$Date, format = "%d/%m/%Y"))

## Subset to keep only relevant dates
dataset <- subset(dataset, 
                  Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))


## Plot graphs, saving to a png file
png(filename = "plot4.png")
par(mfcol = c(2, 2))
# Plot line chart of global active power over time
plot(seq_along(dataset$Time), 
     dataset$Global_active_power, 
     type = "l", xaxt = "n",
     xlab = "",
     ylab = "Global Active Power")
idx_fri <- min(seq_along(weekdays(dataset$Date))[weekdays(dataset$Date) == "Friday"])
idx_end <- length(dataset$Date)
axis(side = 1, at = c(0, idx_fri, idx_end), 
     labels = c("Thu", "Fri", "Sat"))
# Plot line chart of energy sub metering 1, 2 and 3 (separate lines for each)
# over time
plot(seq_along(dataset$Time), 
     dataset$Sub_metering_1, 
     type = "l", xaxt = "n",
     xlab = "",
     ylab = "Energy sub metering")
points(seq_along(dataset$Time), 
       dataset$Sub_metering_2, 
       type = "l", col = "red")
points(seq_along(dataset$Time), 
       dataset$Sub_metering_3, 
       type = "l", col = "blue")
axis(side = 1, at = c(0, idx_fri, idx_end), 
     labels = c("Thu", "Fri", "Sat"))
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), lwd = c(1, 1, 1), bty = "n")
# Plot line chart of voltage over time
plot(seq_along(dataset$Time),
     dataset$Voltage,
     type = "l", xaxt = "n",
     xlab = "datetime", ylab = "Voltage")
axis(side = 1, at = c(0, idx_fri, idx_end), 
     labels = c("Thu", "Fri", "Sat"))
# Plot line chart of global reactive power over time
plot(seq_along(dataset$Time),
     dataset$Global_reactive_power,
     type = "l", xaxt = "n",
     xlab = "datetime", ylab = "Global_reactive_power")
axis(side = 1, at = c(0, idx_fri, idx_end), 
     labels = c("Thu", "Fri", "Sat"))
# Shut down graphics device
dev.off()