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

# Plot 3:  Line graph of Global Active Power over time by submeter



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

png(filename = "Rplot03.png", width = 480, height = 480, units = "px")


with(Data_set, {
  plot(Date_TIME, as.numeric(Sub_metering_1), 
                    type ="l", 
                    ylab = "Global Active Power (kilowatts)", 
                    xlab = "")
  lines(Date_TIME, as.numeric(Sub_metering_2), 
                    type ="l", 
                    ylab = "Global Active Power (kilowatts)", 
                    xlab = "",
                    col = "red")
  lines(Date_TIME, as.numeric(Sub_metering_3), 
                    type = "l", 
                    col = "blue")
  }
  )
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))



dev.off()
