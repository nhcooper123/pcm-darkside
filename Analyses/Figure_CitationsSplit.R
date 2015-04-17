library(ggplot2)
library(reshape)

ds <- read.csv("Data/CitesThruTime.csv")
type <- read.csv("Data/PaperContents.csv")

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

dsTree <- with(ds.all[which(ds.all$Tree == "Yes"), ], 
	               aggregate(value, by = list(Year), 
	               	         FUN = sum, na.rm = TRUE))

dsTreeTest <- with(ds.all[which(ds.all$TreeTest == "Yes"), ], 
	               aggregate(value, by = list(Year), 
	               	         FUN = sum, na.rm = TRUE))

# Simple plot

# Plot Felsenstein1985 citations
plot(value[variable == "Felsenstein1985"] ~ 
     Year[variable == "Felsenstein1985"], 
     data = data_long, type = "l", ylim = c(0,530))

# Add lines for papers mentioning various assumptions
points(x ~ Group.1, data = dsBrownian, col = "red", type = "l")
points(x ~ Group.1, data = dsBrownianTest, col = "green", type = "l")
points(x ~ Group.1, data = dsTree, col = "blue", type = "l")
points(x ~ Group.1, data = dsTreeTest, col = "orange", type = "l")