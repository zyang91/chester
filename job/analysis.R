library(readxl)
library(tidyverse)
library(sf)


# Read in the data
place <- read.csv("data/place.csv")

chester_employment<-read_excel("data/job.xlsx")

# Join the data
employment <- left_join(place, chester_employment_PA, by = c("PLACENAME"= "place"))

employment<- employment%>%
  filter(!is.na(Count))

employment<- employment%>%
  group_by(COUNTYNAME)%>%
  summarise(employment=sum(Count))

employemnt<- employment%>%
  mutate(percentage=employment/sum(employment)*100)

write.csv(employment, "data/employment_county.csv")

chester_employment_state<-chester_employment%>%
  group_by(state)%>%
  summarise(employment=sum(Count))%>%
  filter(!is.na(state))%>%
  mutate(percentage=employment/sum(employment)*100)

write.csv(chester_employment_state, "data/employment_state.csv")
