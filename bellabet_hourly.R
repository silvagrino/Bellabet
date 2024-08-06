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

# cargando archivos #

hourlyCalories_merged_3_12_16_4_11_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlyCalories_merged_3_12_16_4_11_16.csv")
hourlySteps_merged_3_12_16_4_11_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlySteps_merged_3_12_16_4_11_16.csv")
hourlyCalories_merged_4_12_16_5_12_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlyCalories_merged_4_12_16_5_12_16.csv")
hourlySteps_merged_4_12_16_5_12_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlySteps_merged_4_12_16_5_12_16.csv")
# Renombrar
Calories_1 <- hourlyCalories_merged_3_12_16_4_11_16
Calories_2 <- hourlyCalories_merged_4_12_16_5_12_16
Steps_1 <- hourlySteps_merged_3_12_16_4_11_16
Steps_2 <- hourlySteps_merged_4_12_16_5_12_16

rm(hourlyCalories_merged_3_12_16_4_11_16, hourlyCalories_merged_4_12_16_5_12_16, hourlySteps_merged_3_12_16_4_11_16,
   hourlySteps_merged_4_12_16_5_12_16)

# Numeros de Id's distintos

n_distinct(Calories_1$Id)
n_distinct(Calories_2$Id)
n_distinct(Steps_1$Id)
n_distinct(Steps_2$Id)

# Resumen general

summary(Calories_1)
summary(Calories_2)
summary(Steps_1)
summary(Steps_2)

# Comprobando valores nulos

sum(is.na(Calories_1))
sum(is.na(Steps_1))
sum(is.na(Calories_2))
sum(is.na(Steps_2))

# Comprobar formato de fecha y hora

class(Calories_1$ActivityHour)
class(Calories_2$ActivityHour)
class(Steps_1$ActivityHour)
class(Steps_2$ActivityHour)

# Merge de calories y steps 1er y 2do mes

hourlySteps_BIG <- merge(Steps_1, Steps_2, all = TRUE)

hourlyCalories_BIG <- merge(Calories_1, Calories_2, all = TRUE)

# Comprbar valores NA. SI has_na es TRUE, hay 

has_na <- anyNA(hourlySteps_BIG$ActivityHour)
has_na <- anyNA(hourlyCalories_BIG$ActivityHour)

## Creando columnas de fecha y tiempo 

hourlyCalories_BIG$ActivityHour <- mdy_hms(hourlyCalories_BIG$ActivityHour)
hourlyCalories_BIG$time <- as.Date(hourlyCalories_BIG$ActivityHour, format = "%H:%M:%S")
hourlyCalories_BIG$date <- as.Date(hourlyCalories_BIG$ActivityHour, format = "%d/%m/%y")

hourlySteps_BIG$ActivityHour <- mdy_hms(hourlySteps_BIG$ActivityHour)
hourlySteps_BIG$time <- as.Date(hourlySteps_BIG$ActivityHour, format = "%H:%M:%S")
hourlySteps_BIG$date <- as.Date(hourlySteps_BIG$ActivityHour, format = "%d/%m/%y")


## Cantidad de datos totales

# Grafico BIG's

ggplot(data=hourlyCalories_BIG, aes(x=date))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")

ggplot(data=hourlySteps_BIG, aes(x=date))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")


#### Creacion de columna para dia de la semana

hourlyCalories_BIG <- hourlyCalories_BIG %>% 
  mutate(Weekday = weekdays(as.Date(date, "%d/%m/%Y")))

hourlySteps_BIG <- hourlySteps_BIG %>% 
  mutate(Weekday = weekdays(as.Date(date, "%d/%m/%Y")))

## Exportar

write.csv(hourlyCalories_BIG, "hourlyCalories_BIG.csv")
write.csv(hourlySteps_BIG, "hourlySteps_BIG.csv")
