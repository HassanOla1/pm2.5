# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?

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

#subset baltimore city
baltimore <- filter(NEI, fips == "24510")
bn <- with(baltimore, tapply(Emissions, year, sum, na.rm = T))
png(filename='plot2.png')
#plot
barplot(bn, xlab = "Years", ylab = "Emissions", main = "Emissions in Baltimore City over the Years")
dev.off()