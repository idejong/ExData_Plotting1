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
#    to a datetime datatype.
data_subset$datetime <- with(data_subset, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

# 6. Convert the datatype of the Global_active_power, Voltage, the Sub_metering variables
#    and Global_reactive_power to numeric:
data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
data_subset$Voltage <- as.numeric(data_subset$Voltage)
data_subset$Sub_metering_1 <- as.numeric(data_subset$Sub_metering_1)
data_subset$Sub_metering_2 <- as.numeric(data_subset$Sub_metering_2)
data_subset$Sub_metering_3 <- as.numeric(data_subset$Sub_metering_3)
data_subset$Global_reactive_power<- as.numeric(data_subset$Global_reactive_power)

# 7. Construct the four graphs of plot4 in a png graphical device:
png(filename = "plot4.png", width = 480, height = 480)

# Set the parameters to fit four graphs in one screen:
par(mfrow = c(2,2), mar = c(4,4,2,1))

with(data_subset, {
  plot(Global_active_power~datetime, type="n", ylab='Global Active Power', xlab="")
  lines(Global_active_power~datetime)})

with(data_subset, {
  plot(Voltage~datetime, type="n", ylab="Voltage", xlab="datetime")
  lines(Voltage~datetime)})

with(data_subset, {
  plot(Sub_metering_1~datetime, type= "n", ylab = "Energy sub metering", xlab="")
  lines(Sub_metering_1 ~ datetime, col="black")
  lines(Sub_metering_2 ~ datetime, col="red")
  lines(Sub_metering_3 ~ datetime, col="blue")
  legend("topright", col = c("black", "red", "blue"), lwd = 1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))})

with(data_subset, {  
  plot(Global_reactive_power~datetime, type="n", ylab="global_reactive_power", xlab="datetime")
  lines(Global_reactive_power~datetime)})

dev.off()



