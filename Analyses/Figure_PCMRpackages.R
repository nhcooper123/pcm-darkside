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

png("Manuscript/Figures/PCMRpackages.png", height = 1200, width = 1200, res = 300)

par(bty = "l")
par(mar = c(4, 4, 2, 2))

plot(TotalPkg[R == "R"] ~ YearReleased[R == "R"], data = dsYear, 
     type = "l" , las = 1, lwd = 2, 
	 xlim = c(2000, 2015), ylim = c(0, 80), 
	 xlab = "Year released", ylab = "Total number of R packages")

dev.off()
