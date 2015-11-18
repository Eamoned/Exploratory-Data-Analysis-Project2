if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile='./data/DatasetFNEI.zip')  # Create zip file and download dataset
unzip(zipfile ='./data/DatasetFNEI.zip', exdir='./data')    # unzip file

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Plot 6
#Compare Emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Extracting & merging Baltimore and Vehicle emissions data
vehicles <- SCC[grep('Vehicle', SCC$SCC.Level.Two),] # Pull out vehicle data from SCC dataset
NEIbalt <- subset(NEI, fips=='24510') # Pul out Baltimore data from NEI dataset
vehiclesBalt <- merge(NEIbalt, vehicles, by.x='SCC', by.y='SCC') # merge data sets

# Extracting & merging LA and vehicle emissions data
NEILA <- subset(NEI, fips=='06037')
vehiclesLA <- merge(NEILA, vehicles, by.x='SCC', by.y='SCC')

# Combine LA and Baltimore subsets
vehBaltLA <- rbind(vehiclesBalt, vehiclesLA)

#Calculare sum of Emissions for vehicles for Baltimore & LA 
groupby <- group_by(vehBaltLA, year, fips)
sumBaltLA <- summarise(groupby, Emissions=sum(Emissions))

 dev.copy(png, file='plot6.png', width=480, height=480)
 g <- ggplot(sumBaltLA, aes(year, Emissions))
 g + geom_point()
 g + geom_point() + geom_smooth(se=FALSE)
 g + geom_point() + facet_grid(.~fips) + geom_smooth(method='lm',se=FALSE) + 
       geom_point() + labs(title = 'Emissions for Vehicles in Baltimore & LA (1999-2008)') + 
       labs(x = expression('Year'), y= 'Emissions PM2.5')
 dev.off()
