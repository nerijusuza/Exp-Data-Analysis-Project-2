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

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

png(filename = "./Class_4.3/plot5.png", width = 480, height = 480, bg = "transparent", units = 'px')

baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == 24510, ]

gplot <- ggplot(baltimoreVehiclesNEI, aes(factor(year), Emissions)) +
        geom_bar(stat = "identity", fill = "grey", width=0.75) +
        theme_bw() + guides(fill = FALSE) +
        labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title = expression("PM"[2.5]*"Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(gplot)
dev.off()