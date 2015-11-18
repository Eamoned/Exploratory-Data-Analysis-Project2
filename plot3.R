if(!file.exists('./data')) {dir.create('./data')} #create a data dir if it doesn't exist
fileUrl <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
download.file(fileUrl, destfile='./data/DatasetFNEI.zip')  # Create zip file and download dataset
unzip(zipfile ='./data/DatasetFNEI.zip', exdir='./data')    # unzip file

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

#Plot3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from from 1999 to 2008 for Baltimore city

library(ggplot2)
library(dplyr)
NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

state <- subset(NEI, fips=='24510') #subset dataset for Baltimore
sumTotal <- group_by(state, year, type) 
sumTotal <- summarise(sumTotal, Emissions=sum(Emissions))

#ggplot2 plotting system

 dev.copy(png, file='plot3.png', width=480, height=480)
 g <- ggplot(sumTotal, aes(year, Emissions))
 g + geom_point()
 g + geom_point() + geom_smooth(se=FALSE)
 g + geom_point() + facet_grid(.~type) + geom_smooth(method='lm',se=FALSE) + 
      geom_point() + labs(title = 'Baltimore Emissions From 1999 - 2008 by Source Type') + 
      labs(x = expression('Year'), y= 'Emissions PM2.5')
 dev.off()
