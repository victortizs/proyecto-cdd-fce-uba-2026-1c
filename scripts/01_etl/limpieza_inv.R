library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# lectura de raw file de inversiones previstas
df_1 = read_csv(r"(raw\resolucin-2057-inversiones-previstas-ao-actual.csv)")
glimpse(df_1)

# selección de variables relevantes
inv_prev_anio_actual = df_1 |>
    select(
        "Año de presentación de la DDJJ",
        "Empresa informante",
        "Cuenca",
        "Millones u$s Exploracion",
        "Millones u$s Explotacion",
        "Tipo de explotación",
        "Fecha Inicio Tareas",
        "Fecha Fin Tareas"
    )
dim(inv_prev_anio_actual) # 21204 filas, 8 columnas
glimpse(inv_prev_anio_actual)

# problema: tengo NA o 1900 como año en 'Fecha Inicio Tareas'
# necesito saber si puedo usar el año de presentación de la ddjj para reemplazar esos valores
# entonces, chequeo que el año de 'Fecha Inicio Tareas' coincida con el de ddjj en aquellas filas cuyo año en 'Fecha Inicio Tareas'
# sea distinto a 1900 para saber si es un buen proxy y no estoy reemplazando con algo que no suele cumplirse
temp_1 = inv_prev_anio_actual |>
    select("Año de presentación de la DDJJ", "Fecha Inicio Tareas", "Fecha Fin Tareas") |>
    rename(
        anio_presentacion_ddjj = "Año de presentación de la DDJJ",
        inicio_tareas = "Fecha Inicio Tareas") |>
    mutate(
        "check_anio_inicio_tareas" = as.numeric(str_sub(inicio_tareas, 1, 4)),
        "coincide_anio_ddjj_con_inicio_tareas" = ifelse(check_anio_inicio_tareas == anio_presentacion_ddjj, "sí", "no")
    )
glimpse(temp_1)

# filtro filas con 1900 como año en 'inicio_tareas'
cant_1900 = temp_1 |>
    filter(check_anio_inicio_tareas == 1900)

# 10305 filas tienen como año en 'inicio_tareas' 1900, 48,6% del total original
cat(dim(cant_1900)[1], "filas tienen a 1900 como año.", "Representan", paste0(round(dim(cant_1900)[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original"))

# filtro filas con NA en 'inicio_tareas', en ellas reemplazar con el año de la ddjj es una fuerte opción, por descarte
cant_na = temp_1 |>
    filter(is.na(inicio_tareas)) # igual a filtrar columna 'coincide_anio_ddjj_con_inicio_tareas' con la misma condición

# 1417 filas de 21204 originales contienen NA en 'inicio_tareas', 6,68% del total original
cat(dim(cant_na)[1], "filas contienen NA.", "Representan", paste0(round(dim(cant_na)[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original"))

# filtro filas con año distinto a 1900 en 'inicio_tareas' y distintas a NA
no_1900_ni_na = temp_1 |>
    filter(
        check_anio_inicio_tareas != 1900,
        !is.na(check_anio_inicio_tareas)
    )

# 9474 filas de 21204 originales cumplen las condiciones y su año en 'inicio_tareas' coincide con el de la ddjj, 44,68% del total original
cat(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1],
"filas cumplen las condiciones y coincide su año.", "Representan",
paste0(round(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original"))

# o 99,92% del total original menos las filas con NA o 1900 como año en 'inicio_tareas' (se descarta que esas no coinciden)
cat(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1],
"filas cumplen las condiciones y coincide su año.", "Representan",
paste0(round(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1]/(dim(inv_prev_anio_actual)[1]-dim(cant_1900)[1]-dim(cant_na)[1])*100, 2), "% del total original menos las filas con NA o 1900 como año en 'inicio_tareas'"))

# 8 filas de 21204 originales cumplen las condiciones y su año en 'inicio_tareas' no coincide con el de la ddjj, 0,04% del total original
cat(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1],
"filas cumplen las condiciones y no coincide su año.", "Representan",
paste0(round(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original"))

# o 0,08% del total original menos las filas con NA o 1900 como año en 'inicio_tareas' (se descarta que esas no coinciden)
cat(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1],
"filas cumplen las condiciones y no coincide su año.", "Representan",
paste0(round(dim(filter(no_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1]/(dim(inv_prev_anio_actual)[1]-dim(cant_1900)[1]-dim(cant_na)[1])*100, 2), "% del total original menos las filas con NA o 1900 como año en 'inicio_tareas'"))

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

# lectura de raw file de inversiones reales
df_2 = read_csv(r"(raw\resolucin-2057-inversiones-realizadas-ao-anterior.csv)")
glimpse(df_2) # tiene una columna más que 'df_1' (data frame de inversiones previstas): 'indice_tiempo'

inv_anios_ant = df_2 |>
    select("Año de presentación de la DDJJ", "Empresa informante", "Cuenca", "Millones u$s Exploracion", "Millones u$s Explotacion", "Tipo de explotación", "indice_tiempo")
dim(inv_anios_ant) # 22832 filas, 7 columnas
glimpse(inv_anios_ant)

unique(df_2$"Fecha Inicio Tareas")
unique(inv_anios_ant$"Año de presentación de la DDJJ")
unique(inv_anios_ant$"indice_tiempo")

sum(is.na(df_2$"Fecha Inicio Tareas")) # 13602 filas con NA // df_2[is.na(df_2$"Fecha Inicio Tareas"), ] // por eso no considero esta variable para esta tabla
sum(is.na(inv_anios_ant$"Año de presentación de la DDJJ")) # 0 filas con NA // inv_anios_ant[is.na(inv_anios_ant$"Año de presentación de la DDJJ"), ]
sum(is.na(inv_anios_ant$"indice_tiempo")) # 0 filas con NA // inv_anios_ant[is.na(inv_anios_ant$"indice_tiempo"), ]

temp_2 = inv_anios_ant |>
    select("Año de presentación de la DDJJ", "indice_tiempo") |>
    rename(anio_presentacion_ddjj = "Año de presentación de la DDJJ") |>
    mutate(
        "check_anio_indice_tiempo" = as.numeric(str_sub(indice_tiempo, 1, 4)),
        "coincide_anio_ddjj_con_indice_tiempo" = ifelse(check_anio_indice_tiempo == anio_presentacion_ddjj, "sí", "no")
    )
glimpse(temp_2)
sum(temp_2$coincide_anio_ddjj_con_indice_tiempo == "sí") # todos los años extraídos de la columna "indice_tiempo" coinciden con el de la ddjj
unique(temp_2$"coincide_anio_ddjj_con_indice_tiempo") # check
dim(filter(temp_2, coincide_anio_ddjj_con_indice_tiempo == "sí"))[1] # check doble

# ------------------------------------------------------------------------------------------------------------------------------------------------------------

# dudas/consideraciones:
# 1. ¿consideramos indice_tiempo o año de ddjj en inversiones reales/anteriores? la variable 'indice_tiempo' tiene formato "yyyy-MM"
# , pero todos los meses son enero sin importar el año, por lo cual no parece relevante el mes
# ; sin embargo, el dato podría servir para comparar la suma anual real con la prevista
# 2. de tomar el año de las ddjj, ¿debemos considerar también su estado (variable categórica Estado de la DDJJ de dos valores: abierta o cerrada)?