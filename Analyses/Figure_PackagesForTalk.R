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

# Plot for talk slides

newred <- rgb(red = 235, green = 81, blue = 83, maxColorValue = 255)
newblue <- rgb(red = 75, green = 213, blue = 238, maxColorValue = 255)
newyellow <- rgb(red = 229, green = 177, blue = 58, maxColorValue = 255)

png("Figures/PackagesThruTime_Talk.png", bg = "transparent")

# Plot cumulative number of non-R packages through time
# plot(TotalPkg[R == "other"] ~ YearReleased[R == "other"], 
#     data = dsYear, type = "l", ylim = c(0,30), xlim = c(1980,2014), 
#     col = newred, lwd = 5)

# Add line for R packages
plot(TotalPkg[R == "R"] ~ YearReleased[R == "R"], 
	   data = dsYear, col = newred, type = "l" , lwd = 5, 
	   xlim = c(2000,2014))

dev.off()
