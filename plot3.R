if (!exists('NEI')) {
  NEI <- readRDS('data/summarySCC_PM25.rds')
}

if (!exists('SCC')) {
  SCC <- readRDS('data/Source_Classification_Code.rds')
}

# Of the four types of sources indicated by the
# type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

# Subset NEI for Baltimore only
baltimoreNEI <- NEI[NEI$fips=='24510', ]

# Aggregate emissions by year
aggregatedTotalByYearAndType <-
  aggregate(Emissions ~ year + type, baltimoreNEI, sum)

png('plot3.png', width=480, height=480)

g <- ggplot(
  aggregatedTotalByYearAndType,
  aes(year, Emissions, color = type))

# Plot g with a line for each type and year
g <-
  g + geom_line() +
  xlab('Year') +
  ylab('Total PM2.5 Emissions') +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')

print(g)

dev.off()
