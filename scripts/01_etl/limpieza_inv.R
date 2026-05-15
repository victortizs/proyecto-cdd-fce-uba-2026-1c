library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# filtro de inversión prevista
df_1 = read_csv(r"(raw\resolucin-2057-inversiones-previstas-ao-actual.csv)")
glimpse(df_1)

inv_prev_anio_actual = df_1 |>
    select("Año de presentación de la DDJJ", "Empresa informante", "Cuenca", "Millones u$s Exploracion", "Millones u$s Explotacion", "Tipo de explotación", "Fecha Inicio Tareas", "Fecha Fin Tareas")

temp_1 = inv_prev_anio_actual |>
    select("Año de presentación de la DDJJ", "Fecha Inicio Tareas", "Fecha Fin Tareas") |>
    rename(
        anio_presentacion_ddjj = "Año de presentación de la DDJJ",
        inicio_tareas = "Fecha Inicio Tareas") |>
    mutate(
        "check_anio_inicio_tareas" = as.numeric(str_sub(inicio_tareas, 1, 4)),
        "coincide_anio_ddjj_con_inicio_tareas" = ifelse(check_anio_inicio_tareas == anio_presentacion_ddjj, "sí", "no")
    )

temp_2 = temp_1 |>
    filter_out(check_anio_inicio_tareas == 1900) |>
    filter(is.na(coincide_anio_ddjj_con_inicio_tareas)) # coincide_anio_ddjj_con_inicio_tareas == "sí" y coincide_anio_ddjj_con_inicio_tareas == "no" 

dim(temp_1)
head(temp_1)

dim(temp_2)
head(temp_2)

# 10899 no son de año 1900 en inicio de tareas (se descartan 10305 cuyo año en la fecha de inicio de tareas es 1900)
# de esas, 9474 coincide año de inicio de tareas con año de presentación de ddjj (87% de los datos)
# de esas, 8 no coincide año de inicio de tareas con año de presentación de ddjj
# de esas, 1417 no coincide año de inicio de tareas con año de presentación de ddjj (todas ellas porque no presentaron fecha de inicio de tareas, son NA)

# filtro de inversión real
df_2 = read_csv(r"(raw\resolucin-2057-inversiones-realizadas-ao-anterior.csv)")
glimpse(df_2)

inv_anios_ant = df_2 |>
    select("Año de presentación de la DDJJ", "Empresa informante", "Cuenca", "Millones u$s Exploracion", "Millones u$s Explotacion", "Tipo de explotación", "indice_tiempo")

# ¿consideramos indice_tiempo o año de ddjj en inversiones reales? si consideramos indice_tiempo tenemos además datos de meses
# , pero no así en el dataset de inversiones previstas. ¿chequeamos si coincide la mayoría como en inv. previstas o...?
# de tomar las ddjj, ¿debemos considerar su estado (abiertas o cerradas)?