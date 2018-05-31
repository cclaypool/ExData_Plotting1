### Plots a line chart of sub metering 1, 2 and 3 over time
### with separate lines for each and saves to a png file

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

## Plot line chart of sub metering 1-3 over time, saving it to a png file
png(filename = "plot3.png")
# Plot sub metering 1
plot(seq_along(dataset$Time), 
     dataset$Sub_metering_1, 
     type = "l", xaxt = "n",
     xlab = "",
     ylab = "Energy sub metering")
# Add sub metering 2
points(seq_along(dataset$Time), 
                 dataset$Sub_metering_2, 
                 type = "l", col = "red")
# Add sub metering 3
points(seq_along(dataset$Time), 
                 dataset$Sub_metering_3, 
                 type = "l", col = "blue")
# Add tick marks to x-axis to show days
idx_fri <- min(seq_along(weekdays(dataset$Date))[weekdays(dataset$Date) == "Friday"])
idx_end <- length(dataset$Date)
axis(side = 1, at = c(0, idx_fri, idx_end), 
     labels = c("Thu", "Fri", "Sat"))
# Add legend
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), lwd = c(1, 1, 1))
dev.off()
