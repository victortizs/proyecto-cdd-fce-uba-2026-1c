getwd()

list.files()

list.files(recursive = TRUE)

datos <- read.csv("input/pozos_en_perf_y_term.csv")

names(datos)

head(datos)

str(datos)

library(dplyr)

indice_cuenca <- datos %>%
  group_by(anio, cuenca) %>%
  summarise(
    pozos = sum(cant_pozos_en_perf, na.rm = TRUE),
    .groups = "drop"
  )

indice_cuenca <- indice_cuenca %>%
  filter(cuenca %in% c("NEUQUINA", "GOLFO SAN JORGE"))


head(indice_cuenca)
unique(datos$cuenca)

indice_cuenca <- indice_cuenca %>%
  group_by(cuenca) %>%
  mutate(
    base2017 = pozos[anio == 2017],
    indice = pozos / base2017 * 100
  )
head(indice_cuenca)
View(indice_cuenca)

indice_cuenca %>%
  filter(anio == 2017)

library(ggplot2)

ggplot(
  indice_cuenca,
  aes(
    x = anio,
    y = indice,
    color = cuenca
  )
) +
  geom_line(linewidth = 1.2) +
  geom_point() +
  labs(
    title = "Índice de actividad de perforación por cuenca",
    subtitle = "Base 2017 = 100",
    x = "Año",
    y = "Índice",
    color = "Cuenca"
  ) +
  theme_minimal()

indice_cuenca %>%
  filter(anio >= 2017)

library(dplyr)

datos_test <- datos %>%
  filter(cuenca %in% c("NEUQUINA", "GOLFO SAN JORGE")) %>%
  mutate(
    periodo = ifelse(anio < 2017,
                     "Antes",
                     "Despues")
  )

datos_test %>%
  group_by(cuenca, periodo) %>%
  summarise(
    promedio = mean(cant_pozos_en_perf),
    .groups = "drop"
  )

