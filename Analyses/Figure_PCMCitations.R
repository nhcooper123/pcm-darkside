ds <- read.csv("PCMCitesThruTime.csv")

png("PCMCitations.png")

# Plot citations
par(bty = "l")
plot(Citations ~ Year, data = ds, type = "l", ylim = c(0, 800), 
	 las = 1, lwd = 2, cex.lab = 1.2, cex.axis = 1.2)

dev.off()