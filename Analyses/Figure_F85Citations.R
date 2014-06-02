library(reshape)

ds <- read.csv("CitesThruTime.csv")

# Reshape the data so it's in long format
data_long <- melt(ds, id = "Year")

#Make new colour to match those of presentation

newcol <- rgb(red = 235, green = 81, blue = 83, maxColorValue = 255)

png("Felsenstein85Citations.png")

# Add black background
par(bg = "black")

# Plot Felsenstein1985 citations
plot(value[variable == "Felsenstein1985"] ~ Year[variable == "Felsenstein1985"], 
     data = data_long, type = "l", col = newcol, lwd = 5)

dev.off()

newblue <- rgb(red = 75, green = 213, blue = 238, maxColorValue = 255)

png("HarveyPagel91Citations.png")

# Add black background
par(bg = "black")

# Plot Harvey&Pagel 1991 citations
plot(value[variable == "HarveyPagel1991"] ~ Year[variable == "HarveyPagel1991"], 
     data = data_long, type = "l", col = newblue, lwd = 5)

dev.off()