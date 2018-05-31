### Plots a line chart of global active power over time and saves to a png file

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

## Plot line chart of global active power over time, saving it to a png file
png(filename = "plot2.png")
plot(seq_along(dataset$Time), 
     dataset$Global_active_power, 
     type = "l", xaxt = "n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
# Add tick marks to x-axis to show days
idx_fri <- min(seq_along(weekdays(dataset$Date))[weekdays(dataset$Date) == "Friday"])
idx_end <- length(dataset$Date)
axis(side = 1, at = c(0, idx_fri, idx_end), 
     labels = c("Thu", "Fri", "Sat"))
dev.off()
