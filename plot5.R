if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile='./data/DatasetFNEI.zip')  # Create zip file and download dataset
unzip(zipfile ='./data/DatasetFNEI.zip', exdir='./data')    # unzip file

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Plot 5
#Emissions from motor vehicle sources from 1999-2008 in Baltimore City

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

NEIbalt <- subset(NEI, fips=='24510')
vehicles <- SCC[grep('Vehicle', SCC$SCC.Level.Two),]
vehiclesBalt <- merge(NEIbalt, vehicles, by.x='SCC', by.y='SCC')
groupby <- group_by(vehiclesBalt, year)
sumVehicle <- summarise(groupby, Emissions=sum(Emissions))

dev.copy(png, file='plot5.png', width=480, height=480)
with(sumVehicle, plot(year, Emissions, pch=20, cex=2, cex.main=1, main='Total PM2.5 Emissions from Vehicles, Baltimore City', ylab='Emissions of PM2.5 (Tons)', xlab='Year'))
fit <- lm(Emissions ~ year, sumVehicle)
abline(fit, lwd=1, col='blue')
dev.off() 
