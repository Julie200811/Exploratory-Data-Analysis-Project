# GOAL:: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
# GOAL:: Using the base plotting system to make a plot answering this question.

## Step 1: read in the data
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

## Step 2: obtain the subsets to plot
baltimore <- subset (NEI, fips == "24510")
str(baltimore)

baltimore_Emissions <- aggregate(Emissions~year, baltimore, sum)
str(baltimore_Emissions)

## Step 3: plot prepare to plot to png
dev.cur()
png("Plot2.png", width = 750, height = 500, units = "px")

# setting the plotting parameters
par(mar = c(5,4,2,1), mfrow = c(1,2))

barplot(baltimore_Emissions$Emissions, 
        names = baltimore_Emissions$year,
        col = factor(baltimore_Emissions$year),
        xlab = "Years", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
        main = expression("Baltimore City" ~ PM[2.5] ~ "Emissions/Year"))

plot( baltimore_Emissions,
      names(baltimore_Emissions$year), 
     type = "o", 
     xlab="Years", ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main=expression("Baltimore City" ~ PM[2.5] ~ "Emissions/Year"), 
     col = "blue")

dev.off()











