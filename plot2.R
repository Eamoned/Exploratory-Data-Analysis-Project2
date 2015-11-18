if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile='./data/DatasetFNEI.zip')  # Create zip file and download dataset
unzip(zipfile ='./data/DatasetFNEI.zip', exdir='./data')    # unzip file

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Plot 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')


#Base Plotting system

state <- subset(NEI, fips=='24510') #subset dataset for Baltimore
sums <- tapply(state$Emissions, state$year, sum) #Calculate sum of each year
years <- unique(state$year) #vector of years

dev.copy(png, file='plot2.png')
plot(years, sums, pch=20, cex=2,cex.main= 0.9, main='Total PM2.5 Emissions From Baltimore City, Maryland', ylab='Emissions of PM2.5 (Tons)', xlab='Year')
fit <- lm(sums ~ years)
abline(fit, lwd=1, col='blue')
dev.off()

#Alternatively
#Barplot
#state <- subset(NEI, fips=='24510') #subset dataset for Baltimore
#sums <- tapply(state$Emissions, state$year, sum) #Calculate sum of each year

# dev.copy(png, file='plot2.png', width=480, height=480)
# barplot(sums, main='Total PM2.5 Emissions From Baltimore City, Maryland', ylab='Emissions of PM2.5 (Tons)', xlab='Year')
# dev.off()
