## GOAL:: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

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

# Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

# ggplot2 plot
dev.cur()
png("Plot4.png", width = 750, height = 500, units = "px")

if(!require(ggplot2)){
      install.packages("ggplot2");
      require(ggplot2)
}
library(ggplot2)

ggplot(combustionNEI,aes(x = factor(year),y = Emissions/1000)) +
      geom_bar(stat="identity", fill = combustionNEI$year, width=0.25) +
      labs(x="year", y=expression("total PM"[2.5]*" emissions in kilotons")) + 
      labs(title=expression("PM"[2.5]*" US CoalCombustionSource Emissions (1999-2008)"))

dev.off()
