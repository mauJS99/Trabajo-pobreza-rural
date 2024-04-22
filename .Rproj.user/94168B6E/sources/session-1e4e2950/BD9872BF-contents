###Preparación:

# 0.Ajustes iniciales:
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


# 1.Base de datos:
##CASEN2022
datos_CASEN <- read_dta("Input/Base_CASEN2022/Base de datos Casen 2022 STATA_18 marzo 2024.dta")
View(datos_CASEN)
names(datos_CASEN)

###Base optimizada, no requiere de procesamiento, por ende se salta el paso 2 completo.
load(file = "Input/DATA.RData")

# 2.1 Recodificación: filtramos datos, en este caso nos interesa trabajar con la 8va región.
datos_proc_8va <- datos_CASEN %>%
  filter(region==8)

View(datos_proc_8va)
##Guardaremos la base de datos procesada para optimizar almacenamiento.
save(datos_proc_8va,file = "input/datos_proc_8va.RData")

frq(datos_proc_8va)

# 2.2 Seleccion de variables: Educación; Salud; Trabajo y seguridad social; Vivienda y entorno; Redes y cohesión social.
datos_proc <- datos_proc_8va %>%
  select(e6a_no_asiste, o9a, s13, y1, y3a_preg: y3f_preg, r7a: r7k, v2, v4 , v6, v12, p1:p4)

# 2.3 Agrupamos
datos_proc$Ingresos <- (datos_proc$y1 + datos_proc$y3a_preg + datos_proc$y3b_preg + datos_proc$y3c_preg + datos_proc$y3d_preg + datos_proc$y3e_preg + datos_proc$y3f_preg)
datos_proc$Red_Apoyo <- (datos_proc$r7a + datos_proc$r7b + datos_proc$r7c + datos_proc$r7d + datos_proc$r7e + datos_proc$r7f + datos_proc$r7g + datos_proc$r7h + datos_proc$r7i + datos_proc$r7j + datos_proc$r7k)
datos_proc$Vivienda <- (datos_proc$v2  + datos_proc$v4 + datos_proc$v6 + datos_proc$v12 + datos_proc$p1 + datos_proc$p2 + datos_proc$p3 + datos_proc$p4) 
datos_proc$Educacion <- (datos_proc$e6a_no_asiste)
datos_proc$Trabajo <- (datos_proc$o9a)
datos_proc$Salud <- (datos_proc$s13)

# 2.4 Seleccionamos las variables para los efectos del trabajo:
datos_proc <- datos_proc %>%
  select(Ingresos,Red_Apoyo,Vivienda, Educacion, Trabajo, Salud)

# 2.5 Guardamos para optimizar espacio:
save(datos_proc,file = "input/DATA.RData")

View(datos_proc)

class(datos_proc$Ingresos)
class(datos_proc$Red_Apoyo)
class(datos_proc$Vivienda)
class(datos_proc$Educacion)
class(datos_proc$Trabajo)
class(datos_proc$Salud)

#3.Exploramos las variables:
frq(datos_proc$Ingresos)
frq(datos_proc$Educacion)
frq(datos_proc$Red_Apoyo)
frq(datos_proc$Vivienda)
frq(datos_proc$Trabajo)
frq(datos_proc$Salud)

dim(datos_proc)
sjmisc::descr(datos_proc)

# 3.1 Tratamos los casos perdidos

sum(is.na(datos_proc))
datos_proc <-na.omit(datos_proc)

## 3.2 Tabla descriptiva.
summarytools::dfSummary(datos_proc, plain.ascii = FALSE)
view(dfSummary(datos_proc, headings=FALSE))

## 3.3 Gráficos de las Variables:
graf_Ing <- ggplot(datos_proc, aes(x = Ingresos)) +
  geom_bar(fill = "coral") + 
  labs (title = "Ingresos totales")
graf_Apoyo <- ggplot(datos_proc, aes(x = Red_Apoyo))+
  geom_bar(fill = "coral") +
  labs (title = "Red de apoyo")
graf_Viv <- ggplot(datos_proc, aes(x = Vivienda))+
  geom_bar(fill = "coral") +
  labs(title = "Estado vivienda")
graf_Educ <- ggplot(datos_proc, aes(x = Educacion))+
  geom_bar(fill = "coral") +
  labs(title = "Nivel educativo")
graf_Salud <- ggplot(datos_proc, aes(x = Salud))+
  geom_bar(fill = "coral") +
  labs(title = "Sistema de salud",
       x = "Sistema de salud al que pertenece",
       y = "Frecuencia")+
  theme_bw()
graf_Trabajo <- ggplot(datos_proc, aes(x = Trabajo))+
  geom_bar(fill = "coral") +
  labs(title = "Oficio u ocupación")

ggsave(graf_Ing, file="output/graf_Ing.png")
ggsave(graf_Apoyo, file="output/graf_Apoyo.png")
ggsave(graf_Viv, file="output/graf_Viv.png")
ggsave(graf_Educ, file="output/graf_Educ.png")
ggsave(graf_Salud, file="output/graf_Salud.png")
ggsave(graf_Trabajo, file="output/graf_Trabajo.png")
