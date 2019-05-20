# GOAL:: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# GOAL:: Using base-plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Load the data
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

# count the total emissions by year from NEI dataset
Emissions_by_year <- aggregate(Emissions~year, NEI, sum)
str(Emissions_by_year)

# converting Emissions in millions for better plotting results
Emissions_by_year$EmissionsInMillions = Emissions_by_year$Emissions / 1000000
str(Emissions_by_year)

# Plot1 (BASE Plot)
dev.cur()
png("Plot1.png", width = 750, height = 500, units = "px")

# setting the margins
par(mar = c(5, 4, 2, 1), mfrow = c(1,2))

barplot(Emissions_by_year$EmissionsInMillions,
      names.arg = Emissions_by_year$year,
      col = factor(Emissions_by_year$year),
      xlab = 'Years',
      ylab = expression('Emissions PM' [2.5]* 'in millions'),
      main =  expression('PM'[2.5]*'Emissions/year'))

plot( Emissions_by_year$EmissionsInMillions ~ Emissions_by_year$year,
      type = "o",
      main = expression('PM'[2.5]*'Emissions/year'),
      xlab = "Year",
      ylab = expression('Emissions PM' [2.5]* 'in millions'),
      pch = 19,
      col = "darkblue",
      lty = 6)

dev.off()



