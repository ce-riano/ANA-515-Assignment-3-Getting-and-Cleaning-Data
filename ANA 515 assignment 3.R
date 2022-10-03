############## ANA 515 Assignment 3 Getting and Cleaning Data ############
########################

# Load necessary packages
library(plyr)
library(ggplot2)  
library(tidyr)
library(dplyr)
library(stringr)

#Readin data
setwd("/Users/cesarriano/Desktop/ANA_515")
#getwd()
# 1 read data set - csv file
Stormdata<-read.csv("StormEvents_details-ftp_v1.0_d1993_c20220425.csv")
names(Stormdata)

# 2 limit data frame
myvars <- c("BEGIN_YEARMONTH", "BEGIN_DATE_TIME", "END_DATE_TIME", "EPISODE_ID", 
            "EVENT_ID", "STATE", "STATE_FIPS", "CZ_NAME", "CZ_TYPE", 
            "CZ_FIPS", "EVENT_TYPE", "SOURCE", "BEGIN_LAT", "BEGIN_LON", "END_LAT", "END_LON")
newdata <- Stormdata[myvars]
head(newdata)
# 3.	Arrange the data by beginning year and month (BEGIN_YEARMONTH) 
arrange(newdata, BEGIN_YEARMONTH)

# 4.	Change state and county names to title case 
str_to_title(newdata$STATE, locale = "en")

# 5.	Limit to the events listed by county FIPS (CZ_TYPE of “C”) and then remove the CZ_TYPE column
limited_data <- filter(newdata, CZ_TYPE == "C")

# 6.	Pad the state and county FIPS with a “0” at the beginning

str_pad(limited_data$STATE_FIPS, width = 3, side = "left", pad = 0)
str_pad(newlimited_datadata$CZ_FIPS, width = 3, side = "left", pad = 0)
unite(newdlimited_dataata, "fips", c("CZ_FIPS", "STATE_FIPS"))

# 7.	Change all the column names to lower case
rename_all(limited_data,tolower)

# 8.	There is data that comes with base R on U.S. states (data("state")). 
# Use that to create a dataframe with these three columns: state name, area, and region (5 points)

data("state")
us_state_info<-data.frame(state=state.name, area=state.area, region=state.region)
us_state_info <-(mutate_all(data, toupper))
head(us_state_info)

#  9.	Create a dataframe with the number of events per state in the year of your birth
table(newdata$STATE)
Newset<- data.frame(table(newdata$STATE))
merged <- merge(x=newdata,y=us_state_info,by.x="STATE", by.y="STATE")
head(merged)

# 10. plot

storm_plot <- ggplot(us_state_info, aes(x = area, y = region)) +
  geom_point(aes(color = region)) +
  labs(x = "Land area (square miles)",
       y = "# of storm events in 1993")
storm_plot




