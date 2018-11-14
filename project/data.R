# This file is for Data Sanitization and Data aggregation

# Checking if packages are already installed
packages <- c("DMwR", "RPostgreSQL") # Add Packages here
# Passing arguments to script

# Installin Packages
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) {
	install.packages(new.packages, repos="http://cran.rstudio.com/")
}
# Loads libraries
lapply(packages, require, character.only = TRUE)

# fileEncoding = "UTF-8-BOM"
# Loading Static Data
BFdata <- read.csv("DATA/BlackFriday.csv", header=FALSE)
Rdata <- read.csv("DATA/RetailData.csv", header=FALSE)

# Connecting to Database to load Live Data
pass <- { "r_password" }

# Loads PostgreSQL drive
drv <- dbDriver("PostgreSQL")

# Creates connection to database
con <- dbConnect(drv, dbname="postgres", 
				 host="0.0.0.0", port="5432",
				 user="postgres", password=pass)

# Removes the password variable
rm(pass)

# Check for scraped data
dbExistsTable(con, "items")

# Database data
Idata <- dbGetQuery(con, "select * from items")

# Writes static data

# Close connection 
dbDisconnect(con)
# Unloads Driver
dbUnloadDriver(drv)
