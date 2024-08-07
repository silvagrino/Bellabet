



## Escenario

 Bellabeat es una empresa fundada en 2013, es una compañía pequeña de tecnologia enfocada en el bienestar para mujeres que ha crecido rápidamente. 

Dentro de sus productos destacan la App Bellabeat, Leaf, Time, Spring, y membresía Bellabeat.

Su Objetivo es Convertirse en una de las compañias más grande en el mercado global de dispositivos inteligentes.

La tarea del equipo: Analizar datos de dispositivos inteligentes para obtener información sobre el uso de estos dispositivos por parte de los consumidores y guiar la estrategia de marketing.

# 1. Tarea
Objetivo del negocio: Analizar datos de Fitbit para obtener información y guiar la estrategia de marketing para el crecimiento global de Bellabeat.

Estos datos seran presentados a los stakeholders principales Urška Sršen y Sando Mur, miembros del equipo ejecutivo y stakeholders secundarios conformados por el equipo de análisis de marketing de Bellabeat.

Se puede resumir la tarea por delante en 3 preguntas claves para desarrollar este analisis:
1.¿Cuáles son algunas tendencias en el uso de dispositivos inteligentes?
2.¿Cómo podrían aplicarse estas tendencias a los clientes de Bellabeat?
3.¿Cómo podrían estas tendencias influir en la estrategia de marketing de Bellabeat?

# 2. Preparar

Fuente de datos: Datos de 30 participantes del rastreador de fitness FitBit obtenidos desde Kaggle. https://www.kaggle.com/datasets/arashnic/fitbit

Constituido por 11 archivos para el primer mes, 18 para el segundo, abarcando un periodo total de 2 meses.

Contenido de los datos: 18 archivos CSV con datos de actividad física, frecuencia cardíaca y monitoreo del sueño minuto a minuto.

Para preparar los datos se aplicará un Enfoque ROCCC:

**R**eliable/Confiablilidad: Datos de 30 usuarios de FitBit que consintieron en la presentación de sus datos.

**O**riginal/Originalidad: Datos originales obtenidos directamente de los usuarios desde sus dispositivos inteligentes.

**C**omprehensive/Integralidad: Datos detallados y extensos pero con un tamaño de muestra pequeño e inconsistente, registrados en ciertos días de la semana. Sobre todo en el 1er mes, hay menos datos que en el 2do mes.

**C**urrent/Actuales: Datos de marzo a mayo de 2016.

**C**ited/Citación: No encontrado.


## El conjunto de datos ademas tiene limitaciones:

* El Tamaño de la muestra son solo 30 usuarios, lo cual es pequeño para un análisis conclusivo y robusto.

* Inconsistencia en distribución de datos en numero de usuarios; 33 usuarios para actividad diaria, 24 para sueño y 8 para peso, con algunas inconsistencias en el registro de datos.

* Método de registro del peso: 5 usuarios ingresaron manualmente su peso y 3 lo registraron a través de un dispositivo wifi.

* Fechas de registro inconsistente. La Mayoría de los datos estan registrados en el 2do mes, el primer mes no se puede considerar para hacer un analisis preciso con datos tan dispersos e inconsistentes. Ademas la mayoria de los registros son de martes a jueves, lo que podría no ser suficiente para un análisis preciso.


# 3. Process 

## DAILY

Hago analisis exploratorio inicial viendo numero de columnas y filas, filas distintas, buscando duplicados

Resumen general

Numeros Id's unicos por mes

Ejemplo de cita

>Este es un **fragmento con comillas**.
>El fragmento continúa aquí.
>Este es otro **fragmento con comillas**.
Este fragmento continúa en la siguiente línea.
Esta línea ya no está sangrada.


 `Coomo se ve esto?`

buscando duplicados, elimnando valores nulos

Puedo tambien calcular los minutos activos para ponerlos aqui, hacer una suma de columnas

LLEVAR A TABLEAU

porque no voy a ocupar el 1er dataset del primer mes, evidenciando que hay pocos datos :

Llevare a tableau las tablas para tener una mirada general a la cantidad de datos a traves de los 2 archivos

Promedio :
![](imagenes/1y2/promedio_daily_total_steps_1y2.png)

Suma total:
![](imagenes/1y2/suma_total_steps_1y2.png)

promedio de total steps por dia 

![](imagenes/daily/Promedio_activity_date_total_steps2.png)

Solo se ocupara el 2do mes por :
![](imagenes/daily/Data_recolectada_por_fecha.png)

# Imagen del grafico de piza y evidenciar el uso de R con su codigo.

# Imagenes de Tableau de otros 

![](imagenes/daily/R_minutos_de_nivel_de_actividad.png)

![](imagenes/daily/Sedentarismo_por_dias_de_la_semana.png)

![](imagenes/daily/Pasos_por_dias_de_la_semana.png)

![](imagenes/daily/Calorias_por_semana.png)





## HOURLY

dos dataset : calories y steps para analizar la cantidad de actividad y energia gastada en las diferentes horas del dia

convertir los dataset separando hora y fecha.

## EDITAR

calorias en un marco de 24 horas :
![](imagenes/hourly/calories_hourly.png)

Promedio de calorias dentro de 24 horas:
![](imagenes/hourly/promedio_calories_hourly.png)

Promedio de pasos dados en 24 horas:
![](imagenes/hourly/promedio_hourly_steps.png)

Total de pasos dados en 24 horas:
![](imagenes/hourly/step_total_hourly.png)

suma total de calorias por hora:
![](imagenes/hourly/suma_calories_hourly.png)

suma de pasos totales por hora:
![](imagenes/hourly/suma_steps_total_hourly.png)

## EDITAR 

