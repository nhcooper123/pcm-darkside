# For talk

ds <- read.csv("Data/PCMCitesThruTime.csv", )

newred <- rgb(red = 235, green = 81, blue = 83, maxColorValue = 255)

png("Figures/PCMCitationsTalk.png", bg = "transparent")

# Plot citations
par(bty = "l")
plot(Citations ~ Year, data = ds, type = "l", ylim = c(0, 800), 
	 las = 1, lwd = 2, cex.lab = 1.2, cex.axis = 1.2, col = newred,
	 ylab = "Papers", xlab = "Year")

dev.off()