library(utils)
library(plyr)
library(ggplot2)
if(!file.exists("./Class_4.3")) {
        dir.create("./Class_4.3")
}
if(!file.exists("./Class_4.3/exdata-data-NEI_data.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "./Class_4.3/exdata-data-NEI_data.zip")
}
if(!(file.exists("summarySCC_PM25.rds") && 
     file.exists("Source_Classification_Code.rds"))){
        unzip("./Class_4.3/exdata-data-NEI_data.zip", list = FALSE, overwrite = TRUE, exdir = "./Class_4.3")
}
if(!exists("NEI")){
        NEI <- readRDS("./Class_4.3/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./Class_4.3/Source_Classification_Code.rds")
}
SubsetNEI  <- NEI[NEI$fips == "24510", ]
png(filename = "./Class_4.3/plot2.png", width = 480, height = 480, bg = "transparent", units = 'px')
AggregatedTotalByYear <- aggregate(Emissions ~ year, SubsetNEI, sum)


barplot(
        height = AggregatedTotalByYear$Emissions,
        names.arg = AggregatedTotalByYear$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions (Tons)",
        main = "Total PM2.5 Emissions In Baltimore City"
        )
dev.off()