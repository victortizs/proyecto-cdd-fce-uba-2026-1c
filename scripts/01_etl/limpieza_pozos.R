library(readr)
library(dplyr)
library(tidyr)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de raw file de pozos en perforación
df_1 = read_csv(r"(raw\pozos-en-perforacin.csv)")
glimpse(df_1)

# filtro de pozos en perforación
pozos_en_perf = df_1 |>
    select(anio, mes, empresa, cuenca, concepto, cantidad) |>
    group_by(anio, mes, cuenca, empresa, concepto) |>
    summarise(
        cant_pozos_en_perf = sum(cantidad, na.rm = TRUE),
        .groups = "drop"
    ) |>
    filter(anio < 2026 & cant_pozos_en_perf > 0) |>
    rename(tipo_actividad = concepto)

glimpse(pozos_en_perf)
dim(pozos_en_perf)
head(pozos_en_perf, 10)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de raw file de pozos terminados
df_2 = read_csv(r"(raw\pozos-terminados.csv)")
glimpse(df_2)

# filtro de pozos terminados
pozos_term = df_2 |>
    select(anio, mes, empresa, cuenca, tipodepozoterminado, concepto, cantidad) |>
    rename(
        "concepto" = "tipodepozoterminado",
        "finalidad" = "concepto"
    ) |>
    filter(anio < 2026 & !(finalidad %in% c("Improductivos", "Servicio"))) |>
    group_by(anio, mes, cuenca, empresa, concepto, finalidad) |>
    summarise(
        cantidad = sum(cantidad, na.rm = TRUE),
        .groups = "drop"
    ) |>
    pivot_wider(names_from = "finalidad", values_from = "cantidad", names_prefix = "cant_pozos_term_") |>
    rename(
        "tipo_actividad" = "concepto",
        "cant_pozos_term_petro" = "cant_pozos_term_Productivos de Petróleo",
        "cant_pozos_term_gas" = "cant_pozos_term_Productivos de Gas"
    ) |>
    filter(cant_pozos_term_gas > 0 | cant_pozos_term_petro > 0)

glimpse(pozos_term)
dim(pozos_term)
head(pozos_term, 10)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# observaciones con match en ambas tablas
pozos_term |>
    inner_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "tipo_actividad")) # 2382 filas

# filas faltantes en pozos en perforación
pozos_term |>
    anti_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "tipo_actividad")) # 1257 filas

# filas faltantes en pozos terminados
pozos_en_perf |>
    anti_join(pozos_term, by = c("anio", "mes", "cuenca", "empresa", "tipo_actividad")) # 2002 filas

# unión de ambas tablas
pozos_en_perf_y_term = pozos_term |>
    full_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "tipo_actividad")) |> # 5641 filas = 2382 + 1257 + 2002
    filter(tipo_actividad %in% c("Exploración", "Explotación")) |> # 4385 filas = 5641 - 1256 // 1256 son las filas con otro tipo de actividad
    mutate(across(where(is.numeric), ~ replace_na(.x, 0))) |>
    relocate(cant_pozos_en_perf, .after = tipo_actividad)

# check de 1256 de filas con "Avanzada" o "Servicio" en "tipo_actividad"
dim(pozos_term |>
    full_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "tipo_actividad")) |>
    filter(tipo_actividad %in% c("Avanzada", "Servicio"))
)[1]

# check final
glimpse(pozos_en_perf_y_term)

# creación de csv con datasets combinados
write.csv(
  pozos_en_perf_y_term,
  file = "input/pozos_en_perf_y_term.csv",
  quote = TRUE, # importante porque algunos nombres de empresas incluyen "," y eso causa problemas en la lectura del csv
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
