## Ashish Sahu

## GOAL:: sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
          #which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## GOAL:: Which have seen increases in emissions from 1999-2008? Plot Using ggpplot2.

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


# Subset NEI data by Baltimore
baltimoreNEI <- subset(NEI, NEI$fips == "24510")
str(baltimoreNEI)

# ggplot2 plotting
dev.cur()
png("Plot3.png", width = 750, height = 500, units = "px")

if(!require(ggplot2)){
      install.packages("ggplot2");
      require(ggplot2)
}
library(ggplot2)

ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
      geom_bar(stat="identity") +
      facet_grid(.~type,scales = "free",space="free") + 
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
      labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
