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

## Create datetime variable
dataset$datetime <- strptime(paste(dataset$Date, dataset$Time), 
                             "%d/%m/%Y %H:%M:%S")

## Subset to keep only relevant dates
keep <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
dataset <- subset(dataset, as.Date(datetime) %in% keep)

## Plot line chart of sub metering 1-3 over time, saving it to a png file
png(filename = "plot3.png")
# Plot sub metering 1
plot(dataset$datetime, 
     dataset$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
# Add sub metering 2
lines(dataset$datetime, 
      dataset$Sub_metering_2, 
      col = "red")
# Add sub metering 3
lines(dataset$datetime, 
      dataset$Sub_metering_3, 
      col = "blue")
# Add legend
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), lwd = c(1, 1, 1))
dev.off()
