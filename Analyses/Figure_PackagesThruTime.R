library(ggplot2)
library(reshape)

ds <- read.csv("PackagesThruTime.csv")

# Group packages by year using aggregate then fix names
dsYear <- with(ds, aggregate(Program, by = list(YearReleased, RPackage), 
	                          FUN = length))

names(dsYear) <- c("YearReleased", "R", "NPackages")

# Order the data by year so cumulative number of packages
# per year can be calculated
dsYear <- dsYear[order(dsYear$YearReleased), ]

# Calculate cumulative number of packages per year
# separately for non R and R packages
dsYear$TotalPkg[dsYear$R == "other"] <- cumsum(dsYear$NPackages[dsYear$R == "other"])
dsYear$TotalPkg[dsYear$R == "R"] <- cumsum(dsYear$NPackages[dsYear$R == "R"])

# pdf("PackagesPerYear.pdf")

# Plot cumulative number of packages through time
myplot <- ggplot(data = dsYear,
                 aes(x = YearReleased, y = TotalPkg, color = R))
    
# Modifications to graph including legend, y-axis label etc.
myplot + 
geom_smooth(method = "loess", se = FALSE) + 
ylab("Cumulative number of packages") +
xlab("Year released")

# dev.off()