library(rstudioapi) 

# 0. Set the Working directory to the location holding this script Plot_1.R
setwd(dirname(getActiveDocumentContext()$path))

# 1. Load the data:
data <- read.table('..\\Data\\household_power_consumption.txt', sep=";", header = TRUE, stringsAsFactors=FALSE)

# 2. Convert Date and Time variables to Date/Time classes:
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# 3. Subset the data based on the dates of interest 2007-02-01 and 2007-02-02:
data_subset <- subset(data, ((data$Date == '2007-02-01') | (data$Date == '2007-02-02')))

# 4. Set language settigs to English for the weekday labels to be presented in English:
Sys.setlocale("LC_TIME", "C")

# 5. Merge Date and Time variables together in a new variable datetime, and use POSIXct to convert its datatype
#   to a datetime datatype.
data_subset$datetime <- with(data_subset, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# 6. Convert the datatype of the Sub_metering variables to numeric:
data_subset$Sub_metering_1 <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2 <- as.numeric(data_subset$Sub_metering_2)
data_subset$Sub_metering_3 <- as.numeric(data_subset$Sub_metering_3)

# 7. Construct plot3 in a png graphical device:
png(filename = "plot3.png", width = 480, height = 480)
plot(data_subset$Sub_metering_1 ~ data_subset$datetime, type= "n", ylab = "Energy sub metering", xlab="")
lines(data_subset$Sub_metering_1 ~ data_subset$datetime, col="black")
lines(data_subset$Sub_metering_2 ~ data_subset$datetime, col="red")
lines(data_subset$Sub_metering_3 ~ data_subset$datetime, col="blue")
legend("topright", col = c("black", "red", "blue"), lwd = 1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()