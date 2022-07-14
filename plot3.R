## Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


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
#subset baltimore
baltimore <- filter(NEI, fips == "24510")
png("plot3.png")
g <- ggplot(data = baltimore,aes(factor(year),Emissions))
g+ geom_point() + facet_grid(.~type) + geom_smooth(method="lm")+ ylab(expression("log"*PM[2.5]))
dev.off()