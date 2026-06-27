library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggtext)
library(scales)

# -------------------------------------------------------------------------
source(r"(utils\tema_owid.R)")
celeste = "#27D3F5"
rojo = "#F54927"

# -------------------------------------------------------------------------
df = read_csv(r"(input\prod_gas_y_petro.csv)")
cuencas_relevantes = c("GOLFO SAN JORGE", "NEUQUINA")

# check por las dudas
df[(is.na(df$cant_petro_m3)), ]

# principles productores de petróleo en las cuencas GSJ y NEU
ranking_empresas = df |>
    filter(
        cuenca %in% cuencas_relevantes
    ) |>
    group_by(empresa, tipo_explotacion) |>
    summarise(
        cant_petro_m3 = sum(cant_petro_m3),
        .groups = "drop"
    ) |>
    pivot_wider(
        names_from = tipo_explotacion,
        values_from = cant_petro_m3,
        names_prefix = "cant_petro_"
    ) |>
    rename(
        cant_petro_conv_m3 = "cant_petro_Convencional",
        cant_petro_no_conv_m3 = "cant_petro_No Convencional"
    ) |>
    mutate(
        across(where(is.numeric), ~ replace_na(.x, 0)),
        cant_petro_total_m3 = coalesce(cant_petro_conv_m3, 0) + coalesce(cant_petro_no_conv_m3, 0)
    ) |>
    arrange(desc(cant_petro_total_m3))

top_7_empresas = ranking_empresas[1:7,]

top_7_vf = top_7_empresas |>
    mutate(
        empresa = case_when(
            empresa %in% c(
                "PAN AMERICAN ENERGY (SUCURSAL ARGENTINA) LLC",
                "PAN AMERICAN ENERGY SL"
            ) ~ "PAE (SUCURSALES ARG)*",
            TRUE ~ empresa
        )
    )

print.data.frame(top_7_vf)
lista_top_7 = unique(top_7_vf$empresa)

df_plot = df |>
    mutate(
        empresa = case_when(
            empresa %in% c(
                "PAN AMERICAN ENERGY (SUCURSAL ARGENTINA) LLC",
                "PAN AMERICAN ENERGY SL"
            ) ~ "PAE (SUCURSALES ARG)*",
            TRUE ~ empresa
        )
    ) |>
    filter(
        cuenca %in% cuencas_relevantes,
        empresa %in% lista_top_7
    ) |>
    group_by(empresa, anio, tipo_explotacion) |>
    summarise(
        cant_petro_m3 = sum(cant_petro_m3),
        .groups = "drop"
    ) |>
    pivot_wider(
        names_from = tipo_explotacion,
        values_from = cant_petro_m3,
        names_prefix = "cant_petro_"
    ) |>
    rename(
        cant_petro_conv_m3 = "cant_petro_Convencional",
        cant_petro_no_conv_m3 = "cant_petro_No Convencional"
    ) |>
    mutate(
        across(where(is.numeric), ~ replace_na(.x, 0)),
        cant_petro_total_m3 = coalesce(cant_petro_conv_m3, 0) + coalesce(cant_petro_no_conv_m3, 0),
        across(matches("^cant_petro.*_m3$"), ~ .x / 1e6), # 1e6 = 1.000.000
        share_petro_no_conv = round(cant_petro_no_conv_m3 / cant_petro_total_m3 * 100, 2)
    ) |>
    rename_with(
        ~ sub("_m3$", "_mill_m3", .x),
        matches("^cant_petro.*_m3$")
    ) |>
    mutate(
        empresa = factor(
            empresa,
            levels = lista_top_7
        )
    ) |>
    arrange(empresa, anio)

print.data.frame(df_plot)

# -------------------------------------------------------------------------
titulo = sprintf(
  paste0(
    "La transición hacia el petróleo no convencional en las principales empresas",
    "<br>",
    "productoras"
    )
)

subtitulo = paste0(
    "Participación del petróleo no convencional sobre la producción total de petróleo (%).",
    "<br>",
    "Se observa una adopción heterogénea entre empresas durante el período analizado."
)

# colores <- c("Convencional" = rojo, "No Convencional" = celeste)

# -------------------------------------------------------------------------
share_no_conv_petro_empresa = ggplot(
    df_plot,
    aes(
        x = anio,
        y = share_petro_no_conv
    )
) +
    geom_area(
        fill = celeste,
        alpha = .35
    ) +
    geom_line(
        linewidth = 0.8,
        colour = celeste
    ) +
    geom_hline(
    yintercept = 0,
    linewidth = .3,
    colour = "grey70"
    ) +
    facet_wrap(
        ~ empresa,
        scales = "fixed",
        ncol = 3
    ) +
    scale_x_continuous(
    breaks = seq(2010, 2025, by = 5)
    ) +
    scale_y_continuous(
        limits = c(0, 100),
        breaks = seq(0, 100, 25),
        labels = label_percent(scale = 1)
    ) +
    labs(
    title = titulo,
    subtitle = subtitulo,
    caption = paste(
        "**Nota:** Se consolidaron las series de PAN AMERICAN ENERGY (SUCURSAL ARGENTINA) LLC y PAN AMERICAN ENERGY SL",
        "<br>",
        "en PAE (SUCURSALES ARG), para mostrar continuidad tras su cambio de denominación social.",
        "<br>",
        "**Fuente:** Secretaría de Energía. Subsecretaría de Hidrocarburos"
        )
    ) +
    theme_owid()

# -------------------------------------------------------------------------
# guardar gráfico en output
ggsave(
    filename = "output/graficos/share_no_conv_petro_empresa.png",
    plot = share_no_conv_petro_empresa,
    width = 10,
    height = 6,
    units = "in",
    dpi = 600,
    bg = "white"
)
