library(dplyr)

prod_gas_y_petro <- read.csv("C:/Users/ARIANA/OneDrive/Escritorio/GitHup/proyecto-cdd-fce-uba-2026-1c/input/prod_gas_y_petro.csv")


base_gas <- prod_gas_y_petro %>%
  filter(
    cuenca == "GOLFO SAN JORGE",
    anio %in% c(2009,2017,2025) & cant_gas_Mm3 > 0
  ) %>%
  group_by(anio) %>%
  summarise(
    n = n(),
    media = mean(cant_gas_Mm3, na.rm = TRUE),
    sd = sd(cant_gas_Mm3),
    mediana = median(cant_gas_Mm3),
    .groups = "drop"
  )
base_gas

base_petro <- prod_gas_y_petro %>%
  filter(cuenca == "GOLFO SAN JORGE",
         anio %in% c(2009,2017,2025) & cant_petro_m3 > 0
  ) %>%
  group_by(anio) %>%
  summarise(
    n = n(),
    media = mean(cant_petro_m3, na.rm = TRUE),
    sd = sd(cant_petro_m3),
    mediana = median(cant_petro_m3),
    .groups = "drop"
  )
base_petro

# 1. Agregar a nivel mensual
datos_mensuales <- prod_gas_y_petro %>%
  filter(
    cuenca == "GOLFO SAN JORGE",
    anio %in% c(2009, 2017, 2025)
  ) %>%
  group_by(anio, mes) %>%
  summarise(
    petro = sum(cant_petro_m3, na.rm = TRUE),
    gas   = sum(cant_gas_Mm3, na.rm = TRUE),
    .groups = "drop"
  )

# chequeo
datos_mensuales %>% count(anio)

# -------------------------
# TESTS PETRÓLEO
# -------------------------

# 1. 2009 vs 2017
t_petro_2009_vs_2017 <- t.test(petro ~ anio,
                    data = datos_mensuales %>% filter(anio %in% c(2009, 2017)))

# 2. 2017 vs 2025
t_petro_2017_vs_2025 <- t.test(petro ~ anio,
                    data = datos_mensuales %>% filter(anio %in% c(2017, 2025)))

# -------------------------
# TESTS GAS
# -------------------------

# 3. 2009 vs 2017
t_gas_2009_vs_2017 <- t.test(gas ~ anio,
                  data = datos_mensuales %>% filter(anio %in% c(2009, 2017)))

# 4. 2017 vs 2025
t_gas_2017_vs_2025 <- t.test(gas ~ anio,
                  data = datos_mensuales %>% filter(anio %in% c(2017, 2025)))

# -------------------------
# Mostrar resultados
# -------------------------

t_petro_2009_vs_2017
t_petro_2017_vs_2025
t_gas_2009_vs_2017
t_gas_2017_vs_2025


# ----------------------------------------

datos_gsj_y_neu <- prod_gas_y_petro %>%
  filter(
    cuenca %in% c("GOLFO SAN JORGE", "NEUQUINA"),
    anio == 2025) %>%
  group_by(cuenca, mes) %>%
  summarise(
    petro = sum(cant_petro_m3, na.rm = TRUE),
    gas   = sum(cant_gas_Mm3, na.rm = TRUE),
    .groups = "drop"
  )
datos_gsj_y_neu

#test (gsj 2025 vs neu 2025)

 #Gas

t_gas_gsj_vs_neu_2025 <- t.test(gas ~ cuenca,
                  data = datos_gsj_y_neu
)

 #Petro

t_petro_gsj_vs_neu_2025 <- t.test(petro ~ cuenca,
                    data = datos_gsj_y_neu
)


# Resultados

t_gas_gsj_vs_neu_2025
t_petro_gsj_vs_neu_2025










