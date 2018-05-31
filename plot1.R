### Plots a histogram of global active power and saves to a png file

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

## Plot a histogram of global active power, saving the plot to a png file
png(filename = "plot1.png")
hist(as.numeric(dataset$Global_active_power), col = "red", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")
dev.off()