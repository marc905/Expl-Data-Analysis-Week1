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

# Plot 1:  Global Active Power Histogram



if(!file.exists("./Project")) 
{dir.create("./Project")
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "./Project/Power Consumption.zip")
  unzip('./Project/Power Consumption.zip' , exdir = 'Project')
}

power_data <- read.csv("./Project/household_power_consumption.txt", sep = ";")

power_data[,1]<- as.Date(power_data[,1], "%d/%m/%Y")

tmp <- date(c("2007/02/01", "2007/02/02"))
Date1 <- power_data[ grep(tmp[1], power_data[,1]), ]
Date2 <- power_data[ grep(tmp[2], power_data[,1]), ]
Data_set <- rbind(Date1, Date2)

library(plyr)
Data_set <- mutate(Data_set, Date_TIME = 
            strptime(paste(Data_set[,1] , Data_set[,2]),  format = "%Y-%m-%d %H:%M:%S"      ))

png(filename = "Rplot01.png", width = 480, height = 480, units = "px")
hist(as.numeric(Data_set[,3]), col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", 
     ylab = "Frequency")
dev.off()




