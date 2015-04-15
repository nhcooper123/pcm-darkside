library(ggplot2)
library(reshape)

ds <- read.csv("Data/CitesThruTime.csv")

# Reshape the data so it's in long format
data_long <- melt(ds, id = "Year")

pdf("Manuscript/Figures/CitationsPerYear_AllPapers")

# Graph showing how citations change through time
# for key PCM papers
myplot <- ggplot(data = data_long,
                 aes(x = Year, y = value, colour = variable))
    
# Modifications to graph including legend, y-axis label etc.
myplot + 
geom_line() + 
guides(col = guide_legend(nrow = 14, title = "Paper"), size = 0.5) +
ylab("Citations")

dev.off()

# Need to limit to fewer papers to get a clearer graph