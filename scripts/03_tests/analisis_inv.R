library(readr)
library(dplyr)
library(tidyr)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de input file de inversión
df <- read_csv(r"(input\inv_prev_y_real.csv)")
glimpse(df)

# base para la hipótesis complementaria 2
# (composición de la inversión en la cuenca NEU: convencional vs no convencional)

inv_neu <- df |>
    filter(
        cuenca == "NEUQUINA",
        tipo_explotacion %in% c("Convencional", "No Convencional")
    ) |>
    group_by(anio_presentacion_ddjj, tipo_explotacion) |>
    summarise(
        millones_usd_explor_real = sum(millones_usd_exploracion_real, na.rm = TRUE),
        millones_usd_explot_real = sum(millones_usd_explotacion_real, na.rm = TRUE),
        .groups = "drop"
    ) |>
    pivot_wider(
        names_from = tipo_explotacion,
        values_from = c(millones_usd_explor_real, millones_usd_explot_real)
    ) |>
    rename(
        millones_usd_explor_real_conv = "millones_usd_explor_real_Convencional",
        millones_usd_explor_real_no_conv = "millones_usd_explor_real_No Convencional",
        millones_usd_explot_real_conv = "millones_usd_explot_real_Convencional",
        millones_usd_explot_real_no_conv = "millones_usd_explot_real_No Convencional",
    ) |>
    mutate(
        millones_usd_explor_real_total = coalesce(millones_usd_explor_real_conv, 0) + coalesce(millones_usd_explor_real_no_conv, 0),
        millones_usd_explot_real_total = coalesce(millones_usd_explot_real_conv, 0) + coalesce(millones_usd_explot_real_no_conv, 0),
        share_explor_no_conv = round(millones_usd_explor_real_no_conv / millones_usd_explor_real_total * 100, 2),
        share_explot_no_conv = round(millones_usd_explot_real_no_conv / millones_usd_explot_real_total * 100, 2)
    ) |>
    select(-millones_usd_explor_real_conv, -millones_usd_explot_real_conv) |>
    relocate(
        c(millones_usd_explor_real_total, share_explor_no_conv),
        .before = "millones_usd_explot_real_no_conv"
    )

inv_neu
