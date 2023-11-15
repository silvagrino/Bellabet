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
drop(dailyActivity_merged_3_12_16_4_11_16)
ls()
rm(dailyActivity_merged_3_12_16_4_11_16)
## Merge Dailycalories y DailySteps
dailyActivity2 <- merge(dailyCalories_merged_4_12_16_5_12_16, dailySteps_merged_4_12_16_5_12_16, by = c("Id", "ActivityDay"))
## Renombrar
dailyActivity3 <- dailyActivity2%>% rename(TotalSteps=StepTotal)
dailyActivity5 <- dailyActivity3%>% rename(ActivityDate=ActivityDay)
## Merge Dailyactivity 2 a original
dailyActivityBig <- merge(dailyActivity5, dailyActivity_merged_4_12_16_5_12_16, by = c("Id", "ActivityDate", "TotalSteps", "Calories")) 

## me falta comprobar que ayan servido el hacer merge de Steps y de calories en el DAILY. NO SIRVIO
## comprobar nulls. Sacar columnas que no me sirvan. CHECK

sum(is.na(dailySteps_merged_4_12_16_5_12_16))
is.na(dailySteps_merged_4_12_16_5_12_16)
sum(is.na(dailyCalories_merged_4_12_16_5_12_16))
sum(is.na(dailyActivityBig))
# no sirvio merged

# Estandarizar fechas si es necesario

#Borrar columnas innecesarias
dailyActivityBig <- select(dailyActivityBig, -LoggedActivitiesDistance, -VeryActiveDistance, -ModeratelyActiveDistance, -LightActiveDistance, -SedentaryActiveDistance)
##Daily activity big se ocupara en daily y hourly por los minutos activos

write_csv(dailyActivityBig, "Activity_BIG")
write_csv2(dailyActivityBig, "Activity_BIG2")

getwd()
