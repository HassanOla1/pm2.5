##1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

## Unzipping and Loading Files
library(dplyr)
library(ggplot2)
fil_name <- "pm2.5"
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists(fil_name)){
  download.file(file_url, destfile = fil_name)
  unzip(fil_name)
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#remove the scientific numbers
options(scipen = 50)
png(filename='plot1.png')
#subset the data
yr <- with(NEI, tapply(Emissions, year, sum, na.rm = T))
barplot(yr, xlab = "Years", ylab = "Emissions", main = "Emissions over the Years")

dev.off()