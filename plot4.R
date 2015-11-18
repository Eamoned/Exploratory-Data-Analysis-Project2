if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile='./data/DatasetFNEI.zip')  # Create zip file and download dataset
unzip(zipfile ='./data/DatasetFNEI.zip', exdir='./data')    # unzip file

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Plot 4
# Changes in Emissions from coal combustion-related sources.
# SEE README FOR DETAILS FOR CHOOSING THIS DATASET
#subset dataset for "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal" 

library(ggplot2)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

coalPulv <- subset(NEI, SCC=='10100101') 
groupby <- group_by(coalPulv, year)
sumTotal <- summarise(groupby, Emissions=sum(Emissions))

dev.copy(png, file='plot4.png', width=480, height=480)
with(sumTotal, plot(year, Emissions, pch=20, cex=2, main='Total PM2.5 Emissions for Pulverized Coal (US)', ylab='Emissions of PM2.5 (Tons)', xlab='Year'))
fit <- lm(Emissions ~ year, sumTotal )
abline(fit, lwd=1, col='blue')
dev.off()
