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

## ocupar las tablas minutes? No
##Aqui tendria mas sentido que en daily. Pero las intensities en que se miden? Insuficiente
## En la tabla daily estaban los minutos gastados dependiendo de la intensidad.
##Pero las tablas hourly ? No se sabe. Asi que solo considerar steps, calories y Daily Activity por minuto

##Estandarizar formato hora

class(hourlyCalories_merged_3_12_16_4_11_16$ActivityHour)

## Diferencias en tablas y ver si hago merge

n_distinct(hourlyCalories_merged_3_12_16_4_11_16$Id)
n_distinct(hourlyCalories_merged_4_12_16_5_12_16$Id)
n_distinct(hourlySteps_merged_3_12_16_4_11_16$Id)
n_distinct(hourlySteps_merged_4_12_16_5_12_16$Id)

summary(hourlyCalories_merged_3_12_16_4_11_16)
summary(hourlyCalories_merged_4_12_16_5_12_16)
summary(hourlySteps_merged_3_12_16_4_11_16)
summary(hourlySteps_merged_4_12_16_5_12_16)

## sumo dataactivity BIG, comparo numeros de id entre datasets##

n_distinct(dataActivity_big$Id)
## en que vi que era ineficiente el 1? Estan los mismos IDs pero faltan dias a cada uno##
n_distinct(dataActivity_big$ActivityDate)
## Necesito saber que dias no estan , hacer un match de dias e ID para ver cuantos hay por ID ocupando n_disticnt##
##no se puede con n_distinct##

class(hourlyCalories_merged_3_12_16_4_11_16$ActivityHour)
class(hourlyCalories_merged_4_12_16_5_12_16$ActivityHour)
class(hourlySteps_merged_3_12_16_4_11_16$ActivityHour)
class(hourlySteps_merged_4_12_16_5_12_16$ActivityHour)

##cleaning##
sum(is.na(hourlyCalories_merged_3_12_16_4_11_16))
sum(is.na(hourlyCalories_merged_4_12_16_5_12_16))
sum(is.na(hourlySteps_merged_3_12_16_4_11_16))
sum(is.na(hourlySteps_merged_4_12_16_5_12_16))
sum(is.na(dataActivity_big))

sum(hourlyCalories_merged_3_12_16_4_11_16$Calories==0)
sum(hourlyCalories_merged_4_12_16_5_12_16$Calories==0)
sum(hourlySteps_merged_3_12_16_4_11_16$StepTotal==0)
sum(hourlySteps_merged_4_12_16_5_12_16$StepTotal==0)
##dataActivity_big##
sum(dataActivity_big$TotalSteps==0)
sum(dataActivity_big$Calories==0)
sum(dataActivity_big$VeryActiveMinutes==0)
sum(dataActivity_big$FairlyActiveMinutes==0)
sum(dataActivity_big$LightlyActiveMinutes==0)
sum(dataActivity_big$SedentaryMinutes==0)


summary(hourlyCalories_merged_3_12_16_4_11_16)
summary(hourlyCalories_merged_4_12_16_5_12_16)
summary(hourlySteps_merged_3_12_16_4_11_16)
summary(hourlySteps_merged_4_12_16_5_12_16)
##CLEAN 0S##
hourlySteps_1 <- subset(hourlySteps_merged_3_12_16_4_11_16, StepTotal !=0)
hourlySteps_2 <- subset(hourlySteps_merged_4_12_16_5_12_16, StepTotal !=0)

##EXPORTAR PARA TABLEAU##
write_csv(hourlyCalories_merged_3_12_16_4_11_16, file = "hourlyCalories_1.csv")
write_csv(hourlyCalories_merged_4_12_16_5_12_16, file = "hourlyCalories_2.csv")
write_csv(hourlySteps_1, file = "hourlySteps_1.csv")
write_csv(hourlySteps_2, file = "hourlySteps_2.csv")

## borro los steps antiguos con los 0s ##
rm(hourlySteps_merged_3_12_16_4_11_16)
rm(hourlySteps_merged_4_12_16_5_12_16)
## Merge de cada calories y steps##

hourlySteps_BIG <- merge(hourlySteps_1, hourlySteps_2, all = TRUE)
sum(is.na(hourlySteps_BIG))
sum(hourlySteps_BIG$StepTotal==0)
sum(is.na(hourlySteps_1))
sum(is.na(hourlySteps_2))
sum(hourlySteps_1$StepTotal==0)
sum(hourlySteps_2$StepTotal==0)

hourlyCalories_BIG <- merge(hourlyCalories_merged_3_12_16_4_11_16, hourlyCalories_merged_4_12_16_5_12_16, all = TRUE)

##EXPORTAR PARA TABLEAU ##

write_csv(hourlyCalories_BIG, file = "hourlyCalories_BIG.csv")
write_csv(hourlySteps_BIG, file = "hourlySteps_BIG.csv")   

## Separar hora y fecha en columnas distintas ##

class(hourlyCalories_BIG$ActivityHour)

hourlyCalories_BIG$ActivityHour=as.POSIXct(hourlyCalories_BIG$ActivityHour, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
hourlyCalories_BIG$time <- format(hourlyCalories_BIG$ActivityHour, format = "%H:%M:%S")
hourlyCalories_BIG$date <- format(hourlyCalories_BIG$ActivityHour, format = "%m/%d/%y")

hourlySteps_BIG$ActivityHour=as.POSIXct(hourlySteps_BIG$ActivityHour, format="%m/%d/%Y %I:%M:%S %p", tz=Sys.timezone())
hourlySteps_BIG$time <- format(hourlySteps_BIG$ActivityHour, format = "%H:%M:%S")
hourlySteps_BIG$date <- format(hourlySteps_BIG$ActivityHour, format = "%m/%d/%y")

