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

## numeros Id por mes ##
n_distinct(dataActivity_sindistancia$Id)
n_distinct(dataActivity_sindistancia2$Id)

# duplicados 

sum(duplicated(dailyActivity_merged))
dailyActivity_merged <- dailyActivity_merged[!duplicated(dailyActivity_merged), ]
sum(duplicated(dailyActivity_merged2))
dailyActivity_merged2 <- dailyActivity_merged2[!duplicated(dailyActivity_merged2), ]

##sacar columnas innecesarias##

dataActivity_sindistancia <- select(dailyActivity_merged, -LoggedActivitiesDistance, -VeryActiveDistance, 
                                    -ModeratelyActiveDistance, -LightActiveDistance, 
                                    -SedentaryActiveDistance, -TotalDistance, -TrackerDistance
)
dataActivity_sindistancia2 <- select(dailyActivity_merged2, -LoggedActivitiesDistance, -VeryActiveDistance, 
                                     -ModeratelyActiveDistance, -LightActiveDistance, 
                                     -SedentaryActiveDistance, -TotalDistance, -TrackerDistance
)

# Comprobar si esque ocupare los dos meses

## MERGE ##
dataActivity_SD_big <- merge(dataActivity_sindistancia, dataActivity_sindistancia2, all = TRUE)

#### Numero de datos segun mes

# Convertir la columna de fechas a tipo Date

dataActivity_SD_big$ActivityDate <- as.Date(dataActivity_SD_big$ActivityDate, format="%m/%d/%Y")
dataActivity_sind_week$ActivityDate <- as.Date(dataActivity_sind_week$ActivityDate, format="%m/%d/%Y")
dataActivity_sind_week2$ActivityDate <- as.Date(dataActivity_sind_week2$ActivityDate, format="%m/%d/%Y")

#Grafico 

#dataActivity_SD_big

ggplot(data=dataActivity_SD_big, aes(x=ActivityDate))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")

# Solo voy a ocupar el mes 2 por pocos datos del mes 1

#### CREACION DE COLUMNAS PARA DIAS DE LA SEMANA 

dataActivity_sind_week2 <- dataActivity_sindistancia2 %>% 
  mutate(Weekday = weekdays(as.Date(ActivityDate, "%m/%d/%Y")))

#Exportar #
dataActivity_sindistancia2
write_csv(dataActivity_sindistancia, file = "dataActivity_sind_week.csv")
write_csv(dataActivity_sindistancia2, file = "dataActivity_sind_week2.csv")
write_csv(dataActivity_SD_big, file = "dataActivity_SD_big.csv")
rm(dataActivity_sind_week, dataActivity_sind_weekdate)
# total de minutos

total_minutes <- sum(dataActivity_sind_week2$SedentaryMinutes, dataActivity_sind_week2$VeryActiveMinutes, dataActivity_sind_week2$FairlyActiveMinutes, dataActivity_sind_week2$LightlyActiveMinutes)
sedentary_percentage <- sum(dataActivity_sind_week2$SedentaryMinutes)/total_minutes*100
lightly_percentage <- sum(dataActivity_sind_week2$LightlyActiveMinutes)/total_minutes*100
fairly_percentage <- sum(dataActivity_sind_week2$FairlyActiveMinutes)/total_minutes*100
active_percentage <- sum(dataActivity_sind_week2$VeryActiveMinutes)/total_minutes*100

#Pie charts
percentage <- data.frame(
  level=c("Sedentario", "Ligeramente", "Justamente", "Muy activo"),
  minutes=c(sedentary_percentage,lightly_percentage,fairly_percentage,active_percentage)
)

# instalar paquete para hacer grafico de piza

install.packages("plotly")
library(plotly)

plot_ly(percentage, labels = ~level, values = ~minutes, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
  layout(title = 'Minutos de nivel de actividad',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))


