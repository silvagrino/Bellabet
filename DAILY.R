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


# Analisis exploratorio 

# COLUMNAS
colnames(dailyActivity_merged)
colnames(dailyActivity_merged2)
# NUMERO DE ROWS, FILAS
nrow(dailyActivity_merged)
nrow(dailyActivity_merged2)
# FILAS DISTINTAS
n_distinct(dailyActivity_merged)
n_distinct(dailyActivity_merged2)
# Summary
summary(dailyActivity_merged %>%
          select(-Id, -ActivityDate))
summary(dailyActivity_merged2 %>%
          select(-Id, -ActivityDate))

##check nulls

sum(is.na(dailyActivity_merged))
sum(is.na(dailyActivity_merged2))

## numeros Id por mes 
n_distinct(dataActivity_sindistancia$Id)
n_distinct(dataActivity_sindistancia2$Id)

# duplicados 

sum(duplicated(dailyActivity_merged))
dailyActivity_merged <- dailyActivity_merged[!duplicated(dailyActivity_merged), ]
sum(duplicated(dailyActivity_merged2))
dailyActivity_merged2 <- dailyActivity_merged2[!duplicated(dailyActivity_merged2), ]

# Remover columnas innecesarias

dataActivity_sindistancia <- select(dailyActivity_merged, -LoggedActivitiesDistance, -VeryActiveDistance, 
                                    -ModeratelyActiveDistance, -LightActiveDistance, 
                                    -SedentaryActiveDistance, -TotalDistance, -TrackerDistance
)
dataActivity_sindistancia2 <- select(dailyActivity_merged2, -LoggedActivitiesDistance, -VeryActiveDistance, 
                                     -ModeratelyActiveDistance, -LightActiveDistance, 
                                     -SedentaryActiveDistance, -TotalDistance, -TrackerDistance
)

# Compruebo si ocupare los dos meses

# MERGE 
dataActivity_SD_big <- merge(dataActivity_sindistancia, dataActivity_sindistancia2, all = TRUE)

# Numero de datos segun mes

# Convertir la columna de fechas a tipo Date

dataActivity_SD_big$ActivityDate <- as.Date(dataActivity_SD_big$ActivityDate, format="%m/%d/%Y")
dataActivity_sind_week$ActivityDate <- as.Date(dataActivity_sind_week$ActivityDate, format="%m/%d/%Y")
dataActivity_sind_week2$ActivityDate <- as.Date(dataActivity_sind_week2$ActivityDate, format="%m/%d/%Y")
sleepDay_merged$SleepDay <- as.Date(sleepDay_merged$SleepDay, format="%m/%d/%Y")

#Grafico 

#dataActivity_SD_big

ggplot(data=dataActivity_SD_big, aes(x=ActivityDate))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")


# Sleep

ggplot(data=sleepDay_merged, aes(x=SleepDay))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")


# Solo voy a ocupar el mes 2 por pocos datos del mes 1

# Creacion de columna dias de la semana

dataActivity_sind_week2 <- dataActivity_sindistancia2 %>% 
  mutate(Weekday = weekdays(as.Date(ActivityDate, "%m/%d/%Y")))

dataActivity_SD_big <- dataActivity_SD_big %>% 
  mutate(Weekday = weekdays(as.Date(ActivityDate, "%m/%d/%Y")))


# Calcular la cantidad de registros por día de la semana

# daily 

registros_por_dia_daily <- dataActivity_sind_week2 %>%
  group_by(Weekday) %>%
  summarise(TotalRegistros = n())

# Sleep

# Analisis exploratorio
colnames(sleepDay_merged)
nrow(sleepDay_merged)
sum(duplicated(sleepDay_merged))
sum(is.na(sleepDay_merged))
n_distinct(sleepDay_merged)
summary(sleepDay_merged      %>%
          select(-Id, -SleepDay, -TotalSleepRecords))


registros_por_dia_sleep <- sleepDay_merged_week %>%
  group_by(Weekday) %>%
  summarise(TotalRegistros = n())

# Visualizar la cantidad de registros por día de la semana

# daily

ggplot(data=registros_por_dia, aes(x=reorder(Weekday, -TotalRegistros), y=TotalRegistros)) +
  geom_bar(stat="identity", fill="steelblue") +
  labs(title="Cantidad de Datos Totales por Día de la Semana daily",
       x="Día de la Semana",
       y="Cantidad de Registros") +
  theme_minimal()

# sleep

ggplot(data=registros_por_dia_sleep, aes(x=reorder(Weekday, -TotalRegistros), y=TotalRegistros)) +
  geom_bar(stat="identity", fill="steelblue") +
  labs(title="Cantidad de Datos Totales por Día de la Semana sleep",
       x="Día de la Semana",
       y="Cantidad de Registros") +
  theme_minimal()


#Exportar #

write_csv(dataActivity_sind_week2, file = "dataActivity_sind_week2.csv")
write_csv(dataActivity_SD_big, file = "dataActivity_SD_big.csv")

# Creación de grafico de pizza. Minutos de tipo de actividad

# total de minutos

total_minutes <- sum(dataActivity_sind_week2$SedentaryMinutes, dataActivity_sind_week2$VeryActiveMinutes, dataActivity_sind_week2$FairlyActiveMinutes, dataActivity_sind_week2$LightlyActiveMinutes)
sedentary_percentage <- sum(dataActivity_sind_week2$SedentaryMinutes)/total_minutes*100
lightly_percentage <- sum(dataActivity_sind_week2$LightlyActiveMinutes)/total_minutes*100
fairly_percentage <- sum(dataActivity_sind_week2$FairlyActiveMinutes)/total_minutes*100
active_percentage <- sum(dataActivity_sind_week2$VeryActiveMinutes)/total_minutes*100

# Chart

percentage <- data.frame(
  level=c("Sedentario", "Ligeramente", "Justamente", "Muy activo"),
  minutes=c(sedentary_percentage,lightly_percentage,fairly_percentage,active_percentage)
)

# instalar paquete para hacer grafico de piza

install.packages("plotly")
library(plotly)

#plot

plot_ly(percentage, labels = ~level, values = ~minutes, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
  layout(title = 'Minutos de nivel de actividad',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# Promedio de pasos por dia de la semana.

 # dataActivity_SD_big  

# Agrupar por día de la semana y calcular el promedio de pasos
avg_steps_per_day2 <- dataActivity_SD_big %>%
  group_by(Weekday) %>%
  summarise(AvgSteps = mean(TotalSteps, na.rm = TRUE)) %>%
  mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))

# Crear el gráfico con etiquetas de promedio
ggplot(avg_steps_per_day2, aes(x = Weekday, y = AvgSteps)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_text(aes(label = round(AvgSteps, 0)), vjust = -0.3, size = 3)
  labs(title = "Promedio de pasos por día de la semana",
       x = "Día de la semana",
       y = "Pasos promedio") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
# solo el mes 2. dataActivity_sind_week2
  
  # Agrupar por día de la semana y calcular el promedio de pasos
  avg_steps_per_day <- dataActivity_sind_week2 %>%
    group_by(Weekday) %>%
    summarise(AvgSteps = mean(TotalSteps, na.rm = TRUE)) %>%
    mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))
  
  # Crear el gráfico con etiquetas de promedio
  ggplot(avg_steps_per_day, aes(x = Weekday, y = AvgSteps)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    geom_text(aes(label = round(AvgSteps, 0)), vjust = -0.3, size = 3)
  labs(title = "Promedio de pasos por día de la semana",
       x = "Día de la semana",
       y = "Pasos promedio") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  # CALORIES
  
  avg_calories_per_day <- dataActivity_sind_week2 %>%
    group_by(Weekday) %>%
    summarise(AvgCalories = mean(Calories, na.rm = TRUE)) %>%
    mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))
  
  ggplot(avg_calories_per_day, aes(x = Weekday, y = AvgCalories)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    geom_text(aes(label = round(AvgCalories, 0)), vjust = -0.3, size = 3)
  labs(title = "Promedio de calorias por día de la semana",
       x = "Día de la semana",
       y = "Calorias promedio") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  # MINUTOS
  # Sedentary

  avg_sedentary_per_day <- dataActivity_sind_week2 %>%
    group_by(Weekday) %>%
    summarise(Avgsedentary = mean(SedentaryMinutes, na.rm = TRUE)) %>%
    mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))
  
  ggplot(avg_sedentary_per_day, aes(x = Weekday, y = Avgsedentary)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    geom_text(aes(label = round(Avgsedentary, 0)), vjust = -0.3, size = 3)
  labs(title = "Promedio de minutos sedentarios por día de la semana",
       x = "Día de la semana",
       y = "Calorias promedio") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  

  # Sleep
  
# Cargo sleepday_merged y creo columna con la diferencia de tiempo en cama y tiempo dormido

sleepDay_merged <- sleepDay_merged %>%
  mutate(TimeToFallAsleep = TotalTimeInBed - TotalMinutesAsleep)

  # crear columna de dias de la semana

sleepDay_merged_week <- sleepDay_merged %>% 
  mutate(Weekday = weekdays(as.Date(SleepDay, "%m/%d/%Y")))     

# Agrupar por el día de la semana y calcular el promedio de minutos de sueño

avg_sleep_per_day <- sleepDay_merged_week %>%
  group_by(Weekday) %>%
  summarise(AvgMinutesAsleep = mean(TotalMinutesAsleep, na.rm = TRUE)) %>%
  mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))

# Crear el gráfico de barras del tiempo promedio de sueño por día de la semana

ggplot(avg_sleep_per_day, aes(x = Weekday, y = AvgMinutesAsleep)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  geom_text(aes(label = round(AvgMinutesAsleep, 0)), vjust = -0.3, size = 3) + 
  labs(title = "Promedio de minutos de sueño por día de la semana",
       x = "Día de la semana",
       y = "Minutos promedio de sueño") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#  Grafica de correlacion pasos totales y calorias 

# Crear el gráfico de dispersión entre calorías y pasos totales

ggplot(dataActivity_sind_week2, aes(x = TotalSteps, y = Calories)) +
  geom_point(color = "blue", alpha = 0.6) + 
  geom_smooth(method = "lm", col = "red") +  
  labs(title = "Relación entre Pasos Totales y Calorías Quemadas",
       x = "Total de Pasos",
       y = "Calorías") +
  theme_minimal()

# VeryActiveMinutes

avg_VeryActiveMinutes_per_day <- dataActivity_sind_week2 %>%
  group_by(Weekday) %>%
  summarise(AvgVeryActiveMinutes = mean(VeryActiveMinutes, na.rm = TRUE)) %>%
  mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))

ggplot(avg_VeryActiveMinutes_per_day, aes(x = Weekday, y = AvgVeryActiveMinutes)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_text(aes(label = round(AvgVeryActiveMinutes, 0)), vjust = -0.3, size = 3)
labs(title = "Promedio de minutos muy activos por día de la semana",
     x = "Día de la semana",
     y = "Minutos muy activos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# FairlyActiveMinutes

avg_FairlyActiveMinutes_per_day <- dataActivity_sind_week2 %>%
  group_by(Weekday) %>%
  summarise(AvgFairlyActiveMinutes = mean(FairlyActiveMinutes, na.rm = TRUE)) %>%
  mutate(Weekday = factor(Weekday, levels = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")))

ggplot(avg_FairlyActiveMinutes_per_day, aes(x = Weekday, y = AvgFairlyActiveMinutes)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_text(aes(label = round(AvgFairlyActiveMinutes, 0)), vjust = -0.3, size = 3)
labs(title = "Promedio de minutos muy activos por día de la semana",
     x = "Día de la semana",
     y = "Minutos muy activos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Cuantos de los usuarios cumplen con el criterio OMS

active_users <- dataActivity_sind_week2 %>%
  filter(FairlyActiveMinutes >= 21.4 | VeryActiveMinutes>=10.7) %>% 
  group_by(Id) %>% 
  count(Id) 

# Comparar Minutos sedentarios por dia de la semana x  Promedio de pasos por dia de la semana x Calorias por dia de la semana

###  correlacion entre variables

cor(dataActivity_sind_week2$SedentaryMinutes, dataActivity_sind_week2$TotalSteps)
cor(dataActivity_sind_week2$SedentaryMinutes, dataActivity_sind_week2$Calories)
cor(dataActivity_sind_week2$TotalSteps, dataActivity_sind_week2$Calories)

# Grafico de disperson calorias vs sedentaryminutes

ggplot(dataActivity_sind_week2, aes(x = Calories, y = SedentaryMinutes)) +
  geom_point(color = "blue", alpha = 0.6) +  # Puntos en el gráfico
  geom_smooth(method = "lm", col = "red") +  # Línea de regresión
  labs(title = "Relación entre Calorías Quemadas y Minutos sedentarios",
       x = "Calorias",
       y = "Minutos sedentarios") +
  theme_minimal()

# Grafico de disperson Total Steps vs sedentaryminutes

ggplot(dataActivity_sind_week2, aes(x = TotalSteps, y = SedentaryMinutes)) +
  geom_point(color = "blue", alpha = 0.6) +  # Puntos en el gráfico
  geom_smooth(method = "lm", col = "red") +  # Línea de regresión
  labs(title = "Relación entre Pasos totales y Minutos sedentarios",
       x = "Pasos Totales",
       y = "Minutos sedentarios") +
  theme_minimal()

