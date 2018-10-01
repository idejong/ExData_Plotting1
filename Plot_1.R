
library(rstudioapi) 

# 0. Set the Working directory to the location holding this script Plot_1.R
setwd(dirname(getActiveDocumentContext()$path))

# 1. Load the data:
data <- read.table('..\\Data\\household_power_consumption.txt', sep=";", header = TRUE, stringsAsFactors=FALSE)

# 2. Convert Date and Time variables to Date/Time classes:
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# 3. Subset the data based on the dates of interest 2007-02-01 and 2007-02-02:
data_subset <- subset(data, ((data$Date == '2007-02-01') | (data$Date == '2007-02-02')))

# 4. Convert the datatype of Global_active_power to numeric:
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)

# 5. Construct plot1 in a png graphical device:
png(filename = "plot1.png", width = 480, height = 480)
hist(data_subset$Global_active_power, col="red", xlab='Global Active Power (kilowatts)', ylab='Frequency', main='Global Active Power')
dev.off()

