## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

## subset NEI with coal combustion-related sources using SCC

SCC_coal<-subset(SCC,EI.Sector==c("Fuel Comb - Electric Generation - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Comm/Institutional - Coal"))
NEI_coal<-subset(NEI,SCC %in% SCC_coal$SCC)
png("plot4.png")
ggplot(NEI_coal,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="blue", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
dev.off()