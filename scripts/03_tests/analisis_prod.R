library(readr)
library(dplyr)
library(tidyr)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de input file de producción
df <- read_csv(r"(input\prod_gas_y_petro.csv)")
glimpse(df)

# foto descriptiva previa al test: gas
base_gas <- df |>
  filter(
    cuenca == "GOLFO SAN JORGE",
    anio %in% c(2009,2017,2025) & cant_gas_Mm3 > 0
  ) |>
  group_by(anio) |>
  summarise(
    n = n(),
    media = mean(cant_gas_Mm3, na.rm = TRUE),
    desvio = sd(cant_gas_Mm3),
    mediana = median(cant_gas_Mm3),
    .groups = "drop"
  )

base_gas

# foto descriptiva previa al test: petróleo
base_petro <- df |>
  filter(cuenca == "GOLFO SAN JORGE",
         anio %in% c(2009,2017,2025) & cant_petro_m3 > 0
  ) |>
  group_by(anio) |>
  summarise(
    n = n(),
    media = mean(cant_petro_m3, na.rm = TRUE),
    desvio = sd(cant_petro_m3),
    mediana = median(cant_petro_m3),
    .groups = "drop"
  )

base_petro

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# base para test de hipótesis principal
# (comparación del nivel de producción en la cuenca 
# GSJ en distintos momentos; agregación mensual)

datos_mensuales <- df |>
  filter(
    cuenca == "GOLFO SAN JORGE",
    anio %in% c(2009, 2017, 2025)
  ) |>
  group_by(anio, mes) |>
  summarise(
    petro = sum(cant_petro_m3, na.rm = TRUE),
    gas   = sum(cant_gas_Mm3, na.rm = TRUE),
    .groups = "drop"
  )

# chequeo
datos_mensuales |> count(anio)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# tests de Welch: gas

# 2009 vs 2017
t_gas_2009_vs_2017 <- t.test(gas ~ anio,
    data = datos_mensuales |> filter(anio %in% c(2009, 2017))
    )

# 2017 vs 2025
t_gas_2017_vs_2025 <- t.test(gas ~ anio,
    data = datos_mensuales |> filter(anio %in% c(2017, 2025))
    )

# tests de Welch: petróleo

# 2009 vs 2017
t_petro_2009_vs_2017 <- t.test(petro ~ anio,
    data = datos_mensuales |> filter(anio %in% c(2009, 2017))
)

# 2017 vs 2025
t_petro_2017_vs_2025 <- t.test(petro ~ anio,
    data = datos_mensuales |> filter(anio %in% c(2017, 2025))
)

# resultados
t_gas_2009_vs_2017
t_gas_2017_vs_2025
t_petro_2009_vs_2017
t_petro_2017_vs_2025

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# base para test de hipótesis complementaria 1
# (comparación de los niveles de producción en las
# cuencas GSJ y NEU en 2025; agregación mensual)

datos_gsj_y_neu <- df |>
  filter(
    cuenca %in% c("GOLFO SAN JORGE", "NEUQUINA"),
    anio == 2025
  ) |>
  group_by(cuenca, mes) |>
  summarise(
    petro = sum(cant_petro_m3, na.rm = TRUE),
    gas   = sum(cant_gas_Mm3, na.rm = TRUE),
    .groups = "drop"
  )

datos_gsj_y_neu

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# test de Welch: gas
t_gas_gsj_vs_neu_2025 <- t.test(gas ~ cuenca,
    data = datos_gsj_y_neu
)

# test de Welch: petróleo
t_petro_gsj_vs_neu_2025 <- t.test(petro ~ cuenca,
    data = datos_gsj_y_neu
)

# resultados
t_gas_gsj_vs_neu_2025
t_petro_gsj_vs_neu_2025

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# base para la hipótesis complementaria 2
# (composición de la producción en la cuenca NEU: convencional vs no convencional)

prod_neu <- df |>
    filter(cuenca == "NEUQUINA") |>
    group_by(anio, tipo_explotacion) |>
    summarise(
        cant_gas_Mm3 = sum(cant_gas_Mm3, na.rm = TRUE),
        cant_petro_m3 = sum(cant_petro_m3, na.rm = TRUE),
        .groups = "drop"
    ) |>
    pivot_wider(
        names_from = tipo_explotacion,
        values_from = c(cant_gas_Mm3, cant_petro_m3)
    ) |>
    rename(
        cant_gas_conv_Mm3 = "cant_gas_Mm3_Convencional",
        cant_gas_no_conv_Mm3 = "cant_gas_Mm3_No Convencional",
        cant_petro_conv_m3 = "cant_petro_m3_Convencional",
        cant_petro_no_conv_m3 = "cant_petro_m3_No Convencional",
    ) |>
    mutate(
        cant_gas_total_Mm3 = coalesce(cant_gas_conv_Mm3, 0) + coalesce(cant_gas_no_conv_Mm3, 0),
        cant_petro_total_m3 = coalesce(cant_petro_conv_m3, 0) + coalesce(cant_petro_no_conv_m3, 0),
        share_gas_no_conv = round(cant_gas_no_conv_Mm3 / cant_gas_total_Mm3 * 100, 2),
        share_petro_no_conv = round(cant_petro_no_conv_m3 / cant_petro_total_m3 * 100, 2),
        across(where(is.numeric), ~ replace_na(.x, 0))
    ) |>
    relocate(
        c(cant_gas_total_Mm3, share_gas_no_conv),
        .before = "cant_petro_conv_m3"
    )

prod_neu
