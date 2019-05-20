# GOAL:: Comparision of emissions from motor vehicle sources in Baltimore City against LA County, california.
# GOAL:: Showing which city has greater changes over time

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
# 06037 corresponds to LA, California in flips column
# motor-vehical corresponds to ON-ROAD in type column

Baltimore_LA <- fullData[(fullData$fips == "24510" | fullData$fips == "06037") & fullData$type == "ON-ROAD", ]
dim(Baltimore_LA)
unique(Baltimore_LA$fips)

# creating a contigency table for summing up emissions by years and US County
CountyEmissionByYear  <- aggregate(Emissions ~ year + fips, Baltimore_LA, sum)
CountyEmissionByYear

# let's renmae respectve County zones for better understanding
CountyEmissionByYear$fips[CountyEmissionByYear$fips == "24510"] <- "Baltimore, MD"
CountyEmissionByYear$fips[CountyEmissionByYear$fips == "06037"] <- "Los Angeles, LA"
print(CountyEmissionByYear)

# ggplot2 plotting

dev.cur()
png("plot6.png", width = 750, height = 500, units = "px")

ggplot(CountyEmissionByYear, aes(x=factor(year), y=Emissions, fill=city)) +
      geom_bar(aes(fill=year),stat="identity") +
      facet_grid(.~fips, scales="free", space="free") +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
      labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
