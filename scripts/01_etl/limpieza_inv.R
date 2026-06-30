library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de raw file de inversiones previstas
df_1 = read_csv(r"(raw\resolucin-2057-inversiones-previstas-ao-actual.csv)")
glimpse(df_1)

# selección de variables relevantes y acotación de período
inv_prev_anio_actual = df_1 |>
    select(
        "Año de presentación de la DDJJ",
        "Empresa informante",
        "Cuenca",
        "Millones u$s Exploracion",
        "Millones u$s Explotacion",
        "Millones u$s Exp. Complementaria", # refiere principalmente a perforación de pozos exploratorios
        "Fecha Inicio Tareas",
        "Fecha Fin Tareas",
        "Tipo de explotación"
    ) |>
    filter(`Año de presentación de la DDJJ` < 2026)

dim(inv_prev_anio_actual) # 20317 filas, 9 columnas
glimpse(inv_prev_anio_actual)

# problema: tengo NA o 1900 como año en 'Fecha Inicio Tareas'
# necesito saber si puedo usar el año de presentación de la ddjj para reemplazar esos valores
# entonces, chequeo que el año de 'Fecha Inicio Tareas' coincida con el de ddjj en aquellas filas cuyo año en 'Fecha Inicio Tareas'
# sea distinto a 1900 para saber si es un buen proxy y no estoy reemplazando con algo que no suele cumplirse
temp_1 = inv_prev_anio_actual |>
    select("Año de presentación de la DDJJ", "Fecha Inicio Tareas") |>
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

# filtro filas con NA en 'inicio_tareas', en ellas reemplazar con el año de la ddjj es una fuerte opción por descarte
cant_na = temp_1 |>
    filter(is.na(inicio_tareas)) # igual a filtrar columna 'coincide_anio_ddjj_con_inicio_tareas' con la misma condición

# 9961 filas de 20317 originales tienen a 1900 como año en 'inicio_tareas', 49,03% del total original
cat(dim(cant_1900)[1], "filas tienen a 1900 como año.", "Representan", paste0(round(dim(cant_1900)[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original"))

# 1315 filas de 20317 originales contienen NA en 'inicio_tareas', 6,47% del total original
cat(dim(cant_na)[1], "filas contienen NA.", "Representan", paste0(round(dim(cant_na)[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original"))

# filtro filas con año distinto a 1900 en 'inicio_tareas' y distintas a NA
ni_1900_ni_na = temp_1 |>
    filter(
        check_anio_inicio_tareas != 1900,
        !is.na(check_anio_inicio_tareas)
    )

# 9033 filas de 20317 originales cumplen las condiciones y su año en 'inicio_tareas' coincide con el de la ddjj, 44,46% del total original
cat(
  dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1],
  "filas cumplen las condiciones y coincide su año.", "Representan",
  paste0(round(dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original")
)

# o 99,91% del total original, menos las filas con NA o 1900 como año en 'inicio_tareas' (se sobrentiende que esas no coinciden)
cat(
  dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1],
  "filas cumplen las condiciones y coincide su año.", "Representan",
  paste0(round(dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "sí"))[1]/(dim(inv_prev_anio_actual)[1]-dim(cant_1900)[1]-dim(cant_na)[1])*100, 2), "% del total original menos las filas con NA o 1900 como año en 'inicio_tareas'")
)

# 8 filas de 20317 originales cumplen las condiciones y su año en 'inicio_tareas' no coincide con el de la ddjj, 0,04% del total original
cat(
  dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1],
  "filas cumplen las condiciones y no coincide su año.", "Representan",
  paste0(round(dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1]/dim(inv_prev_anio_actual)[1]*100, 2), "% del total original")
)

# o 0,09% del total original menos las filas con NA o 1900 como año en 'inicio_tareas' (se sobrentiende que esas no coinciden)
cat(
  dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1],
  "filas cumplen las condiciones y no coincide su año.", "Representan",
  paste0(round(dim(filter(ni_1900_ni_na, coincide_anio_ddjj_con_inicio_tareas == "no"))[1]/(dim(inv_prev_anio_actual)[1]-dim(cant_1900)[1]-dim(cant_na)[1])*100, 2), "% del total original menos las filas con NA o 1900 como año en 'inicio_tareas'")
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de raw file de inversiones reales
df_2 = read_csv(r"(raw\resolucin-2057-inversiones-realizadas-ao-anterior.csv)")
glimpse(df_2) # tiene una columna más que 'df_1' (data frame de inversiones previstas): 'indice_tiempo'

# selección de variables relevantes y acotación de período
inv_anios_ant = df_2 |>
    select(
      "Año de presentación de la DDJJ",
      "Empresa informante",
      "Cuenca",
      "Millones u$s Exploracion",
      "Millones u$s Explotacion",
      "Millones u$s Exp. Complementaria", # refiere principalmente a perforación de pozos exploratorios
      "Tipo de explotación",
      "indice_tiempo"
    ) |>
    filter(`Año de presentación de la DDJJ` < 2026)

dim(inv_anios_ant) # 22832 filas, 8 columnas
glimpse(inv_anios_ant)

sort(unique(df_2$"Fecha Inicio Tareas"))
sort(unique(inv_anios_ant$"Año de presentación de la DDJJ"))
sort(unique(inv_anios_ant$"indice_tiempo"))

sum(is.na(df_2$"Fecha Inicio Tareas")) # 13602 filas con NA // df_2[is.na(df_2$"Fecha Inicio Tareas"), ] // por eso no considero esta variable para esta tabla
sum(is.na(inv_anios_ant$"Año de presentación de la DDJJ")) # 0 filas con NA // inv_anios_ant[is.na(inv_anios_ant$"Año de presentación de la DDJJ"), ]
sum(is.na(inv_anios_ant$"indice_tiempo")) # 0 filas con NA // inv_anios_ant[is.na(inv_anios_ant$"indice_tiempo"), ]

# compruebo si coincide el año de 'indice_tiempo' con el de la ddjj
temp_2 = inv_anios_ant |>
    select("Año de presentación de la DDJJ", "indice_tiempo") |>
    rename(anio_presentacion_ddjj = "Año de presentación de la DDJJ") |>
    mutate(
        "check_anio_indice_tiempo" = as.numeric(str_sub(indice_tiempo, 1, 4)),
        "coincide_anio_ddjj_con_indice_tiempo" = ifelse(check_anio_indice_tiempo == anio_presentacion_ddjj, "sí", "no")
    )

glimpse(temp_2)

sum(temp_2$coincide_anio_ddjj_con_indice_tiempo == "sí") # los años extraídos de la columna "indice_tiempo" coinciden con el de la ddjj
unique(temp_2$"coincide_anio_ddjj_con_indice_tiempo") # check
dim(filter(temp_2, coincide_anio_ddjj_con_indice_tiempo == "sí"))[1] # check doble

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# dudas:
# 1. ¿consideramos 'indice_tiempo' o año de ddjj en inversiones reales/anteriores? 
# 2. de tomar el año de las ddjj, ¿debemos considerar también su estado (variable categórica 'Estado de la DDJJ'
# de dos valores: abierta o cerrada)?
# 3. si consideramos 'Estado de la DDJJ', ¿filtramos por abierta o cerrada? o si no lo hacemos, ¿debemos aclararlo como nota?

# consideraciones:
# la variable 'indice_tiempo' tiene formato "yyyy-MM"
# , pero todos los meses son enero sin importar el año, por lo cual no parece relevante el mes.
# de igual modo, si continuamos con los años de las ddjj podría servirnos para comparar la suma anual real con la prevista
# , conformándonos con un análisis no tan granular/desagrupado como a nivel mensual para la inversión.

# respuestas (profe 2026-05-19):
# 1. Solo consideramos año de la ddjj
# 2. No
# 3. No es necesario

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# dado que "Millones u$s Exp. Complementaria" refiere principalmente a la perforación de
# pozos exploratorios, se agrupará con "Millones u$s Exploración" en una sola variable
cols = c("Millones u$s Exploracion", "Millones u$s Exp. Complementaria")

# filtro de inversiones previstas
filtro_inv_prev = inv_prev_anio_actual |>
  select(-"Fecha Inicio Tareas", -"Fecha Fin Tareas") |>
  mutate(
    millones_usd_exploracion_prev = rowSums(across(any_of(cols)), na.rm = TRUE)
    # alternativa explícita, pero menos escalable:
    # millones_usd_exploracion_prev = coalesce(.data[[cols[1]]], 0) + coalesce(.data[[cols[2]]], 0)
  ) |>
  rename(
  anio_presentacion_ddjj = "Año de presentación de la DDJJ",
  empresa = "Empresa informante",
  cuenca = "Cuenca",
  millones_usd_explotacion_prev = "Millones u$s Explotacion",
  tipo_explotacion = "Tipo de explotación"
  ) |>
  group_by(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion) |>
  summarise(
    "millones_usd_exploracion_prev" = sum(millones_usd_exploracion_prev, na.rm = TRUE),
    "millones_usd_explotacion_prev" = sum(millones_usd_explotacion_prev, na.rm = TRUE),
    .groups = "drop"
  )

glimpse(filtro_inv_prev)
dim(filter(filtro_inv_prev, millones_usd_exploracion_prev == 0 & millones_usd_explotacion_prev == 0))[1]
dim(filter(filtro_inv_prev, millones_usd_exploracion_prev > 0 | millones_usd_explotacion_prev > 0))[1]

# filtro de inversiones realizadas
filtro_inv_real = inv_anios_ant |>
  select(-"indice_tiempo") |>
  mutate(
    millones_usd_exploracion_real = rowSums(across(any_of(cols)), na.rm = TRUE)
    # alternativa explícita, pero menos escalable:
    # millones_usd_exploracion_real = coalesce(.data[[cols[1]]], 0) + coalesce(.data[[cols[2]]], 0)
  ) |>
  rename(
    anio_presentacion_ddjj = "Año de presentación de la DDJJ",
    empresa = "Empresa informante",
    cuenca = "Cuenca",
    millones_usd_explotacion_real = "Millones u$s Explotacion",
    tipo_explotacion = "Tipo de explotación"
  ) |>
  group_by(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion) |>
  summarise(
    "millones_usd_exploracion_real" = sum(millones_usd_exploracion_real, na.rm = TRUE),
    "millones_usd_explotacion_real" = sum(millones_usd_explotacion_real, na.rm = TRUE),
    .groups = "drop"
  )

glimpse(filtro_inv_real)
dim(filter(filtro_inv_real, millones_usd_exploracion_real == 0 & millones_usd_explotacion_real == 0))[1]
dim(filter(filtro_inv_real, millones_usd_exploracion_real > 0 | millones_usd_explotacion_real > 0))[1]

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# observaciones con match en ambas tablas
filtro_inv_prev |>
  inner_join(filtro_inv_real, by = c("anio_presentacion_ddjj", "cuenca", "empresa", "tipo_explotacion")) # 936 filas

# filas faltantes en inversiones anteriores
filtro_inv_prev |>
  anti_join(filtro_inv_real, by = c("anio_presentacion_ddjj", "cuenca", "empresa", "tipo_explotacion")) # 138 filas

# filas faltantes en inversiones previstas
filtro_inv_real |>
  anti_join(filtro_inv_prev, by = c("anio_presentacion_ddjj", "cuenca", "empresa", "tipo_explotacion")) # 98 filas

# unión de ambas tablas
inv_prev_y_real = filtro_inv_prev |>
  full_join(filtro_inv_real, by = c("anio_presentacion_ddjj", "cuenca", "empresa", "tipo_explotacion")) |> # 1172 filas = 936 + 138 + 98
  mutate(across(where(is.numeric), ~ replace_na(.x, 0))) |>
  relocate(millones_usd_exploracion_real, .after = "millones_usd_exploracion_prev")

# check final
glimpse(inv_prev_y_real)

# creación de csv con datasets combinados
write.csv(
  inv_prev_y_real,
  file = "input/inv_prev_y_real.csv",
  quote = TRUE, # importante porque algunos nombres de empresas incluyen "," y eso causa problemas en la lectura del csv
  row.names = FALSE,
  fileEncoding = "UTF-8"
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# dudas:
# 1. ¿deberíamos omitir las variables de inversión prevista y quedarnos solo con las reales (realizadas en año anterior)?
# ¿o vale la pena investigar un posible desvío y tendencias a sobreestimar o subestimar, a nivel cuenca o empresa?
# 2. ¿hacer un detalle en base a los comentarios de los datasets raw para separar exactamente los valores de exploración 
# y explotación, más allá del nombre de las variables, es posible y/o necesario? ¿y si hay filas sin comentarios/observaciones?
# 
# ------------------------------------------------------------------------------------------------------------------------------------------------------------
