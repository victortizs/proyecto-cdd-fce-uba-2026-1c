library(readr)
library(dplyr)
library(tidyr)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de raw file de producción de gas
df_1 = read_csv(r"(raw\produccin-de-gas-por-yacimiento.csv)")
glimpse(df_1)
unique(df_1$concepto)

# selección de variables relevantes, acotación de período y transformación inicial
prod_gas_yacim = df_1 |>
    select(anio, mes, empresa, cuenca, concepto, cantidad) |>
    filter(anio < 2026 & concepto != "Equivalente calórico del gas (Kcal/m3)") |> # exclusión de indicador del contenido de energía, no indica volumen de producción y su unidad de medida es distinta
    mutate(
        categoria_flujo = case_when(
            concepto %in% c(
                "Gas de Alta Presión (Mm3)",
                "Gas de Media Presión (Mm3)",
                "Gas de Baja Presión (Mm3)"
            ) ~ "Producción Convencional",

            concepto == "Gas No Convencional (Mm3)" ~
            "Producción No Convencional",

            concepto %in% c(
                "Inyectado a Formación (Mm3)",
                "Inyección para Almacenamiento (Mm3)",
                "Extraído del almacenamiento (Mm3)"
            ) ~ "Operaciones / No Producción",

            TRUE ~ NA_character_
        ),
        tipo_explotacion = case_when(
            categoria_flujo == "Producción Convencional" ~
            "Convencional",

            categoria_flujo == "Producción No Convencional" ~
            "No Convencional",
            
            TRUE ~ NA_character_
        )
    ) |>
    relocate(cantidad, .after = last_col())

# check previo a filtro
glimpse(prod_gas_yacim)

# filtro de producción de gas
filtro_prod_gas = prod_gas_yacim |>
    filter( # equivalente a filter(!is.na(tipo_explotacion))
        categoria_flujo %in% c(
        "Producción Convencional",
        "Producción No Convencional"
        )
    ) |>
    group_by(anio, mes, cuenca, empresa, tipo_explotacion) |>
    summarise(
        cant_gas_Mm3 = sum(cantidad, na.rm = TRUE),
        .groups = "drop"
    )

# check de filtro
glimpse(filtro_prod_gas)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de raw file de producción de petróleo
df_2 = read_csv(r"(raw\produccin-de-petrleo-por-yacimiento.csv)")
glimpse(df_2)
unique(df_2$concepto)

# selección de variables relevantes, acotación de período y transformación inicial
prod_petro_yacim = df_2 |>
    select(anio, mes, empresa, cuenca, concepto, cantidad) |>
    filter(anio < 2026 & concepto != "Densidad Media (Ton/m3)") |> # exclusión de indicador físico, no indica volumen de producción y su unidad de medida es distinta
    mutate(
        categoria_flujo = case_when(
            concepto %in% c(
                "Producción Primaria (m3)",
                "Producción Secundaria (m3)",
                "Producción por Recuperación Asistida (m3)"
            ) ~ "Producción Convencional",

            concepto == "Producción No Convencional (m3)" ~
            "Producción No Convencional",

            concepto %in% c(
                "Producción de Condensado (m3)",
                "Producción de Gasolina Estabilizada (m3)"
            ) ~ "Coproductos / Líquidos Asociados",

            concepto %in% c(
                "Consumo en Yacimiento (m3)",
                "Producción de Agua (m3)",
                "Inyección de Agua (m3)"
            ) ~ "Operaciones / No Producción",

            TRUE ~ NA_character_
        ),
        tipo_explotacion = case_when(
            categoria_flujo == "Producción Convencional" ~
            "Convencional",

            categoria_flujo == "Producción No Convencional" ~
            "No Convencional",

            TRUE ~ NA_character_
        )
    ) |>
    relocate(cantidad, .after = last_col())

# check previo a filtro
glimpse(prod_petro_yacim)

# filtro de producción de petróleo
filtro_prod_petro = prod_petro_yacim |>
    filter( # equivalente a filter(!is.na(tipo_explotacion))
        categoria_flujo %in% c(
            "Producción Convencional",
            "Producción No Convencional"
        )
    ) |>
    group_by(anio, mes, cuenca, empresa, tipo_explotacion) |>
    summarise(
        cant_petro_m3 = sum(cantidad, na.rm = TRUE),
        .groups = "drop"
    )

# check de filtro
glimpse(filtro_prod_petro)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# observaciones con match en ambas tablas
filtro_prod_petro |>
    inner_join(filtro_prod_gas, by = c("anio", "mes", "cuenca", "empresa", "tipo_explotacion")) # 24388 filas

# filas faltantes en producción de gas
filtro_prod_petro |>
    anti_join(filtro_prod_gas, by = c("anio", "mes", "cuenca", "empresa", "tipo_explotacion")) # 394 filas

# filas faltantes en producción de petróleo
filtro_prod_gas |>
    anti_join(filtro_prod_petro, by = c("anio", "mes", "cuenca", "empresa", "tipo_explotacion")) # 74 filas

# unión de ambas tablas
prod_gas_y_pretro = filtro_prod_petro |>
    full_join(filtro_prod_gas, by = c("anio", "mes", "cuenca", "empresa", "tipo_explotacion")) |> # 24856 filas = 24388 + 394 + 74
    mutate(across(where(is.numeric), ~ replace_na(.x, 0))) |>
    relocate(cant_gas_Mm3, .before = cant_petro_m3)

# check final
glimpse(prod_gas_y_pretro)

# creación de csv con datasets combinados
write.csv(
  prod_gas_y_pretro,
  file = "input/prod_gas_y_petro.csv",
  quote = TRUE, # importante porque algunos nombres de empresas incluyen "," y eso causa problemas en la lectura del csv
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
