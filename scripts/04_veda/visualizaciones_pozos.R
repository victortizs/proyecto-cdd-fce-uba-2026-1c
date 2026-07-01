library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggrepel)
library(ggtext)
library(scales)

# -------------------------------------------------------------------------
# ejecuto las fuentes y los helpers necesarios
source(r"(scripts\03_tests\analisis_pozos.R)") # llamo a los índices para graficar
source(r"(utils\tema_owid.R)") # contiene función para editorializar gráficos símil a Our World in Data
source(r"(utils\graficar_indices.R)") # contiene función para graficar índices (usa la función contenida en tema_owid.R)

# la función para graficar los índices tiene la siguiente estructura:
# graficar_indices <- function(df, tipo, cuenca, colores)
# el argumento "df" hace referencia a una tabla con las siguientes cuatro columnas:
# fecha, original, desestacionalizada, tendencia
# el argumento "tipo" refiere al tipo de pozos: en perforación o terminados
# y es útil solo para el título del gráfico, al igual que el argumento "cuenca"
# por último, el argumento "colores" es un vector (paleta de colores) definido
# por el usuario

mis_colores <- c(
  "Serie original"           = "#B5B5B5",
  "Desestacionalizada (STL)" = "#406BC7",
  "Tendencia"                = "#222222"
)

# -------------------------------------------------------------------------
# generación y exportación de gráficos
# (uno por tipo de pozo y cuenca relevante)

g_perf_gsj = graficar_indices(
  ind_pozos_en_perf_gsj,
  "en perforación",
  "Golfo San Jorge",
  mis_colores
) |>
  ggsave(
    filename = "output/graficos/ind_pozos_en_perf_gsj.png",
    width = 10,
    height = 6,
    units = "in",
    dpi = 600,
    bg = "white"
  )


g_term_gsj = graficar_indices(
  ind_pozos_term_gsj,
  "terminados",
  "Golfo San Jorge",
  mis_colores
) |>
  ggsave(
    filename = "output/graficos/ind_pozos_term_gsj.png",
    width = 10,
    height = 6,
    units = "in",
    dpi = 600,
    bg = "white"
  )

g_perf_neu = graficar_indices(
  ind_pozos_en_perf_neu,
  "en perforación",
  "Neuquina",
  mis_colores
) |>
  ggsave(
    filename = "output/graficos/ind_pozos_en_perf_neu.png",
    width = 10,
    height = 6,
    units = "in",
    dpi = 600,
    bg = "white"
  )

g_term_neu = graficar_indices(
  ind_pozos_term_neu,
  "terminados",
  "Neuquina",
  mis_colores
) |>
  ggsave(
    filename = "output/graficos/ind_pozos_term_neu.png",
    width = 10,
    height = 6,
    units = "in",
    dpi = 600,
    bg = "white"
  )

# -------------------------------------------------------------------------
# # forma manual básica
# ind_pozos_en_perf_gsj |>
#   pivot_longer(
#     -fecha,
#     names_to = "serie",
#     values_to = "indice"
#   ) |>
#   ggplot(aes(fecha, indice, color = serie)) +
#   geom_line(linewidth = 0.7) +
#   labs(
#     title = "Índice de pozos en perforación",
#     x = NULL,
#     y = "Base = 100",
#     color = NULL
#   ) +
#   theme_minimal() +
#   tema_owid()
