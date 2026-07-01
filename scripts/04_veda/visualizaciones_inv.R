library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggtext)
library(scales)

# -------------------------------------------------------------------------
# ejecuto las fuentes y los helpers necesarios
source(r"(utils\tema_owid.R)") # contiene función para editorializar gráficos símil a Our World in Data

celeste = "#27D3F5"
rojo = "#F54927"

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

# -------------------------------------------------------------------------
titulo = sprintf(
    paste0(
        "La explotación no convencional de la cuenca <span style='color:%s'>**Neuquina**</span> concentra las",
        "<br>",
        "mayores inversiones en gas y petróleo"
    ),
    celeste
)

subtitulo = "Las observaciones parten de DDJJ registradas entre 2013–2025 con base en la Resolución 2057/2005."
colores <- c("Convencional" = rojo, "No Convencional" = celeste)

# -------------------------------------------------------------------------
boxplots_inv_explot = ggplot(
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
        vjust = 27,
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
            "**Fuente:** Secretaría de Energía. Subsecretaría de Hidrocarburos"
        )
    ) +
    tema_owid() +
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
# guardar gráfico en output
ggsave(
    filename = "output/graficos/boxplots_inv_explot.png",
    plot = boxplots_inv_explot,
    width = 10,
    height = 6,
    units = "in",
    dpi = 600,
    bg = "white"
)
