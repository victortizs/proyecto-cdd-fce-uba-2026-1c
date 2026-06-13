library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggtext)
library(scales)

# -------------------------------------------------------------------------
rojo = "#F54927"
celeste = "#27D3F5"

theme_owid <- function(base_size = 13, base_family = "") {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      plot.title.position   = "plot",
      plot.caption.position = "plot",
      plot.title    = element_markdown(face = "bold", size = rel(1.35),
                                       colour = "#1d1d1d", lineheight = 1.2,
                                       margin = margin(b = 4)),
      plot.subtitle = element_markdown(size = rel(1.0), colour = "#5b5b5b",
                                       margin = margin(b = 16)),
      plot.caption  = element_markdown(hjust = 0, size = rel(0.72),
                                       colour = "#8a8a8a", margin = margin(t = 14)),
      axis.title    = element_blank(),         # OWID casi no usa titulos de eje
      axis.text     = element_text(colour = "#5b5b5b"),
      axis.ticks    = element_blank(),
      panel.grid.major.y = element_line(colour = "#e6e6e6", linewidth = 0.4),
      panel.grid.major.x = element_blank(),    # solo grilla horizontal
      panel.grid.minor   = element_blank(),
      legend.position    = "none",             # usamos etiquetas directas
      plot.margin = margin(t = 14, r = 110, b = 10, l = 16)  # der.: espacio etiquetas
    )
}

# -------------------------------------------------------------------------
df = read_csv(r"(input\inv_prev_y_real.csv)")
cuencas_relevantes = c("GOLFO SAN JORGE", "NEUQUINA")

df_plot = df |>
    filter(
        cuenca %in% cuencas_relevantes,
        tipo_explotacion %in% c(
            "Convencional",
            "No Convencional"
        ),
        millones_usd_explotacion_real > 0
    )

n_grupos =
    df_plot |>
    count(cuenca, tipo_explotacion)

titulo = sprintf(
  "La explotación no convencional de la cuenca <span style='color:%s'>**Neuquina**</span> concentra<br>las mayores inversiones en gas y petróleo",
  celeste
)

subtitulo = "Las observaciones parten de DDJJ registradas entre 2013–2025 con base en la Resolución<br>2057/2005."

colores <- c("Convencional" = rojo, "No Convencional" = celeste)

# -------------------------------------------------------------------------
ggplot(
    df_plot,
    aes(
        x = tipo_explotacion,
        y = millones_usd_explotacion_real,
        fill = tipo_explotacion
    )
) +
    geom_boxplot(
        varwidth = TRUE,
        alpha = 0.25,
        color = "#4d4d4d",
        linewidth = 0.6
    ) +
    stat_summary(
        fun = mean,
        geom = "point",
        shape = 23,
        size = 2.5,
        fill = "white",
        color = "#4d4d4d",
        stroke = 0.7
    ) +
    geom_text(
        data = n_grupos,
        aes(
            x = tipo_explotacion,
            y = Inf,
            label = paste0("n = ", n)
        ),
        size = 3,
        color = "#6e6e6e",
        vjust = 23.0,
        inherit.aes = FALSE
    ) +
    facet_wrap(~ cuenca) +
    scale_fill_manual(
        values = colores
    ) +
    scale_y_continuous(
        limits = c(0, NA),
        labels = label_number(
            suffix = " MM US$",
            big.mark = ".",
            decimal.mark = ","
        )
    ) +
    labs(
        title = titulo,
        subtitle = subtitulo,
        caption = paste(
            "**Nota:** La línea central representa la mediana,",
            "el rombo blanco la media y el ancho de cada caja",
            "es proporcional al tamaño muestral.<br>",
            "**Fuente:** Secretaría de Energía. Subsecretaría de Hidrocarburos."
        )
    ) +
    theme_owid() +
    theme(
        legend.title = element_blank()
    )

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# corroboración de valores de bigotes (valores próximos a límites inferior y superior)
# con los obtenidos en el script "exploratorio_inv.R"

# lo que debería ser:
boxplot.stats(
    df_plot |>
        filter(
            cuenca == "NEUQUINA", # cambiar por "Golfo San Jorge"
            tipo_explotacion == "No Convencional" # cambiar por "Convencional"
        ) |>
        pull(millones_usd_explotacion_real)
)$stats

# lo que es aplicando logaritmo de base 10:
boxplot.stats(
    log10(
        df_plot |>
            filter(
                cuenca == "NEUQUINA", # cambiar por "Golfo San Jorge"
                tipo_explotacion == "No Convencional" # cambiar por "Convencional"
            ) |>
            pull(millones_usd_explotacion_real)
    )
)$stats

# ------------------------------------------------------------------------------------------------------------------------------------------------------------