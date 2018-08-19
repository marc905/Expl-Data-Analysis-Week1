# Marc Reitz
# Coursera Exploratory Data Analysis
# Week 1 COurse Project
# 8/18/2018

# Overview:  
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository 
# for machine learning datasets. In particular, we will be using the "Individual household electric 
# power consumption Data Set" 

# Dataset:  Description: Measurements of electric power consumption in one household with a one-minute 
# sampling rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Plot 4:  Multi-plot exercise 



if(!file.exists("./Project")) 
{dir.create("./Project")
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "./Project/Power Consumption.zip")
  unzip('./Project/Power Consumption.zip' , exdir = 'Project')
}

power_data <- read.csv("./Project/household_power_consumption.txt", sep = ";", na.strings = "?", 
                       colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

power_data[,1]<- as.Date(power_data[,1], "%d/%m/%Y")

tmp <- as.Date(c("2007/02/01", "2007/02/02"))
Date1 <- power_data[ grep(tmp[1], power_data[,1]), ]
Date2 <- power_data[ grep(tmp[2], power_data[,1]), ]
Data_set <- rbind(Date1, Date2)

library(plyr)
Data_set <- mutate(Data_set, Date_TIME = 
                     strptime(paste(Data_set[,1] , Data_set[,2]),  format = "%Y-%m-%d %H:%M:%S"      ))

png(filename = "Rplot04.png", width = 480, height = 480, units = "px")

#NEW CODE
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0, 0, 2, 0))
#Upper Left:  Plot from Question 2
with(Data_set, plot(Date_TIME, as.numeric(Global_active_power), 
                    type ="l", 
                    ylab = "Global Active Power", 
                    xlab = ""))
#Upper Right: Plot by voltage
with(Data_set, plot(Date_TIME, as.numeric(Voltage), 
  type ="l", 
  ylab = "Voltage", 
  xlab = "datetime"))

#Lower Left:  Submetering plot from Question 3
with(Data_set, {
  plot(Date_TIME, as.numeric(Sub_metering_1), 
       type ="l", 
       ylab = "Energy Submetering", 
       xlab = "")
  lines(Date_TIME, as.numeric(Sub_metering_2), 
        type ="l", 
        col = "red")
  lines(Date_TIME, as.numeric(Sub_metering_3), 
        type = "l", 
        col = "blue")
}
)
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1), bty = "n")

#Lower Right:  Global Reactive Power variable
with(Data_set, plot(Date_TIME, as.numeric(Global_reactive_power), 
                    type ="l", 
                    ylab = "Global_reactive_power", 
                    xlab = "datetime"))


dev.off()
