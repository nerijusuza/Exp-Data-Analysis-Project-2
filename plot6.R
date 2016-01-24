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
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

png(filename = "./Class_4.3/plot66.png", width = 480, height = 480, bg = "transparent", units = 'px')

vehiclesBaltimoreNEI <- vehiclesNEI[vehiclesNEI$fips == "24510", ]
vehiclesBaltimoreNEI$city <- "Baltimore City"

vehiclesLANEI <- vehiclesNEI[vehiclesNEI$fips == "06037", ]
vehiclesLANEI$city <- "Los Angeles County"

bothNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLANEI)

gplot <- ggplot(bothNEI, aes(x = factor(year), y = Emissions, fill = city)) +
        geom_bar(aes(fill = year), fill = "grey", stat= "identity") +
        facet_grid(scales = "free", space = "free", .~city) +
        guides(fill = FALSE) + theme_bw() +
        labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title = expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(gplot)
dev.off()