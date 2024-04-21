###Preparación:

#Ajustes iniciales:
rm(list=ls())
options(scipen=999)

#Paquetes:
library(pacman)
pacman::p_load(haven,
               sjlabelled,
               dplyr, #Manipulacion de datos
               stargazer, #Tablas
               sjmisc, # Tablas
               summarytools, # Tablas
               kableExtra, #Tablas
               sjPlot, #Tablas y gráficos
               corrplot, # Correlaciones
               sessioninfo, # Información de la sesión de trabajo
               ggplot2) # Para la mayoría de los gráficos


#Base de datos:
##CASEN2022
datos_CASEN <- read_dta("Input/Base_CASEN2022/Base de datos Casen 2022 STATA_18 marzo 2024.dta")
View(datos_CASEN)
names(datos_CASEN)

###Base optimizada
load(file = "Input/DATA.RData")

#Filtramos datos, en este caso nos interesa trabajar con la 8va región.
datos_proc_8va <- datos_CASEN %>%
  filter(region==8)

View(datos_proc_8va)
##Guardaremos la base de datos procesada para optimizar almacenamiento.
save(datos_proc_8va,file = "input/datos_proc_8va.RData")

frq(datos_proc_8va)

#Seleccion de variables: Educación; Salud; Trabajo y seguridad social; Vivienda y entorno; Redes y cohesión social.
datos_proc <- datos_proc_8va %>%
  select(e6a_no_asiste, o9a, s13, y1, y3a_preg: y3f_preg, r7a: r7k, v2, v4 , v6, v12, p1:p4)

#Agrupamos y etiquetamos:
datos_proc$Ingresos <- (datos_proc$y1 + datos_proc$y3a_preg + datos_proc$y3b_preg + datos_proc$y3c_preg + datos_proc$y3d_preg + datos_proc$y3e_preg + datos_proc$y3f_preg)
datos_proc$Red_Apoyo <- (datos_proc$r7a + datos_proc$r7b + datos_proc$r7c + datos_proc$r7d + datos_proc$r7e + datos_proc$r7f + datos_proc$r7g + datos_proc$r7h + datos_proc$r7i + datos_proc$r7j + datos_proc$r7k)
datos_proc$Vivienda <- (datos_proc$v2  + datos_proc$v4 + datos_proc$v6 + datos_proc$v12 + datos_proc$p1 + datos_proc$p2 + datos_proc$p3 + datos_proc$p4) 
datos_proc$Educacion <- (datos_proc$e6a_no_asiste)
datos_proc$Trabajo <- (datos_proc$o9a)
datos_proc$Salud <- (datos_proc$s13)

#Seleccionamos las variables para los efectos del trabajo:
datos_proc <- datos_proc %>%
  select(Ingresos,Red_Apoyo,Vivienda, Educacion, Trabajo, Salud)

##Guardamos para optimizar espacio:
save(datos_proc,file = "input/DATA.RData")

View(datos_proc)
