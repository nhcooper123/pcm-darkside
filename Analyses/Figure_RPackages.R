library(reshape)

ds <- read.csv("Data/PackagesThruTime.csv")

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

png("Manuscript/Figures/PackagesThruTime.png")

par(bty = "l")
plot(TotalPkg[R == "R"] ~ YearReleased[R == "R"], 
	 data = dsYear, type = "l", ylim = c(0, 80), 
	 las = 1, lwd = 2, cex.lab = 1.2, cex.axis = 1.2,
	 ylab = "Total R packages", xlab = "Year Released", xlim = c(2000,2014))

dev.off()
