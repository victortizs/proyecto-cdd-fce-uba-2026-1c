library(readr)
library(dplyr)
library(tidyr)

# filtro de pozos en perforación
df_1 = read_csv(r"(raw\pozos-en-perforacin.csv)")
glimpse(df_1)

pozos_en_perf = df_1 |>
    select(anio, mes, empresa, cuenca, concepto, cantidad) |>
    group_by(anio, mes, cuenca, empresa, concepto) |>
    summarise(
        cant_pozos_en_perf = sum(cantidad)
    ) |>
    filter(cant_pozos_en_perf > 0) # equivalente a filter(cant_pozos_en_perf != 0)

# filtro de pozos terminados
df_2 = read_csv(r"(raw\pozos-terminados.csv)")
glimpse(df_2)

pozos_term = df_2 |>
    select(anio, mes, empresa, cuenca, tipodepozoterminado, concepto, cantidad) |>
    rename(
        "concepto" = "tipodepozoterminado",
        "finalidad" = "concepto"
    ) |>
    filter(finalidad != "Improductivos" & finalidad != "Servicio") |>
    group_by(anio, mes, cuenca, empresa, concepto, finalidad) |>
    summarise(
        cantidad = sum(cantidad)
    ) |>
    pivot_wider(names_from = "finalidad", values_from = "cantidad", names_prefix = "cant_pozos_term_") |>
    rename(
        "cant_pozos_term_petroleo" = "cant_pozos_term_Productivos de Petróleo",
        "cant_pozos_term_gas" = "cant_pozos_term_Productivos de Gas"
    ) |>
    filter_out(cant_pozos_term_gas == 0 & cant_pozos_term_petroleo == 0)

# check
head(pozos_en_perf, 10)
dim(pozos_en_perf)
head(pozos_term, 10)
dim(pozos_term)

temp_1 = unique(pozos_en_perf$empresa)
temp_2 = unique(pozos_term$empresa)

glimpse(pozos_en_perf)
glimpse(pozos_term)

# observaciones con match en ambas tablas
pozos_term |> inner_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "concepto")) # 2383 filas

# filas faltantes en pozos terminados
pozos_en_perf |> anti_join(pozos_term, by = c("anio", "mes", "cuenca", "empresa", "concepto")) # 2002 filas

# filas faltantes en pozos en perforación
pozos_term |> anti_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "concepto")) # 1271 filas

# unión de ambas tablas
pozos_term_y_en_perf = pozos_term |>
    full_join(pozos_en_perf, by = c("anio", "mes", "cuenca", "empresa", "concepto")) |> # 5656 filas = 2383 + 2002 + 1271
    mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

# check final
glimpse(pozos_term_y_en_perf)

# creación de csv con datasets combinados
write.csv(
  pozos_term_y_en_perf,
  file = "input/pozos_term_y_en_perf.csv",
  quote = TRUE, # importante porque algunos nombres de empresas incluyen "," y eso causa problemas en la lectura del csv
  row.names = FALSE,
  fileEncoding = "UTF-8"
)
