library(tidyverse)
library(sf)

# load the data
ridership<- read.csv("data/Bus_Ridership_by_Census_Tract.csv")

ridership_chester<-ridership %>%
  filter(County_Name == "Delaware County")

ridership_chester_weekday<-ridership_chester %>%
  filter(Day_of_Week=="Weekday")

ridership_chester_Saturday<-ridership_chester %>%
  filter(Day_of_Week=="Saturday")

ridership_chester_Sunday<-ridership_chester %>%
  filter(Day_of_Week=="Sunday")


census_tract<-c("42045410700", "42045404400","42045404500", "42045404600",
                "42045404700", "42045404800", "42045404900", "42045405000",
                "42045405100", "42045405200", "42045405300", "42045405400")

ridership_chester_weekday<-ridership_chester_weekday %>%
  filter(Census_Tract_ID %in% census_tract)%>%
  filter(Season=="Fall 2023")

ridership_chester_Saturday<-ridership_chester_Saturday %>%
  filter(Census_Tract_ID %in% census_tract)%>%
  filter(Season=="Fall 2023")

ridership_chester_Sunday<-ridership_chester_Sunday %>%
  filter(Census_Tract_ID %in% census_tract)%>%
  filter(Season=="Fall 2023")

write.csv(ridership_chester_weekday, "export/ridership_chester_weekday.csv")
write.csv(ridership_chester_Saturday, "export/ridership_chester_Saturday.csv")
write.csv(ridership_chester_Sunday, "export/ridership_chester_Sunday.csv")

ggplot(ridership_chester_weekday, aes(x=Census_Tract_Name, y= On_))+
  geom_bar(stat="identity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ridershipe_chester_weekend<-rbind(ridership_chester_Saturday, ridership_chester_Sunday)

ridershipe_chester_weekend<-ridershipe_chester_weekend %>%
  group_by(Census_Tract_ID)%>%
  summarise(On_=mean(On_), Off_=mean(Off_))

write.csv(ridershipe_chester_weekend, "export/ridershipe_chester_weekend.csv")
