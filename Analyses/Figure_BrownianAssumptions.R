library(reshape)

ds <- read.csv("CitesThruTime.csv")
type <- read.csv("PaperContents.csv")

# Reshape the data so it's in long format
data_long <- melt(ds, id = "Year")

# Merge in data explaining what each paper contains
ds.all <- merge(data_long, type, by.x = "variable", by.y = "Paper")

# Remove Felsenstein 1985 & Harvey&Pagel 1991
ds.all <- subset(ds.all, variable != "Felsenstein1985"
	& variable != "HarveyPagel1991")

# Summarise citations for each type of assumption
dsBrownian <- with(ds.all[which(ds.all$Brownian == "Yes"), ], 
	               aggregate(value, by = list(Year), 
	               	         FUN = sum, na.rm = TRUE))

dsBrownianTest <- with(ds.all[which(ds.all$BrownianTest == "Yes"), ], 
	               aggregate(value, by = list(Year), 
	               	         FUN = sum, na.rm = TRUE))

# Plot for talk slides

newred <- rgb(red = 235, green = 81, blue = 83, maxColorValue = 255)
newblue <- rgb(red = 75, green = 213, blue = 238, maxColorValue = 255)
newyellow <- rgb(red = 229, green = 177, blue = 58, maxColorValue = 255)

png("BrownianAssumptionCitations.png")

par(bg = "black")

# Plot Felsenstein1985 citations
plot(value[variable == "Felsenstein1985"] ~ 
     Year[variable == "Felsenstein1985"], 
     data = data_long, type = "l", ylim = c(0,530), 
     col = newred, lwd = 5)

# Add lines for papers mentioning various assumptions
points(x ~ Group.1, data = dsBrownian, col = newblue, type = "l" , lwd = 5)
points(x ~ Group.1, data = dsBrownianTest, col = newyellow, type = "l" , lwd = 5)

dev.off()