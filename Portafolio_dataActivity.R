install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("tidyr")
library(tidyverse)
library(lubridate)
library(dplyr)
library(ggplot2)
library(tidyr)
head(dailyActivity_merged)
colnames(dailyActivity_merged)
colnames(dailyActivity_merged2)


nrow(dailyActivity_merged)
nrow(dailyActivity_merged2)
summary(dailyActivity_merged)
summary(dailyActivity_merged2)

n_distinct(dailyActivity_merged)
n_distinct(dailyActivity_merged2)
## Summary 
summary(dailyActivity_merged %>%
          select(TotalSteps, TotalDistance, TrackerDistance,
                 LoggedActivitiesDistance, VeryActiveDistance,
                 ModeratelyActiveDistance, LightActiveDistance,
                 SedentaryActiveDistance, VeryActiveMinutes, FairlyActiveMinutes,
                 LightlyActiveMinutes, SedentaryMinutes, Calories))
summary(dailyActivity_merged %>%
          select(-Id, -ActivityDate))
summary(dailyActivity_merged2 %>%
          select(-Id, -ActivityDate))
ggplot(data = dailyActivity_merged, aes(x= 'TotalSteps', y= 'Id')) + geom_point()

## contar 0s##

sum(dailyActivity_merged$TotalSteps==0)
## creando dataset sin filas con 0 en totalsteps##

dataActivity_merged_no0 <- subset(dailyActivity_merged, TotalSteps !=0)
## Check##

sum(dataActivity_merged_no0$TotalSteps==0)

write_csv(dataActivity_merged_no0, file = "dataActivity_merged_no0.csv")

 ## HACER DAILY BIG 1 Y 2 , LIMPIAR Y LUEGO SACAR 0##
##check nulls##
sum(is.na(dailyActivity_merged))
sum(is.na(dailyActivity_merged2))
##sacar columnas innecesarias##
dataActivity_clean <- select(dailyActivity_merged, -LoggedActivitiesDistance, -VeryActiveDistance, -ModeratelyActiveDistance, -LightActiveDistance, -SedentaryActiveDistance)
dataActivity_clean2 <- select(dailyActivity_merged2, -LoggedActivitiesDistance, -VeryActiveDistance, -ModeratelyActiveDistance, -LightActiveDistance, -SedentaryActiveDistance)
## CEROS ##
sum(dataActivity_clean$TotalSteps==0)
sum(dataActivity_clean2$TotalSteps==0)

dataActivity_1 <- subset(dataActivity_clean, TotalSteps !=0)
dataActivity_2 <- subset(dataActivity_clean2, TotalSteps !=0)

## RESPALDO ##
write_csv(dataActivity_1, file = "dataActivity_1.csv")
write_csv(dataActivity_2, file = "dataActivity_2.csv")

## MERGE ##
rm(dataActivity_big2)
rm(dataActivity_big)

dataActivity_big <- merge(dataActivity_1, dataActivity_2, all = TRUE)

write_csv(dataActivity_big, file = "dataActivity_big.csv")
 ## numeros Id por mes ##
n_distinct(dataActivity_1$Id)
n_distinct(dataActivity_2$Id)
n_distinct(dataActivity_big$Id)

## graficar en R o en tableau con highlights. NO##

getwd()
