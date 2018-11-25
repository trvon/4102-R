# This file is for Data Sanitization and Data aggregation

# Checking if packages are already installed
packages <- c("DMwR", "shiny") # Add Packages here
# Passing arguments to script

# Installin Packages
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) {
	install.packages(new.packages, repos="http://cran.rstudio.com/")
}
# Loads libraries
lapply(packages, require, character.only = TRUE)

# fileEncoding = "UTF-8-BOM"
# Loading Video Data
VGdata <- read.csv("DATA/VideoGamesSales.csv", header=TRUE)

# Summarize Black Friday data
# summary[VGdata]
names(VGdata)

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
CMdata <- VGdata["Name"]
CMdata["Rating"] <- VGdata["Rating"]
CMdata["Combined_Rating"] <- VGdata['Critic_Score'] + VGdata['User_Score']
# Sorting data
CMdata <- CMdata[order(CMdata$Combined_Rating, decreasing=TRUE), ]
