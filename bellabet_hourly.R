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
install.packages("readxl")
library(readxl)

###################

# cargando archivos #

hourlyCalories_merged_3_12_16_4_11_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlyCalories_merged_3_12_16_4_11_16.csv")
hourlySteps_merged_3_12_16_4_11_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlySteps_merged_3_12_16_4_11_16.csv")
hourlyCalories_merged_4_12_16_5_12_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlyCalories_merged_4_12_16_5_12_16.csv")
hourlySteps_merged_4_12_16_5_12_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlySteps_merged_4_12_16_5_12_16.csv")

Calories_1 <- hourlyCalories_merged_3_12_16_4_11_16
Calories_2 <- hourlyCalories_merged_4_12_16_5_12_16
Steps_1 <- hourlySteps_merged_3_12_16_4_11_16
Steps_2 <- hourlySteps_merged_4_12_16_5_12_16

rm(hourlyCalories_merged_3_12_16_4_11_16, hourlyCalories_merged_4_12_16_5_12_16, hourlySteps_merged_3_12_16_4_11_16,
   hourlySteps_merged_4_12_16_5_12_16)

# ids distintos#

n_distinct(Calories_1$Id)
n_distinct(Calories_2$Id)
n_distinct(Steps_1$Id)
n_distinct(Steps_2$Id)

#Resumen general. Summary #

summary(Calories_1)
summary(Calories_2)
summary(Steps_1)
summary(Steps_2)


#comprobacion de valors nulos###

sum(is.na(Calories_1))
sum(is.na(Steps_1))
sum(is.na(Calories_2))
sum(is.na(Steps_2))

###Comprobar formato de fecha y hora

class(Calories_1$ActivityHour)
class(Calories_2$ActivityHour)
class(Steps_1$ActivityHour)
class(Steps_2$ActivityHour)

## Merge de cada calories y steps##

hourlySteps_BIG <- merge(Steps_1, Steps_2, all = TRUE)

hourlyCalories_BIG <- merge(Calories_1, Calories_2, all = TRUE)

# PARA COMPROBAR SI HAY VALORES NA. SI has_na es TRUE, hay 

has_na <- anyNA(hourlySteps_BIG$ActivityHour)
has_na <- anyNA(hourlyCalories_BIG$ActivityHour)

## CREANDO COLUMNAS SEPARADAS ##

## CONVERSION DE COLUMNAS DE BIG (1Y2)

hourlyCalories_BIG$ActivityHour <- mdy_hms(hourlyCalories_BIG$ActivityHour)
hourlyCalories_BIG$time <- format(hourlyCalories_BIG$ActivityHour, format = "%H:%M:%S")
hourlyCalories_BIG$date <- format(hourlyCalories_BIG$ActivityHour, format = "%d/%m/%y")
####################################################################################################
hourlySteps_BIG$ActivityHour <- mdy_hms(hourlySteps_BIG$ActivityHour)
hourlySteps_BIG$time <- format(hourlySteps_BIG$ActivityHour, format = "%H:%M:%S")
hourlySteps_BIG$date <- format(hourlySteps_BIG$ActivityHour, format = "%d/%m/%y")
####################################################################################################

rm(hourlyCalories_BIG, hourlyCalories_BIG, hourlyCalories_BIGcol, hourlySteps_BIG, hourlySteps_BIGPRE2)
## Separar hora y fecha en columnas distintas ##

# HASTA AQUI ANALISIS EXPLORATIORIO INICIAL Y HACER MERGE DE MES 1 Y 2 DE CALORIES Y STEPS #

###### comprobar si vale la merge meses 1 y 2 

###### NUMERO DE DATOS SEGUN MES #######

# fechas y luego graficar los datos por fecha

#Tiene que aplicarse a solo fecha, en estos dataset esta con fecha y hora juntos

#Grafico 

# BIGS
ggplot(data=hourlyCalories_BIG, aes(x=date))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")

ggplot(data=hourlySteps_BIG, aes(x=date))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")


#### CREACION DE COLUMNAS PARA DIAS DE LA SEMANA 

hourlyCalories_BIG <- hourlyCalories_BIG %>% 
  mutate(Weekday = weekdays(as.Date(date, "%d/%m/%Y")))

hourlySteps_BIG <- hourlySteps_BIG %>% 
  mutate(Weekday = weekdays(as.Date(date, "%d/%m/%Y")))

## EXPORTANDO

write.csv(hourlyCalories_BIG, "hourlyCalories_BIG.csv")
write.csv(hourlySteps_BIG, "hourlySteps_BIG.csv")
