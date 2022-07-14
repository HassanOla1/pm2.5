## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips=="06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

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

mobile <- grep("Mobile", SCC[,"EI.Sector"], ignore.case = T, value = T)
vehiclesSCC <- subset(SCC,EI.Sector==mobile)
vehiclesNEI <- subset(NEI, SCC %in% vehiclesSCC$SCC)
#subset Baltimore city and Los Angeles 
NEI_motor_Baltimore<-subset(vehiclesNEI, fips=="24510")
NEI_motor_LA <- subset(vehiclesNEI, fips=="06037")

png("plot6.png")
#set a panel
par(mfrow=c(1,2))
#plot
boxplot(log10(NEI_motor_Baltimore$Emissions)~NEI_motor_Baltimore$year,xlab="year",ylab="log(PM2.5)_Baltimore",ylim=c(-7,3))
boxplot(log10(NEI_motor_LA$Emissions)~NEI_motor_LA$year,xlab="year",ylab="log(PM2.5)_LA",ylim=c(-7,3))

dev.off()