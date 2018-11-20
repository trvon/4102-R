# The main execution of the program

# Getting the Objects from the data.R file
source("data.R")

# Summarize Black Friday data
# summary[VGdata]
names(VGdata)

# Getting video game names
# VGdata["Name"]

## Score Comparison
# Normalizing Scores
VGdata$Critic_Score <- as.character(VGdata$Critic_Score)
VGdata$User_Score <- as.character(VGdata$User_Score)

# Changing NA values to 0
VGdata[is.na(VGdata)] <- 0
VGdata[is.na(VGdata)] <- 0

# Changing values to numbers
VGdata$Critic_Score <- as.numeric(VGdata$Critic_Score) / 10
VGdata$User_Score <- as.numeric(VGdata$User_Score)

# Summing the average of the Critic and Users scores
VGdata["Combined_Score"] <- VGdata['Critic_Score'] + VGdata['User_Score']
# Order by Combined Score Column
# BestOverall <- VGdata[with(VGdata, order("Combined_Score", "Name"))]
# Top 10 games over
head(VGdata[order(VGdata$Combined_Score, decreasing=TRUE), ], 10)

# VGdata['Critic_Score'] 
# VGdata["User_Score"]

# Sort data
# sort(VGdata)

# Summarize Items data
# summary(Idata)
# Display's data
# Idata

