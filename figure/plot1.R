---
title: "Exploratory Data Analisys Course Project"
author: "Darwin Nava"
date: "March 25, 2021"
file: "plot1.R"
---
#[Link to project on GitHUB]( https://github.com/darwinnava/ExData_Plotting1 )

# Objective:   
# Reconstruct plots contained in the gibhut repository available at the following link:
# https://github.com/rdpeng/ExData_Plotting1 using the data base plotting system. 

## 1. Required Libraries
library(dplyr)  # for manipulating, gruoping and chaining data
library(tidyr)  # for tidying data
library(plyr)   # for manipulating data
library(data.table) #  for manipulating data

## 2. Downloading data from the source supplied by coursera
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## Downloading and unzipping data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/dataset.zip")  # Windows OS (method="curl" not required)
unzip("./data/dataset.zip")

## 3. Tidyng Data. 
## "We will only be using data from the dates 2007-02-01 and 2007-02-02.I'm goint to use a package called sqldf. Dim(2880 x 9)"
## "Convert the Date and Time variables to Date/Time classes(classes "POSIXlt" and "POSIXct" )"
## "Missing values are coded as ?"

## Reading file (raw data). Manipulating data. Giving the columns appropriate names/format.

install.packages("sqldf")
library(sqldf)
f <- "household_power_consumption.txt"
dataset <- read.csv.sql(f, sql = "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'", sep = ";", eol = "\n")

date_time <- paste(dataset$Date, dataset$Time)
dataset$date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")

## creating histogram
hist(dataset$Global_active_power, col= "red", xlab="Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

## generating png file and closing device
dev.copy(png, file="plot1.png")
dev.off()
