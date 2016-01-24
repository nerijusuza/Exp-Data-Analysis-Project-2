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

BaltimoreNEI <- NEI[NEI$fips == "24510", ]
aggTotalsBaltimore <- aggregate(Emissions ~ year, BaltimoreNEI, sum)
png(filename = "./Class_4.3/plot33.png", width = 640, height = 480, bg = "transparent", units = 'px')
gplot <- ggplot(BaltimoreNEI, aes(factor(year), Emissions, fill = type)) +
        geom_bar(stat = "identity", fill = "grey") +
        theme_bw() + guides(fill = FALSE) +
        facet_grid(. ~ type, scales = "free", space = "free") + 
        labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title = expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(gplot)
dev.off()
