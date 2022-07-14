## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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
#subset mobile vehicle sources
mobile <- grep("Mobile", SCC[,"EI.Sector"], ignore.case = T, value = T)
vehiclesSCC <- subset(SCC,EI.Sector==mobile)
vehiclesNEI <- subset(NEI, SCC %in% vehiclesSCC$SCC)

NEI_motor_Baltimore<-subset(vehiclesNEI, fips=="24510")
png("plot5.png")
ggplot(NEI_motor_Baltimore,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill="blue" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
dev.off()