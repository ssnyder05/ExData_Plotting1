# plot3.R
#
# Coursera
# 4_Exploratory Data Analysis
# Project 1
#   Create graphs from UC Irvine Machine Learning Repository:
#   Individual household electric power consumption Data Set
#
# Sandra Snyder
# 11 December 2018

# Libraries
library(dplyr)
library(lubridate)

# Global Variables
dataFile <- 'household_power_consumption.txt'

# Read in data
data <- read.table(dataFile, sep=';', header=T, fill=T,
                   na.strings=c('?'), stringsAsFactors=F)

# Clean data
data <- data %>%
    # Select rows with date of interest
    filter(Date=='1/2/2007' | Date=='2/2/2007') %>%
    # Create a single field containing the Date and Time fields
    mutate(datetime=paste(Date, Time, sep=' '))
# Convert datetime field from text to POSIXlt
data$datetime <- dmy_hms(data$datetime)

# Open plotting device
png('plot3.png', width=480, height=480)
# Plot the graph
with(data, plot(datetime, Sub_metering_1, type='n', xlab='', 
                ylab='Energy sub metering'))
with(data, lines(datetime,Sub_metering_1, col='black'))
with(data, lines(datetime,Sub_metering_2, col='red'))
with(data, lines(datetime,Sub_metering_3, col='blue'))
legend('topright', lty=1, lwd=2, col=c('black','red','blue'), 
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
# Close device
dev.off()

# end plot3.R