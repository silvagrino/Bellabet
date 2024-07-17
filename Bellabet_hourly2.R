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

###################

  # cargando archivos #

hourlyCalories_merged_3_12_16_4_11_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlyCalories_merged_3_12_16_4_11_16.csv")
hourlySteps_merged_3_12_16_4_11_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlySteps_merged_3_12_16_4_11_16.csv")
hourlyCalories_merged_4_12_16_5_12_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlyCalories_merged_4_12_16_5_12_16.csv")
hourlySteps_merged_4_12_16_5_12_16 <- read.csv("D:/Desktop/BIG/Portafolio/Bellabet_/github descripcion - copia/HOURLY/base/hourlySteps_merged_4_12_16_5_12_16.csv")

##Estandarizar formato hora

## Diferencias en tablas y ver si hago merge

# ids distintos#

n_distinct(hourlyCalories_merged_3_12_16_4_11_16$Id)
n_distinct(hourlyCalories_merged_4_12_16_5_12_16$Id)
n_distinct(hourlySteps_merged_3_12_16_4_11_16$Id)
n_distinct(hourlySteps_merged_4_12_16_5_12_16$Id)

#Resumen general. Summary #

summary(hourlyCalories_merged_3_12_16_4_11_16)
summary(hourlyCalories_merged_4_12_16_5_12_16)
summary(hourlySteps_merged_3_12_16_4_11_16)
summary(hourlySteps_merged_4_12_16_5_12_16)


#comprobacion de valors nulos###

sum(is.na(hourlySteps_BIGcon0))

sum(is.na(hourlyCalories_merged_3_12_16_4_11_16))
sum(is.na(hourlySteps_merged_3_12_16_4_11_16))
sum(is.na(hourlyCalories_merged_4_12_16_5_12_16))
sum(is.na(hourlySteps_merged_4_12_16_5_12_16))

#######################################################


class(hourlyCalories_merged_3_12_16_4_11_16$ActivityHour)
class(hourlyCalories_merged_4_12_16_5_12_16$ActivityHour)
class(hourlySteps_merged_3_12_16_4_11_16$ActivityHour)
class(hourlySteps_merged_4_12_16_5_12_16$ActivityHour)



# resumen de las tablas

summary(hourlyCalories_merged_3_12_16_4_11_16)
summary(hourlyCalories_merged_4_12_16_5_12_16)
summary(hourlySteps_merged_3_12_16_4_11_16)
summary(hourlySteps_merged_4_12_16_5_12_16)



##EXPORTAR PARA TABLEAU##
write_csv(hourlyCalories_merged_3_12_16_4_11_16, file = "hourlyCalories_1.csv")
write_csv(hourlyCalories_merged_4_12_16_5_12_16, file = "hourlyCalories_2.csv")
write_csv(hourlySteps_merged_3_12_16_4_11_16, file = "hourlySteps_1.csv")
write_csv(hourlySteps_merged_4_12_16_5_12_16, file = "hourlySteps_2.csv")

## Merge de cada calories y steps##

hourlySteps_BIGcon0 <- merge(hourlySteps_merged_3_12_16_4_11_16, hourlySteps_merged_4_12_16_5_12_16, all = TRUE)

hourlyCalories_BIG <- merge(hourlyCalories_merged_3_12_16_4_11_16, hourlyCalories_merged_4_12_16_5_12_16, all = TRUE)

##EXPORTAR PARA TABLEAU ##

write_csv(hourlyCalories_BIG, file = "hourlyCalories_BIG.csv")

write_csv(hourlySteps_BIGcon0, file = "hourlySteps_BIGcon0.csv")   

## Separar hora y fecha en columnas distintas ##

# HASTA AQUI ANALISIS EXPLORATIORIO INICIAL Y HACER MERGE DE MES 1 Y 2 DE CALORIES Y STEPS #

############# fefefe.R ############


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


hourlyCalories_BIG2 <- merge(hourlyCalories_1, hourlyCalories_2, all = TRUE)


# LOS HOURLY STEPS 1 Y 2 SON SIN CEROS, TENGO QUE OCUPAR LOS CON 0 # 
##       sum(hourlySteps_merged_3_12_16_4_11_16$StepTotal==0)
##       sum(hourlySteps_merged_4_12_16_5_12_16$StepTotal==0)



# cargo los hourly steps 1 y 2 con nombres originales

hourlySteps_BIGPRE2 <- merge(hourlySteps_merged_3_12_16_4_11_16, hourlySteps_merged_4_12_16_5_12_16, all = TRUE)


## CREANDO COLUMNAS SEPARADAS ##

#NOOOO


rm(hourlyCalories_BIGcol)
rm(hourlySteps_BIG)

#  PARA COMPROBAR SI HAY VALORES NA. SI has_na es TRUE, hay 

has_na <- anyNA(hourlySteps_BIGPRE$ActivityHour)

str(hourlySteps_BIGPRE2$ActivityHour)
class(hourlySteps_BIGPRE2$ActivityHour)
mdy(hourlyCalories_BIG$ActivityHour)
mdy_hms(hourlyCalories_BIG$ActivityHour)

## CONVERSION DE COLUMNAS

hourlyCalories_BIG$ActivityHour <- mdy_hms(hourlyCalories_BIG$ActivityHour)
hourlyCalories_BIG$time <- format(hourlyCalories_BIG$ActivityHour, format = "%H:%M:%S")
hourlyCalories_BIG$date <- format(hourlyCalories_BIG$ActivityHour, format = "%d/%m/%y")
####################################################################################################
hourlySteps_BIGPRE2$ActivityHour <- mdy_hms(hourlySteps_BIGPRE2$ActivityHour)
hourlySteps_BIGPRE2$time <- format(hourlySteps_BIGPRE2$ActivityHour, format = "%H:%M:%S")
hourlySteps_BIGPRE2$date <- format(hourlySteps_BIGPRE2$ActivityHour, format = "%d/%m/%y")
####################################################################################################

# tengo que conservar como datasets finales hourlycalories_BIG y hourlySteps_ BIGPRE2



## EXPORTANDO LOS BIG CON COLUMNAS NUEVAS##
write.csv(hourlyCalories_BIG, "hourlyCalories_BIGcol.csv")
write.csv(hourlySteps_BIG, "hourlySteps_BIGPRE2.csv")

