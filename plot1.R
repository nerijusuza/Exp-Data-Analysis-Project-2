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

AggTotal <- aggregate(Emissions ~ year, NEI, sum)
png(filename = "./Class_4.3/plot1.png", width = 480, height = 480, bg = "transparent", units = 'px')
barplot(
        (AggTotal$Emissions)/10^6,
        names.arg = AggTotal$year,
        xlab = "Year",
        ylab = "PM2.5 Emissions (10^6 Tons)",
        main = "Total PM2.5 Emissions From All US Sources"
)

dev.off()