# This file is for Data Sanitization and Data aggregation

# Checking if packages are already installed
packages <- c("plyr", "shiny") # Add Packages here
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
# Combined Scores table
CMdata <- VGdata["Name"]
CMdata["Rating"] <- VGdata["Rating"]
CMdata["Global_Sales"] <- VGdata["Global_Sales"]
# Summing the average of the Critic and Users scores
CMdata["Combined_Rating"] <- VGdata['Critic_Score'] + VGdata['User_Score']
# Sorting data
CMdata <- CMdata[order(CMdata$Combined_Rating, decreasing=TRUE), ]

# Scores table
Sdata <- VGdata["Name"]
Sdata["Rating"] <- VGdata["Rating"]
Sdata["Global_Sales"] <- VGdata["Global_Sales"]

# Region Specific
# Changes year to numeric value
VGdata$Year_of_Release <- as.integer(VGdata$Year_of_Release)
# Sorts table by year
YVGdata <- VGdata[order(VGdata$Year_of_Release),]

#################
# 	Functions 	#
#################

# Function that returns a table based on the rating
ratingType <- function(rating) {
	# Return table with Critic ratings
	if(rating == "Critic") {
		Sdata["Critic_Score"] <- VGdata["Critic_Score"]
		# Returns table ordered by score
		return(Sdata[order(Sdata$Critic_Score, decreasing=TRUE), ])
	}
	# Return table with User ratings	
	else if (rating == "User") {
		Sdata["User_Score"] <- VGdata["User_Score"]
		# Returns table ordered by score
		return(Sdata[order(Sdata$User_Score, decreasing=TRUE), ])
	}
	# Return the combined scores
	else {
		return(CMdata)
	}
}

# Function returns table based on year selection
yearRange <- function(year, range) {
	# Creating a table with the year range passed
	max <- year + range
	# Getting year subset in range selected
	Ydata <- YVGdata[YVGdata$Year_of_Release >= year & YVGdata$Year_of_Release <= max,]
	# initializing table
	# Ydata <- null
	# Ydata <- count(tempTable, Year_of_Release, Genre)
	return(Ydata)
}
