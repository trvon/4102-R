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
# Scores table
Sdata <- VGdata["Name"]
Sdata["Rating"] <- VGdata["Rating"]
Sdata["Global_Sales"] <- as.numeric(as.character(VGdata["Global_Sales"]))
# Combined Scores table

## Region Specific
# Changes year to numeric value
VGdata$Year_of_Release <- as.numeric(as.character(VGdata$Year_of_Release))
YVGdata <- VGdata[order(VGdata$Year_of_Release),]

## Publisher Specific
# Creating table for publisher
Pdata <- VGdata["Publisher"]
Pdata["Developer"] <- VGdata["Developer"]
Pdata["Year_of_Release"] <- as.numeric(as.character(VGdata["Year_of_Release"]))
Pdata["Critic_Score"] <- VGdata["Critic_Score"]
Pdata["User_Score"] <- VGdata["User_Score"]
Pdata["Global_Sales"] <- VGdata["Global_Sales"]
Pdata["Genre"] <- VGdata["Genre"]
# Remove Columns with NAN's
# Pdata <- Pdata[colSums(!is.na(Pdata))  ]

#################
# 	Functions 	#
#################
# Function that returns a table based on the rating
ratingType <- function(rating, region) {
	# Adds the Region sales to the table
	switch(region,
		"NA" = { Sdata['Sales'] <- VGdata['NA_Sales'] },
		"EU" = { Sdata['Sales'] <- VGdata['EU_Sales'] },
		"JP" = { Sdata['Sales'] <- VGdata['JP_Sales'] },
		"Other" = {	Sdata['Sales'] <- VGdata['Other_Sales'] }
	)

	Sdata['Sales'] <- as.numeric(as.character(Sdata$Sales))
	# Return table with Critic ratings
	if(rating == "Critic") {
		Sdata["Score"] <- VGdata["Critic_Score"]
		Sdata["Combined_Rating"] <- VGdata['Critic_Score'] + VGdata['User_Score']
		# Returns table ordered by score
		return(Sdata[order(Sdata$Score, decreasing=TRUE), ])
	}
	# Return table with User ratings	
	else if (rating == "User") {
		Sdata["Score"] <- VGdata["User_Score"]
		Sdata["Combined_Rating"] <- VGdata['Critic_Score'] + VGdata['User_Score']
		# Returns table ordered by score
		return(Sdata[order(Sdata$Score, decreasing=TRUE), ])
	}
}

# Function that returns table based on year selection
yearRange <- function(year, range, region) {
	# Creating a table with the year range passed
	switch(region,
		"NA" = { region <- "NA_Sales" },
		"EU" = { region <- "EU_Sales" },
		"JP" = { region <- "JP_Sales" },
		"Other" = {	region <- "Other_Sales" }
	)
	max <- year + range
	# Getting year subset in range selected
	tempTable <- YVGdata[YVGdata$Year_of_Release >= year & YVGdata$Year_of_Release <= max,]
	# Creating a table with the frequency of games and genre's
	Ydata <- count(tempTable, c('Year_of_Release', 'Genre','Global_Sales', region))
	# Aggregates the data based on similar year and Genre while summing other columns :D
	Ydata <- aggregate(. ~ Year_of_Release + Genre + freq, Ydata, sum)
	return(Ydata)
}

# Function that returns table based on publisher settings
publisherData <- function(genre) {
	Pdata <- Pdata[order(Pdata$Year_of_Release),]
	Pdata <- Pdata[Pdata$Genre == genre,]
	# Pdata <- count(Pdata, c('Publisher', 'Genre', 'Year_of_Release', 'Global_Sales'))	
	# Pdata <- aggregate(. ~ Publisher +  Genre + Year_of_Release, Pdata, sum)
	return(Pdata)
}
