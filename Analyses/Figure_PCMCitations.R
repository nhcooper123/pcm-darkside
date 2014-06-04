ds <- read.csv("PCMCitesThruTime.csv")

# Plot for talk slides
newred <- rgb(red = 235, green = 81, blue = 83, maxColorValue = 255)

png("PCMCitations.png", bg = "transparent")

# Plot citations
plot(Citations ~ Year, data = ds, type = "l", ylim = c(0, 800), 
     col = newred, lwd = 5)

dev.off()