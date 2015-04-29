ds <- read.csv("Data/PCMCitesThruTime.csv", )

png("Manuscript/Figures/PCMCitations.png", height = 1200, width = 1200, res = 300)

# Plot citations
par(bty = "l")
par(mar = c(4, 4, 2, 2))
plot(Citations ~ Year, data = ds, type = "l", ylim = c(0, 800), 
	 las = 1, lwd = 2, ylab = "Number of papers", xlab = "Year")

dev.off()