# Bellabet


![](imagenes/portada1.jpg)

## Tabla de Contenidos:

[1. Preguntar](https://github.com/silvagrino/prueba/tree/main?tab=readme-ov-file#1-preguntar)

[2. Preparar](https://github.com/silvagrino/prueba/tree/main?tab=readme-ov-file#2-preparar)

[3. Procesar](https://github.com/silvagrino/prueba/tree/main?tab=readme-ov-file#3-procesar)

[4. Análisis](https://github.com/silvagrino/prueba/tree/main?tab=readme-ov-file#4-an%C3%A1lisis)

[5. Conclusión](https://github.com/silvagrino/prueba/tree/main?tab=readme-ov-file#5-conclusi%C3%B3n)

[6. Actuar](https://github.com/silvagrino/prueba/tree/main?tab=readme-ov-file#6-actuar)



Bellabeat es una empresa fundada en 2013, es una compañía pequeña de tecnología enfocada en el bienestar para mujeres que ha crecido rápidamente. 
Dentro de sus productos destacan la App Bellabeat, Leaf, Time, Spring, y membresía Bellabeat.

Su Objetivo es Convertirse en una de las compañías más grande en el mercado global de dispositivos inteligentes.

La tarea del equipo: Analizar datos de dispositivos inteligentes para obtener información sobre el uso de estos dispositivos por parte de los consumidores y guiar la estrategia de marketing.

# 1. Preguntar

Objetivo del negocio: Analizar datos de Fitbit para obtener información y guiar la estrategia de marketing para el crecimiento global de Bellabeat.

Estos datos serán presentados a los stakeholders principales Urška Sršen y Sando Mur, miembros del equipo ejecutivo y stakeholders secundarios conformados por el equipo de análisis de marketing de Bellabeat.

Se puede resumir la tarea por delante en 4 preguntas claves para desarrollar este análisis:

1. ¿Cuáles son algunas tendencias en el uso de dispositivos inteligentes?
2. ¿Cómo podrían aplicarse estas tendencias a los clientes de Bellabeat?
3. ¿Cómo podrían estas tendencias influir en la estrategia de marketing de Bellabeat?
4. ¿Cuales son las variables mas efectivas para medir la actividad diaria de los usuarios?

# 2. Preparar

Fuente de datos: Datos de 30 participantes del rastreador de fitness FitBit obtenidos desde Kaggle. https://www.kaggle.com/datasets/arashnic/fitbit.

Constituido por 11 archivos para el primer mes, 18 para el segundo, abarcando un periodo total de 2 meses con datos de actividad física, frecuencia cardíaca y monitoreo del sueño minuto a minuto.


## Para preparar los datos aplicaré un Enfoque ROCCC:

* **R**eliable/Confiablilidad: Datos de 30 usuarios de FitBit que consintieron en la presentación de sus datos.

* **O**riginal/Originalidad: Datos originales obtenidos directamente de los usuarios desde sus dispositivos inteligentes.

* **C**omprehensive/Integralidad: Datos detallados y extensos pero con un tamaño de muestra pequeño e inconsistente, registrados en ciertos días de la semana. El 1er mes hay menos datos que en el 2do mes.

* **C**urrent/Actuales: Datos de marzo a mayo de 2016.

* **C**ited/Citación: No encontrado.


## El dataset tiene limitaciones:

* El Tamaño de la muestra son solo 30 usuarios, lo cual es pequeño para un análisis conclusivo y robusto.

* Inconsistencia en distribución de datos en número de usuarios; 33 usuarios para actividad diaria, 24 para sueño y 8 para peso, con algunas inconsistencias en el registro de datos.

* Método de registro del peso: 5 usuarios ingresaron manualmente su peso y 3 lo registraron a través de un dispositivo wifi.

* Fechas de registro inconsistente. La Mayoría de los datos están registrados en el 2.º mes. El primer mes no se puede considerar para hacer un analisis preciso con datos dispersos e inconsistentes.

* La mayoría de los registros son de martes a jueves, lo que podría no ser suficiente para un análisis preciso.


# 3. Procesar 

Primero seleccionaré los datasets con los que voy a trabajar, para esto tendré en cuenta la consistencia de datos, cantidad de usuarios y potencial conocimiento del actuar de los usuarios que podria darme para compartir con la campaña de marketing.

Comprobaré cuantos ID's diferentes hay registrados en todos los datasets. Para esto usaré `n_distinct()` entregandome como resultado los id's unicos de cada dataset.

* 33 ID: dailyActivity_merged, dailyCalories_merged, dailyIntensities_merged, dailySteps_merged, hourlyCalories_merged, hourlyIntensities_merged, hourlySteps_merged, minuteCaloriesNarrow_merged, minuteCaloriesWide_merged, minuteIntensitiesNarrow_merged, minuteIntensitiesWide_merged, minuteMETsNarrow_merged, minuteStepsNarrow_merged and minuteStepsWide

* 24 ID: minuteSleep_merged and sleepDay_merged

* 14 ID: heartrate_seconds_merged

* 8 ID: weightLogInfo_merged

#### Debido a la poca cantidad de usuarios, descartaré los datasets de frecuencia cardiaca y peso.

Seleccionaré los datasets:

- "dailyActivity_merged" porque me entrega varios datos en un solo dataset, como lo son los minutos dependiendo de la actividad, calorias y pasos diarios 

- "hourlyCalories_merged" y "hourlySteps_merged" porque me dan el detalle de cada hora de calorias gastadas y pasos dados.

- "sleepDay_merged" para poder analizar el patrón de sueño diario de los usuarios.


## DAILY

Hago análisis exploratorio inicial viendo columnas, número de filas, buscando duplicados y valores nulos.

```
colnames(dailyActivity_merged)
colnames(dailyActivity_merged2)
nrow(dailyActivity_merged)
nrow(dailyActivity_merged2)
sum(duplicated(dailyActivity_merged))
sum(duplicated(dailyActivity_merged2))
sum(is.na(dailyActivity_merged))
sum(is.na(dailyActivity_merged2))
```

Para el 1.º mes hay 457 filas. Para el 2.º mes son 940 filas. La diferencia es significativa, son mucho menos datos en el 1er mes. No hay duplicados ni valores nulos.

* Eliminaré los datos de distancia, son irrelevantes para mi ruta de análisis.

## HOURLY 


Seleccionaré dos datasets para analizar la cantidad de actividad y energía gastada por horas del dia: calories y steps, los cuales voy a renombrar.

```
Calories_1 <- hourlyCalories_merged_3_12_16_4_11_16
Calories_2 <- hourlyCalories_merged_4_12_16_5_12_16
Steps_1 <- hourlySteps_merged_3_12_16_4_11_16
Steps_2 <- hourlySteps_merged_4_12_16_5_12_16
```

Aplico un análisis exploratorio

```
 `colnames`
 `nrow`
 `sum(duplicated(_)`
 `sum(is.na(_)`
 `n_distinct`
 `class`
```

Sin valores duplicados ni valores nulos. La cantidad de ID distintos son de 33 a 34. Entre los datos del 1er y el 2do mes una diferencia en la cantidad de filas de 1.985. Evaluaré si es significativa al graficar la cantidad de datos totales por mes.


![](imagenes/hourly/nrowshourly.png)



No eliminaré valores 0. No hay horas donde se gaste 0 calorías, siempre hay un gasto calorico basal. Las horas en donde hay 0 pasos son parte del analisis, saber cuando no hubo movimiento.


## Sleep 

Cargo `sleepday_merged` y aplico las mismas funciones al dataset de horas de sueño.
Encuentro 3 duplicados, los cuales remuevo.

Creo una columna con la diferencia de tiempo en cama y tiempo dormido para obtener el tiempo que se han tardado los usuarios en conciliar el sueño.

```
sleepDay_merged <- sleepDay_merged %>%
  mutate(TimeToFallAsleep = TotalTimeInBed - TotalMinutesAsleep)
```


## Numero de datos por mes 

Como acabo de comprobar hay una diferencia significativa en dailyActivity_merged entre el 1er y 2do mes.

Para el 1er mes hay 457 filas.

Para el 2do mes son 940 filas.

Evaluaré la diferencia en la cantidad de datos en los 2 datasets:

1.º mes(3/12/16 al 4/11/16) y 2.º mes (4/12/16 al 5/12/16).

Mediré los datos según mes de todos los datasets para saber con cuáles trabajaré.

### DAILY (dailyActivity_merged, dailyActivity_merged2)

Hago merge de los 2 meses.

```
dataActivity_SD_big <- merge(dataActivity_sindistancia, dataActivity_sindistancia2, all = TRUE)
```

Numeros Id's unicos por mes
```
n_distinct(dataActivity_sindistancia$Id)
n_distinct(dataActivity_sindistancia2$Id)
```

Los Id's registrados en los meses son 33 para el 1.º mes y 35 para el 2.º. Por lo tanto, la diferencia de datos no se debe a que menos ID’s se hayan registrado.

Graficaré los datos totales por fecha, por lo cual lo primero será comprobar el tipo de dato que tiene la columna fecha con `class()` .
La cual es “character” por lo tanto, hay que convertirla.
Hago merge de los dos meses y convierto la columna de fechas a tipo Date.

```
dataActivity_SD_big$ActivityDate <- as.Date(dataActivity_SD_big$ActivityDate, format="%m/%d/%Y")
dataActivity_sind_week$ActivityDate <- as.Date(dataActivity_sind_week$ActivityDate, format="%m/%d/%Y")
dataActivity_sind_week2$ActivityDate <- as.Date(dataActivity_sind_week2$ActivityDate, format="%m/%d/%Y")
```

### Plot cantidad de datos por fecha:

```
ggplot(data=dataActivity_SD_big, aes(x=ActivityDate))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")
```

![](imagenes/daily/Data_recolectada_por_fecha.png)

* Solo consideraré para mi analisis el 2.º mes, la diferencia de datos totales es grande. El 2.º mes tiene datos más consistentes. Ocupar el 1er mes me llevaria a un analisis impreciso.

## HOURLY 


Como vi en el analisis exploratorio  hay una diferencia en la cantidad de filas (1.985 registros) en los datos del 1er y el 2do mes.
Hago un merge de los datasets de calories y steps respectivamente.

```
hourlySteps_BIG <- merge(Steps_1, Steps_2, all = TRUE)
hourlyCalories_BIG <- merge(Calories_1, Calories_2, all = TRUE)
```

### CANTIDAD DE DATOS MES 1 Y 2 

```
ggplot(data=hourlyCalories_BIG, aes(x=date))+
  geom_bar(fill="steelblue")+
 labs(title="Data recolectada por fecha")

ggplot(data=hourlySteps_BIG, aes(x=date))+
  geom_bar(fill="steelblue")+
  labs(title="Data recolectada por fecha")
```


![](imagenes/hourly/data_recolectada_por_fecha_hourly.png)

* Si voy a considerar para mi analisis para los dos meses en este caso, dado que la diferencia no es significativa.


### Sleep


![](imagenes/daily/datarecolectadafechaSleep.png)

* Asimismo, dedicaré los dos meses al análisis de los datos registrados durante las horas de sueño, los cuales presentan consistencia y regularidad.

## Creación de columna para día de la semana

Crearé una columna adicional para los días de la semana en todo el conjunto de datos; "dataActivity", "hourlyCalories", "hourlySteps", "sleepDay"
Esto para comprobar las fluctuciones en los datos a lo largo de la semana.


```
dataActivity_sind_week2 <- dataActivity_sindistancia2 %>% 
  mutate(Weekday = weekdays(as.Date(ActivityDate, "%m/%d/%Y")))
```


## Cantidad de registros por día de la semana

```
registros_por_dia_sleep <- sleepDay_merged_week %>%
  group_by(Weekday) %>%
  summarise(TotalRegistros = n())
```



                Daily                                             Sleep

![](imagenes/daily/totalregistrosdaily.png)   ![](imagenes/daily/Totalregistrossleep.png) 


```
ggplot(data=registros_por_dia, aes(x=reorder(Weekday, -TotalRegistros), y=TotalRegistros)) +
  geom_bar(stat="identity", fill="steelblue") +
  labs(title="Cantidad de Datos Totales por Día de la Semana",
       x="Día de la Semana",
       y="Cantidad de Registros") +
  theme_minimal()
```


![](imagenes/daily/Cantidadededatostotalesdiasemanadaily.png)

![](imagenes/daily/Cantidadededatostotalesdiasemanasleep.png)

*  Hay más datos totales registrados los martes, miércoles y jueves. Graficaré con promedios para minimizar el sesgo en los resultados por esta diferencia.

## Creación de columnas de fecha y tiempo 

Para preparar las visualizaciones donde pueda analizar cada hora del día primero tengo que dividir la columna de fecha y tiempo de los dataset "hourly"

### Hourly

Prepararé los datasets de horas separando fechas y horas en columnas diferentes.

```
hourlyCalories_BIG$ActivityHour <- mdy_hms(hourlyCalories_BIG$ActivityHour)
hourlyCalories_BIG$time <- as.Date(hourlyCalories_BIG$ActivityHour, format = "%H:%M:%S")
hourlyCalories_BIG$date <- as.Date(hourlyCalories_BIG$ActivityHour, format = "%d/%m/%y")

hourlySteps_BIG$ActivityHour <- mdy_hms(hourlySteps_BIG$ActivityHour)
hourlySteps_BIG$time <- as.Date(hourlySteps_BIG$ActivityHour, format = "%H:%M:%S")
hourlySteps_BIG$date <- as.Date(hourlySteps_BIG$ActivityHour, format = "%d/%m/%y")

```


# 4. Análisis 

### Daily

```
summary(dailyActivity_merged2 %>%
          select(-Id, -ActivityDate))
```
![](imagenes/daily/summary_mes_2.png)


El conjunto de datos "dailyActivity_merged2" proporciona una visión detallada de los patrones de actividad física de los usuarios durante el 
período registrado. En general, los usuarios lograron una media diaria de aproximadamente 7,638 pasos, con una distancia promedio de 5.49 kilómetros.
 Estos datos indican un nivel bajo-moderado de actividad física diaria.

Además, los minutos de actividad intensa y moderada reflejan que, aunque la mayoría de los días los usuarios no participaron en actividades
 de alta intensidad, hubo momentos en los que sí lo hicieron, alcanzando hasta 210 minutos de actividad intensa en un solo día. 
 Los minutos sedentarios promedio fueron altos, con una media cercana a los 991 minutos por día, lo que sugiere que los usuarios pasaron una 
 parte significativa de su día sin moverse. Pero también hay que considerar que los minutos sedentarios también son tiempo de sueño, 
 lo que representa 419 minutos en promedio por día (6,9 horas) lo cual se explondrá en el análisis de horas de sueño.

El gasto calórico medio fue de 2,304 calorías por día, lo que está en línea con un nivel moderado de actividad física. 

En resumen, dailyActivity_merged2 indica que los usuarios tienen un patrón de actividad que incluye tanto momentos de alta actividad como
 periodos de inactividad, ofreciendo oportunidades para promover una mayor actividad física y reducir el sedentarismo. 

### Hourly 
 

<img src="imagenes/hourly/summaryhourly.png" alt="Descripción de la imagen" width="300">


Hay una diferencia de 1.985 registros entre el 1.er y 2.º mes. 

Steps_2 destaca con un promedio y una mediana más elevada respecto a Step_1. 

Diferencia que también se hace visible al observar el 3.er cuartil. Por lo tanto, los usuarios del 2.º mes deberían registrar más tiempo 
destinado a actividad más vigorosa.


### Sleep

```
summary(sleepDay_merged      %>%
          select(-Id, -SleepDay, -TotalSleepRecords))
```
![](imagenes/daily/summarysleep.png)

La mayoría de las personas duermen entre 6 y 8 horas (observando el 1.er y 3.º cuartil: 361 - 490 minutos).
Gracias a la columna de `TimeToFallAsleep` podemos saber el tiempo que los usuarios están en cama sin dormir. Esto puede considerar el tiempo 
que se demora el usuario en quedarse dormido, así como también tiempos de insomnio o el tiempo que el usuario tarda en levantarse de la cama 
en la mañana. Aunque la mayoría de las personas parecen conciliar el sueño en menos de 30 minutos (observando los cuartiles), hay casos donde 
podrían presentarse problemas de conciliación del sueño o despertares nocturnos. También hay casos extremos que podrían reflejar insomnio
 o problemas para dormir. 

En la mayoría de las columnas, los valores promedio (mean) están cerca de la mediana, indicando que los datos están distribuidos
 de manera relativamente uniforme, exceptuando el tiempo para conciliar el sueño.

Este análisis superficial sugiere que la mayoría de las personas tienen buenos hábitos de sueño, pero hay algunos casos extremos que podrían 
requerir más investigación.


## Gráfico circular de minutos de actividad.
### Daily

Graficaré el total de minutos de actividad de las 4 categorías: **very active**, **fairly active**, **lightly active** y **sedentary**

```
plot_ly(percentage, labels = ~level, values = ~minutes, type = 'pie',textposition = 'outside',textinfo = 'label+percent') %>%
  layout(title = 'Minutos de nivel de actividad',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
```

![](imagenes/daily/R_minutos_de_nivel_de_actividad.png)


Los minutos sedentarios son la gran mayoría con un 81,3%. Hay que considerar que estos datos se miden a través de las 24 horas del día,
 incluyendo las horas de sueño.
 
La Organización Mundial de la Salud (OMS) recomienda que los adultos realicen al menos 150 a 300 minutos de actividad física aeróbica de
 intensidad moderada a la semana. También se puede realizar un mínimo de 75 a 150 minutos de actividad física aeróbica de intensidad vigorosa, 
 o una combinación de ambas. Lo cual equivale a 21,4 a 42,8 minutos diarios de intensidad moderada o de 10,7 a 21,4 minutos de intensidad vigorosa. 


## Minutos de actividad por días de la semana

### Actividad moderada y Actividad vigorosa

<img src="imagenes/daily/FairlyActiveMinutesporsemana.png" alt="Descripción de la imagen" width="400">  <img src="imagenes/daily/VeryActiveMinutesporsemana.png" alt="Descripción de la imagen" width="400">


En promedio, los usuarios no alcanzan la recomendación diaria de minutos de actividad moderada (21,3 a 42,8 minutos). El día con más actividad 
dentro de este rango es el sábado, los días laborales de la semana se mantienen estables.


En cuanto a la actividad vigorosa (VeryActiveMinutes) todos los usuarios en promedio alcanzan la recomendación, incluso superando el máximo sugerido. Los días con mayor actividad se producen los lunes
 y martes. Habrá que ver en que horario se producen estos minutos más activos, sabiendo así si se produce esta actividad en
  horarios típicamente laborales o fuera de la jornada. Analizaré más adelante la actividad por horas para ver el detalle en este prospecto.


#### Compruebo cuantos de los usuarios cumplen con las recomendaciones de actividad de la OMS.

```
active_users <- daily_activity %>%
  filter(FairlyActiveMinutes >= 21.4 | VeryActiveMinutes>=10.7) %>% 
  group_by(Id) %>% 
  count(Id) 
```

En el dataset hay 30 usuarios que cumplen con el criterio de al menos tener 150 minutos de actividad física aeróbica de intensidad moderada
 y un mínimo de 75 minutos de actividad física aeróbica de intensidad vigorosa, o una combinación de ambas semanalmente.


## Minutos sedentarios por día de la semana.

Lunes destaca como el día con más minutos sedentarios y jueves como el día con menos. Será necesario analizar cómo se relaciona esta variable con las demás para comprender su vínculo con la actividad física.

![](imagenes/daily/minutossedentariosporsemana.png)

A continuación analizaré los pasos por día, para comprobar si los días con mayor o menor actividad están asociados a la actividad física(pasos) 
o a otros factores de estrés que podrían aumentar el gasto calórico (mayores pulsaciones, estres, etc).


## Pasos por día de la semana 

```
ggplot(avg_steps_per_day, aes(x = Weekday, y = AvgSteps)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_text(aes(label = round(AvgSteps, 0)), vjust = -0.3, size = 3)
  labs(title = "Promedio de pasos por día de la semana",
       x = "Día de la semana",
       y = "Pasos promedio") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](imagenes/daily/pasos_por_dias_de_la_semana_mes2.png)

Podemos observar que el día con más pasos es el sábado, esto puede deberse a que los usuarios hagan más actividades recreativas en este día a 
diferencia de los días laborales donde les puede resultar más complicado. Durante lunes a viernes la cantidad de pasos se mantiene constante,
 destacando el día martes como el 2.º día con más pasos de la semana. El día sábado tiene una diferencia significativa respecto a los 
 otros días de la semana.

El día domingo destaca como el día con menos pasos, probablemente porque es un día que los usuarios descansan y se preparan para una nueva
 semana laboral.


## Calorías por día de la semana


![](imagenes/daily/Caloriasporsemana.png)

Martes y sábado se muestran como los días con más calorías coincidiendo con los dias de mas pasos. El dia jueves destaca como el dia con menos calorias gastadas, coincidiendo asi con 
uno de los dias con menos pasos por semana. Analizaré estas correlaciones.
Se mantienen las calorias en un rango equilibrado (2200-2356), existiendo poca diferencia entre maximo y minimo.



## Gráfico de dispersión **Calorías y Pasos totales**

```
ggplot(dataActivity_sind_week2, aes(x = TotalSteps, y = Calories)) +
  geom_point(color = "blue", alpha = 0.6) +  # Puntos en el gráfico
  geom_smooth(method = "lm", col = "red") +  # Línea de regresión
  labs(title = "Relación entre Pasos Totales y Calorías Quemadas",
       x = "Total de Pasos",
       y = "Calorías") +
  theme_minimal()
```

![](imagenes/daily/Relacion_pasos_calorias.png)

Como cabria esperar hay una correlación positiva entre los pasos totales y las calorías gastadas. Mientras más pasos se dan a lo largo del día,
 aumenta el gasto calórico de los usuarios.

Hay que destacar la presencia de outliers. Por un lado, están quienes probablemente tienen un gasto energético poco común por tener un
 metabolismo basal más elevado, gastar más energía en reposo. Estos usuarios pueden tener pocos pasos totales marcados pero tener un gasto 
 calórico elevado. Así mismo hay otros outliers a los cuales les pasa lo contrario. Dan muchos pasos, pero no tienen un gasto calórico muy elevado. 
 Aun así, no hay que perder la perspectiva de que estos son casos aislados. 



## Relación entre **Calorías Quemadas y Minutos sedentarios**

![](imagenes/daily/RelaciónentreCaloríasQuemadasyMinutossedentarios.png)

Existe una tendencia negativa débil entre calorías quemadas y minutos sedentarios. Es decir, a medida que las calorías quemadas aumentan, 
los minutos sedentarios tienden a disminuir.
La mayoría de los puntos se concentran en un rango de 1000 a 2500 calorías quemadas y entre 500 a 1200 minutos sedentarios.
Aunque hay cierta dispersión, se observa que en valores altos de calorías quemadas (>3000), los minutos sedentarios son generalmente más bajos.

Personas que queman más calorías parecen pasar menos tiempo sedentarias, lo cual es coherente con un estilo de vida más activo.
Sin embargo, la relación no es muy fuerte, ya que hay puntos con alta variabilidad (por ejemplo, algunas personas queman pocas calorías,
 pero aún tienen pocos minutos sedentarios, y viceversa).

Esto podría deberse a que las calorías quemadas pueden incluir actividades sedentarias con bajo impacto, como ciertas formas de ejercicio ligero.
Las calorías quemadas, aunque útiles, parecen incluir más factores (por ejemplo, metabolismo basal o actividades estáticas como yoga), 
lo que diluye su relación con el sedentarismo.



## Relación entre **Pasos totales y Minutos sedentarios**

![](imagenes/daily/RelaciónentrePasostotalesyMinutossedentarios.png)

Existe una relación negativa clara entre pasos totales y minutos sedentarios. Es decir, a medida que los pasos totales aumentan, los minutos
 sedentarios tienden a disminuir de forma más consistente. La línea de regresión muestra esta tendencia negativa.
El intervalo de confianza, sugiere que la relación observada es relativamente confiable en todo el rango.
Para valores altos de pasos totales (>15,000), los minutos sedentarios son generalmente bajos (<500), lo que indica que las personas más activas
 tienden a pasar menos tiempo en actividades sedentarias.
Hay algunas observaciones dispersas, como puntos con muchos pasos totales, pero minutos sedentarios moderados o puntos con pocos pasos y también
 pocos minutos sedentarios.
Este gráfico refuerza la idea de que un mayor nivel de actividad física (medido en pasos totales) está asociado con una reducción significativa 
en el tiempo sedentario.
La relación negativa es más fuerte que en el gráfico de calorías quemadas vs. minutos sedentarios, lo que sugiere que los pasos totales podrían 
ser un mejor indicador de actividad física que las calorías quemadas

El análisis del gráfico de calorías quemadas vs. minutos sedentarios muestra una relación débil, lo que indica que las calorías quemadas no siempre están directamente asociadas con una reducción significativa del tiempo sedentario. Por otro lado, en el gráfico de pasos totales vs. minutos sedentarios, la relación negativa es mucho más pronunciada. Esto sugiere que aumentar la cantidad de pasos tiene un impacto más directo en reducir el sedentarismo que simplemente enfocarse en quemar calorías.

Los pasos totales son una métrica más específica y confiable para evaluar la influencia de la actividad física en el tiempo sedentario. Mientras que las calorías quemadas pueden incluir factores como el metabolismo basal o actividades estáticas de bajo impacto (por ejemplo, yoga), los pasos se relacionan más estrechamente con el movimiento activo.

Además, las calorías quemadas pueden variar considerablemente debido a factores demográficos, genéticos o metabólicos, lo que las hace una medida más variable en comparación con los pasos totales. Aun así, ambas métricas son valiosas y complementarias para evaluar la actividad diaria, especialmente si se consideran actividades físicas que no necesariamente involucran caminar. Integrar ambas medidas puede ofrecer un análisis más completo y preciso del comportamiento sedentario y el impacto de la actividad física en la salud.






### SLEEP

## Tiempo de sueño por dia de la semana

```
ggplot(avg_sleep_per_day, aes(x = Weekday, y = AvgMinutesAsleep)) +
  geom_bar(stat = "identity", fill = "lightblue") +
  geom_text(aes(label = round(AvgMinutesAsleep, 0)), vjust = -0.3, size = 3) + 
  labs(title = "Promedio de minutos de sueño por día de la semana",
       x = "Día de la semana",
       y = "Minutos promedio de sueño") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](imagenes/daily/Sueño_por_dia_de_la_semana.png)

La diferencia entre los días laborales y fines de semana se ve muy marcada. Domingo es el día con más horas de sueño como cabria esperar
 de un día de descanso, seguido del sábado. Entre los días laborales, que se mantienen muy constantes, destaca el día miércoles, justo en 
 mitad de la semana.
Si bien hay diferencias entre los días, el promedio se mantiene constante, por lo que se podría decir que hay una buena higiene de sueño entre
 los usuarios. 


##  Calorias y pasos por hora del día

### CALORIES

**Promedio de calorías por hora:** 


![](imagenes/hourly/caloriasporhora.png)


El gasto calórico marcado por las horas de sueño es más bajo en las primeras horas del día (00:00 a 05:00) y aumenta progresivamente conforme 
avanza la mañana.
El rango de máximo gasto calórico ocurre entre las 11:00 y las 19:00 horas. De 17:00 a 19:00 horas destacan como las horas con mayor gasto 
energético,
 probablemente por qué marca el fin de la jornada laboral y los usuarios se enfocan en otras actividades que traen consigo una mayor activación
  física. 
A las 18:00 horas, el promedio alcanza 119.14 calorías/hora, lo que sugiere alta actividad física o metabólica durante esta hora.
A partir de las 19:00 horas, el gasto calórico comienza a descender gradualmente, alcanzando niveles bajos durante la noche.


* Puntos más altos:

Un primer pico en la mañana (alrededor de las 12:00).

Un segundo pico en la tarde (alrededor de las 18:00).


## STEPS

**Promedio de pasos por hora:**


![](imagenes/hourly/Pasosporhora.png)


Se observa un incremento significativo a partir de las 06:00 horas, alcanzando un rango de alta actividad entre 12:00 y 19:00 horas, con una 
baja a las 15:00 horas
Después de las 20:00 horas, los pasos comienzan a disminuir gradualmente, con una notable reducción hacia la noche.

* Primer pico máximo:

A las 12:00 horas, el promedio alcanza 534.3 pasos/hora, coincidiendo con alta actividad física o movimiento relacionado con tareas diarias.

* Segundo pico máximo:

A las 19:00 horas, el promedio alcanza 554.9 pasos/hora, indicando un segundo período de alta actividad, posiblemente por ejercicio vespertino 
o desplazamientos.



###  Comparación entre gráficos:

Ambos gráficos muestran patrones similares:

* Picos matutinos y vespertinos coinciden (alrededor de las 12:00 y 17:00-19:00 horas).
* Como cabe esperar el gasto calórico y el número de pasos disminuyen drasticamente durante la noche y la madrugada.
* Esto sugiere una fuerte correlación entre la cantidad de pasos realizados y el gasto calórico a lo largo del día.


###  Interpretación General

El patrón refleja que los usuarios tienen dos periodos principales de actividad: uno en la mañana y otro en la tarde-noche.
El comportamiento es coherente con rutinas diarias típicas:

* Mañana: inicio del día, desplazamientos, trabajo o ejercicio.

* Tarde-noche: segunda ola de movimiento, posiblemente ejercicio después del trabajo o actividades recreativas.





# 5. Conclusión


### Actividad Física: Moderada y Vigorosa

La mayoría de los usuarios cumple con la recomendación semanal de actividad física combinada de la OMS.
Aunque la mayoría de los usuarios supera las recomendaciones para actividad vigorosa, la actividad moderada no alcanza los niveles 
diarios sugeridos (21,3 a 42,8 minutos). 


### Relación entre Calorías Quemadas, Pasos Totales y Minutos Sedentarios 

Las calorías quemadas incluyen actividades sedentarias de bajo impacto, lo que podría explicar una correlación menos marcada con el tiempo 
sedentario. Este hallazgo destaca la necesidad de considerar indicadores más precisos para evaluar el nivel de actividad física como lo son los pasos.

Se identificó una relación negativa más fuerte entre los pasos totales y los minutos sedentarios en comparación con la relación entre calorías 
quemadas y minutos sedentarios. Esto sugiere que los pasos totales son un mejor indicador de actividad física que las calorías quemadas, 
ya que estas últimas pueden incluir factores como el metabolismo basal o actividades estáticas.


### Distribución de la Actividad Física por Hora del Día

El patrón de actividad refleja dos picos principales: uno matutino (alrededor de las 12:00) y otro vespertino (entre las 17:00 y 19:00 horas). 
Sin embargo, el sábado es el día con mayor actividad, lo que indica la necesidad de promover la distribución de la actividad física durante toda 
la semana.


### Patrón de Sueño por Día de la Semana

Los usuarios muestran diferencias claras en los patrones de sueño entre días laborales y fines de semana, siendo el domingo el día con más
 horas de sueño. Aunque en general hay buena higiene de sueño, hay que considerar que la muestra son solo 24 usuarios, por lo que hay que destacar que 
 algunos de ellos enfrentan dificultades para conciliar el sueño, particularmente durante los días laborales.


## Conclusión General

El análisis muestra la importancia de estrategias personalizadas para mejorar la actividad física y el sueño de los usuarios. Indicadores como 
los pasos totales y patrones diarios permiten identificar áreas de oportunidad y diseñar intervenciones efectivas. Al enfocar los esfuerzos en
 la distribución uniforme de la actividad física y la mejora de la calidad del sueño, la app de Bellabeat puede tener un impacto positivo 
 significativo en la salud y bienestar de sus usuarios.



# 6. Actuar

### Recomendaciones:

* Es crucial fomentar sesiones cortas y frecuentes distribuidas durante la semana para reducir la
concentración de actividad los sábados y promover una rutina más regular. Ademas de la importancia de estrategias
 que incentiven una mayor participación.

*  Crear notificaciones para motivar movimiento tras periodos prolongados de inactividad.

* Introducir mensajes de felicitaciones al alcanzar varias metas de pasos diarios, incentivando el alcanzarlas.

* Fomentar actividad consistente a traves de notificaciones a lo largo de los días laborales para evitar largas jornadas estaticas. 

### Recomendaciones de sueño:

Implementar notificaciones que sugieran horarios para ir a dormir, ayudando a reducir el tiempo en cama sin dormir antes de 
conciliar el sueño.
