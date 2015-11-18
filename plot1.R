if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile='./data/DatasetFNEI.zip')  # Create zip file and download dataset
unzip(zipfile ='./data/DatasetFNEI.zip', exdir='./data')    # unzip file

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

# Plot1
# Has total emissions from PM2.5 decreased in the United States from 1999 to 2008?

sums <- tapply(NEI$Emissions, NEI$year, sum) #Calculate sum of each year
years <- unique(NEI$year) #vector of years

# Base Plotting System

dev.copy(png, file='plot1.png')
plot(years, sums, cex=2, cex.main=1, pch=20, main='Total PM2.5 Emissions From All Sources', ylab='Emissions of PM2.5 (Tons)', xlab='Year')
fit <- lm(sums ~ years)
abline(fit, lwd=1, col='blue')
dev.off()


# Alternatively
# Barplot
# sums <- tapply(NEI$Emissions, NEI$year, sum) #Calculate sum of each year
# dev.copy(png, file='plot1.png')
# barplot(sums, main='Total PM2.5 Emissions From All Sources', ylab='Emissions of PM2.5 (Tons)', xlab='Year')
# dev.off()
