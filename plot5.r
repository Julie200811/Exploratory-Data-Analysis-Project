## GOAL:: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


## read in the data
if (!exists("NEI")) {
      NEI <- readRDS("summarySCC_PM25.rds")
}
# dim(NEI)
# str(NEI)
# summary(NEI)

if (!exists("SCC")) {
      SCC <- readRDS("Source_Classification_Code.rds")
}
# dim(SCC)
# str(SCC)
# summary(SCC)

if (!exists("fullData")) {
      fullData <- merge(NEI, SCC, by = "SCC")
}

# 24510 corresponds to Baltimoe City in fips column
# motor-vehical corresponds to ON-ROAD in type column

OnRoadEmissions <-
      fullData[fullData$fips == "24510" & fullData$type == "ON-ROAD",]
# dim(OnRoadEmissions)

# creating a contigency table for summing up emissions by years
OnRoad_byYear <- aggregate(Emissions ~ year , OnRoadEmissions, sum)
OnRoad_byYear


# ggplot2 plot
if (!require(ggplot2)) {
      install.packages("ggplot2")
      
      require(ggplot2)
}
library(ggplot2)


dev.cur()
png("Plot5.png",
    width = 750,
    height = 500,
    units = "px")


ggplot(OnRoad_byYear, aes(x = factor(year), y = Emissions)) +
      geom_bar(stat = "identity", fill = "steelblue3", width = 0.25) +
      xlab("year") + ylab(expression('Total PM'[2.5] * " Emissions")) +
      ggtitle(expression("Baltimore City On-Road Vehical PM"[2.5] * " Emissions from 1999-2008"))

dev.off()
