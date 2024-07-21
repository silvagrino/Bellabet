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


############ VER RESUMENES Y CABEZAS ############

head(dailyActivity_merged)
# COLUMNAS
colnames(dailyActivity_merged)
colnames(dailyActivity_merged2)
# NUMERO DE ROWS, FILAS
nrow(dailyActivity_merged)
nrow(dailyActivity_merged2)
# FILAS DISTINTAS
n_distinct(dailyActivity_merged)
n_distinct(dailyActivity_merged2)
###### Summary ######
summary(dailyActivity_merged %>%
          select(-Id, -ActivityDate))
summary(dailyActivity_merged2 %>%
          select(-Id, -ActivityDate))

############################

##check nulls##

sum(is.na(dailyActivity_merged))
sum(is.na(dailyActivity_merged2))

##sacar columnas innecesarias##

dataActivity_sindistancia <- select(dailyActivity_merged, -LoggedActivitiesDistance, -VeryActiveDistance, 
  -ModeratelyActiveDistance, -LightActiveDistance, 
  -SedentaryActiveDistance, -TotalDistance, -TrackerDistance
)
dataActivity_sindistancia2 <- select(dailyActivity_merged2, -LoggedActivitiesDistance, -VeryActiveDistance, 
  -ModeratelyActiveDistance, -LightActiveDistance, 
  -SedentaryActiveDistance, -TotalDistance, -TrackerDistance
)

## numeros Id por mes ##
n_distinct(dataActivity_sindistancia$Id)
n_distinct(dataActivity_sindistancia2$Id)

## MERGE ##
dataActivity_SD_big <- merge(dataActivity_sindistancia, dataActivity_sindistancia2, all = TRUE)

# Exportar
write_csv(dataActivity_SD_big, file = "dataActivity_SD_big.csv")

## numeros Id por mes ##
n_distinct(dataActivity_SD_big$Id)

#Exportar cada uno para analizar solo el dataactivity_sindistancia2 porque es el que tiene mas datos #

write_csv(dataActivity_sindistancia, file = "dataActivity_sindistancia.csv")
write_csv(dataActivity_sindistancia2, file = "dataActivity_sindistancia2.csv")

