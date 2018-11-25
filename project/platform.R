install("readr")
library(readr)
library(dplyr)
library("ggplot2")
library(doBy)
VGD <- read.csv("DATA/VideoGamesSales.csv",header = TRUE)

str(VideoGamesData)
View(VideoGamesData)

VGDbyDate <- VGD[order(VGD$Year_of_Release),]

genreDifference <- function()
{
setOne <- subset(VGDbyDate, Year_of_Release == "1980"|Year_of_Release == "1981"|Year_of_Release == "1982"
                 |Year_of_Release == "1983"|Year_of_Release == "1984"|Year_of_Release == "1985"|Year_of_Release == "1986"
                 |Year_of_Release == "1987"|Year_of_Release == "1988"|Year_of_Release == "1989"|Year_of_Release == "1990")
setTwo <- subset(VGDbyDate, Year_of_Release == "2017"|Year_of_Release == "2016"|Year_of_Release == "2015"
                 |Year_of_Release == "2014"|Year_of_Release == "2013"|Year_of_Release == "2012"|Year_of_Release == "2011"
                 |Year_of_Release == "2010"|Year_of_Release == "2009"|Year_of_Release == "2008"|Year_of_Release == "2007")


     

yVSgONE <- count (setOne,Year_of_Release , Genre)
yVSgONE 

ggplot(yVSgONE, aes(x =factor(Year_of_Release), y = n, colour=Genre, group=Genre)) + geom_line()+ggtitle("Genre by Year ")+theme(axis.text.x = element_text(angle = 90,hjust = 1))

yVSgTWO <- count(setTwo, Year_of_Release, Genre)
yVSgTWO

ggplot(yVSgTWO, aes(x =factor(Year_of_Release), y = n, colour=Genre, group=Genre)) + geom_line()+ggtitle("Genre by Year")+theme(axis.text.x = element_text(angle = 90,hjust = 1))

}

library(doBy)
attach(VGD)


platformVSRegion <- function (){
platformSum<-summaryBy(NA_Sales+EU_Sales+JP_Sales~Platform,data=VGD,FUN=sum)
platformSum

northAmerica<-paste('(', round(platformSum$NA_Sales.sum/sum(sum_sale$NA_Sales.sum) * 100, 1), '%)', sep = '')
northAmerica

japanSales<-paste('(', round(platformSum$JP_Sales.sum/sum(sum_sale$JP_Sales.sum) * 100, 1), '%)', sep = '')
japanSales

europe <-paste('(', round(platformSum$EU_Sales.sum/sum(sum_sale$EU_Sales.sum) * 100, 1), '%)', sep = '')
europe



labels <- paste(platformSum$Platform, northAmerica, sep = '')
labels

jpLabels <-paste(platformSum$Platform, japanSales, sep = '')
jpLabels

euLabels<-paste(platformSum$Platform, europe, sep = '')
euLabels

#NA
ggplot(data = platformSum, mapping = aes(x = 'Content', y = NA_Sales.sum, fill = Platform )) + geom_bar(stat = 'identity', position = 'stack', width = 1)+ coord_polar(theta ="y") + ggtitle(" NA_Sales by Platform")+ theme(axis.text = element_blank())+ scale_fill_discrete(labels =labels)
#Japan
ggplot(data = platformSum, mapping = aes(x = 'Content', y = JP_Sales.sum, fill = Platform )) + geom_bar(stat = 'identity', position = 'stack', width = 1)+ coord_polar(theta ="y") + ggtitle(" JP_Sales by Platform")+ theme(axis.text = element_blank())+ scale_fill_discrete(labels =jpLabels)

#europe

ggplot(data = platformSum, mapping = aes(x = 'Content', y = EU_Sales.sum, fill = Platform )) + geom_bar(stat = 'identity', position = 'stack', width = 1)+ coord_polar(theta ="y") + ggtitle(" EU_Sales by Platform")+ theme(axis.text = element_blank())+ scale_fill_discrete(labels =euLabels)

}
  
