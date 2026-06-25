library(readr)
library(dplyr)
library(tidyr)
library(tibble)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de input file de inversiones
df = read_csv(r"(input\inv_prev_y_real.csv)")
glimpse(df)
cuencas_relevantes = c("GOLFO SAN JORGE", "NEUQUINA")
sort(unique(df$empresa))

# estadísticos originales de exploración real según años y cuencas relevantes
explor_anios_y_cuencas = df |>
    filter(cuenca %in% cuencas_relevantes & millones_usd_exploracion_real > 0) |>
    group_by(anio_presentacion_ddjj, cuenca) |>
    summarise(
        n = n(),
        media = mean(millones_usd_exploracion_real),
        mediana = median(millones_usd_exploracion_real),
        min = min(millones_usd_exploracion_real),
        max = max(millones_usd_exploracion_real),
        rango = max(millones_usd_exploracion_real) - min(millones_usd_exploracion_real),
        desvio = sd(millones_usd_exploracion_real),
        varianza = var(millones_usd_exploracion_real),
        iqr = IQR(millones_usd_exploracion_real),
        cv = sd(millones_usd_exploracion_real) / mean(millones_usd_exploracion_real) * 100,
        total = n * media,
        .groups = "drop"
    ) |>
    relocate(total, .after = n)

print.data.frame(
    explor_anios_y_cuencas |>
    arrange(anio_presentacion_ddjj) # para verlo en orden cronológico, no se ordena por media
)

# estadísticos originales de exploración real según cuencas relevantes y tipo de explotación
explor_cuencas_y_tipo = df |>
    filter(cuenca %in% cuencas_relevantes & millones_usd_exploracion_real > 0) |>
    group_by(cuenca, tipo_explotacion) |>
    summarise(
        n = n(),
        media = mean(millones_usd_exploracion_real),
        mediana = median(millones_usd_exploracion_real),
        min = min(millones_usd_exploracion_real),
        max = max(millones_usd_exploracion_real),
        rango = max(millones_usd_exploracion_real) - min(millones_usd_exploracion_real),
        desvio = sd(millones_usd_exploracion_real),
        varianza = var(millones_usd_exploracion_real),
        iqr = IQR(millones_usd_exploracion_real),
        cv = sd(millones_usd_exploracion_real) / mean(millones_usd_exploracion_real) * 100,
        total = n * media,
        .groups = "drop"
    ) |>
    relocate(total, .after = n)

print.data.frame(
    explor_cuencas_y_tipo |>
    filter(tipo_explotacion %in% c("Convencional", "No Convencional")) |>
    arrange(desc(total))
)

# estadísticos originales de exploración real según empresa
explor_empresas = df |>
    filter(cuenca %in% cuencas_relevantes & millones_usd_exploracion_real > 0) |>
    group_by(empresa) |>
    summarise(
        n = n(),
        media = mean(millones_usd_exploracion_real),
        mediana = median(millones_usd_exploracion_real),
        min = min(millones_usd_exploracion_real),
        max = max(millones_usd_exploracion_real),
        rango = max(millones_usd_exploracion_real) - min(millones_usd_exploracion_real),
        desvio = sd(millones_usd_exploracion_real),
        varianza = var(millones_usd_exploracion_real),
        iqr = IQR(millones_usd_exploracion_real),
        cv = sd(millones_usd_exploracion_real) / mean(millones_usd_exploracion_real) * 100,
        total = n * media,
        .groups = "drop"
    ) |>
    relocate(total, .after = n)

head(
    explor_empresas, dim(explor_empresas)[1]) |>
    arrange(desc(total)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# estadísticos originales de explotación real según años y cuencas relevantes
explot_anios_y_cuencas = df |>
    filter(cuenca %in% cuencas_relevantes & millones_usd_explotacion_real > 0) |>
    group_by(anio_presentacion_ddjj, cuenca) |>
    summarise(
        n = n(),
        media = mean(millones_usd_explotacion_real),
        mediana = median(millones_usd_explotacion_real),
        min = min(millones_usd_explotacion_real),
        max = max(millones_usd_explotacion_real),
        rango = max(millones_usd_explotacion_real) - min(millones_usd_explotacion_real),
        desvio = sd(millones_usd_explotacion_real),
        varianza = var(millones_usd_explotacion_real),
        iqr = IQR(millones_usd_explotacion_real),
        cv = sd(millones_usd_explotacion_real) / mean(millones_usd_explotacion_real) * 100,
        total = n * media,
        .groups = "drop"
    ) |>
    relocate(total, .after = n)

print.data.frame(
    explot_anios_y_cuencas |>
    arrange(anio_presentacion_ddjj) # para verlo en orden cronológico, no se ordena por media
)

# estadísticos originales de explotación real según cuencas relevantes y tipo de explotación
explot_cuencas_y_tipo = df |>
    filter(cuenca %in% cuencas_relevantes & millones_usd_explotacion_real > 0) |>
    group_by(cuenca, tipo_explotacion) |>
    summarise(
        n = n(),
        media = mean(millones_usd_explotacion_real),
        mediana = median(millones_usd_explotacion_real),
        min = min(millones_usd_explotacion_real),
        max = max(millones_usd_explotacion_real),
        rango = max(millones_usd_explotacion_real) - min(millones_usd_explotacion_real),
        desvio = sd(millones_usd_explotacion_real),
        varianza = var(millones_usd_explotacion_real),
        iqr = IQR(millones_usd_explotacion_real),
        cv = sd(millones_usd_explotacion_real) / mean(millones_usd_explotacion_real) * 100,
        total = n * media,
        .groups = "drop"
    ) |>
    relocate(total, .after = n)

print.data.frame(
    explot_cuencas_y_tipo |>
    filter(tipo_explotacion %in% c("Convencional", "No Convencional")) |>
    arrange(desc(total))
)

# estadísticos originales de explotación real según empresa
explot_empresas = df |>
    filter(cuenca %in% cuencas_relevantes & millones_usd_explotacion_real > 0) |>
    group_by(empresa) |>
    summarise(
        n = n(),
        media = mean(millones_usd_explotacion_real),
        mediana = median(millones_usd_explotacion_real),
        min = min(millones_usd_explotacion_real),
        max = max(millones_usd_explotacion_real),
        rango = max(millones_usd_explotacion_real) - min(millones_usd_explotacion_real),
        desvio = sd(millones_usd_explotacion_real),
        varianza = var(millones_usd_explotacion_real),
        iqr = IQR(millones_usd_explotacion_real),
        cv = sd(millones_usd_explotacion_real) / mean(millones_usd_explotacion_real) * 100,
        total = n * media,
        .groups = "drop"
    ) |>
    relocate(total, .after = n)

head(
    explot_empresas, dim(explot_empresas)[1]) |>
    arrange(desc(total)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# en las líneas debajo se elige IQR por sobre z-score como método de detección de outliers dada las
# distribuciones asimétricas que presentan las variables "millones_usd_exploracion_real" y "millones_usd_explotacion_real"
# , con z-score se perdería sensibilidad. además, como se observa, las variables analizadas
# corresponden a los valores reales —anteriores (inversiones ya realizadas)— y no los previstos

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# inversión en exploración para explotación convencional en cuenca GSJ
gsj_explor_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE",
        tipo_explotacion == "Convencional",
        millones_usd_exploracion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_exploracion_real, 0.25),
    p50 = quantile(millones_usd_exploracion_real, 0.50),
    p75 = quantile(millones_usd_exploracion_real, 0.75),
    p90 = quantile(millones_usd_exploracion_real, 0.90),
    iqr = IQR(millones_usd_exploracion_real),
    .groups = "drop"
    )

head(gsj_explor_conv)
li_gsj_explor_conv = gsj_explor_conv$p25 - 1.5 * gsj_explor_conv$iqr
ls_gsj_explor_conv = gsj_explor_conv$p75 + 1.5 * gsj_explor_conv$iqr
cat("El límite inferior es", li_gsj_explor_conv, "y el superior", ls_gsj_explor_conv)

outliers_gsj_explor_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE" &
        tipo_explotacion == "Convencional" &
        (millones_usd_exploracion_real < li_gsj_explor_conv |
        millones_usd_exploracion_real > ls_gsj_explor_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_exploracion_real) |>
    arrange(desc(millones_usd_exploracion_real))

print.data.frame(outliers_gsj_explor_conv)

# inversión en exploración para explotación no convencional en cuenca GSJ
gsj_explor_no_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE",
        tipo_explotacion == "No Convencional",
        millones_usd_exploracion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_exploracion_real, 0.25),
    p50 = quantile(millones_usd_exploracion_real, 0.50),
    p75 = quantile(millones_usd_exploracion_real, 0.75),
    p90 = quantile(millones_usd_exploracion_real, 0.90),
    iqr = IQR(millones_usd_exploracion_real),
    .groups = "drop"
    )

head(gsj_explor_no_conv)
li_gsj_explor_no_conv = gsj_explor_no_conv$p25 - 1.5 * gsj_explor_no_conv$iqr
ls_gsj_explor_no_conv = gsj_explor_no_conv$p75 + 1.5 * gsj_explor_no_conv$iqr
cat("El límite inferior es", li_gsj_explor_no_conv, "y el superior", ls_gsj_explor_no_conv)

outliers_gsj_explor_no_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE" &
        tipo_explotacion == "No Convencional" &
        (millones_usd_exploracion_real < li_gsj_explor_no_conv |
        millones_usd_exploracion_real > ls_gsj_explor_no_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_exploracion_real) |>
    arrange(desc(millones_usd_exploracion_real))

print.data.frame(outliers_gsj_explor_no_conv)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# inversión en exploración para explotación convencional en cuenca NEU
neu_explor_conv = df |>
    filter(
        cuenca == "NEUQUINA",
        tipo_explotacion == "Convencional",
        millones_usd_exploracion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_exploracion_real, 0.25),
    p50 = quantile(millones_usd_exploracion_real, 0.50),
    p75 = quantile(millones_usd_exploracion_real, 0.75),
    p90 = quantile(millones_usd_exploracion_real, 0.90),
    iqr = IQR(millones_usd_exploracion_real),
    .groups = "drop"
    )

head(neu_explor_conv)
li_neu_explor_conv = neu_explor_conv$p25 - 1.5 * neu_explor_conv$iqr
ls_neu_explor_conv = neu_explor_conv$p75 + 1.5 * neu_explor_conv$iqr
cat("El límite inferior es", li_neu_explor_conv, "y el superior", ls_neu_explor_conv)

outliers_neu_explor_conv = df |>
    filter(
        cuenca == "NEUQUINA" &
        tipo_explotacion == "Convencional" &
        (millones_usd_exploracion_real < li_neu_explor_conv |
        millones_usd_exploracion_real > ls_neu_explor_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_exploracion_real) |>
    arrange(desc(millones_usd_exploracion_real))

print.data.frame(outliers_neu_explor_conv)

# inversión en exploración para explotación no convencional en cuenca NEU
neu_explor_no_conv = df |>
    filter(
        cuenca == "NEUQUINA",
        tipo_explotacion == "No Convencional",
        millones_usd_exploracion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_exploracion_real, 0.25),
    p50 = quantile(millones_usd_exploracion_real, 0.50),
    p75 = quantile(millones_usd_exploracion_real, 0.75),
    p90 = quantile(millones_usd_exploracion_real, 0.90),
    iqr = IQR(millones_usd_exploracion_real),
    .groups = "drop"
    )

head(neu_explor_no_conv)
li_neu_explor_no_conv = neu_explor_no_conv$p25 - 1.5 * neu_explor_no_conv$iqr
ls_neu_explor_no_conv = neu_explor_no_conv$p75 + 1.5 * neu_explor_no_conv$iqr
cat("El límite inferior es", li_neu_explor_no_conv, "y el superior", ls_neu_explor_no_conv)

outliers_neu_explor_no_conv = df |>
    filter(
        cuenca == "NEUQUINA" &
        tipo_explotacion == "No Convencional" &
        (millones_usd_exploracion_real < li_neu_explor_no_conv |
        millones_usd_exploracion_real > ls_neu_explor_no_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_exploracion_real) |>
    arrange(desc(millones_usd_exploracion_real))

print.data.frame(outliers_neu_explor_no_conv)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# inversión en explotación convencional en cuenca GSJ
gsj_explot_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE",
        tipo_explotacion == "Convencional",
        millones_usd_explotacion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_explotacion_real, 0.25),
    p50 = quantile(millones_usd_explotacion_real, 0.50),
    p75 = quantile(millones_usd_explotacion_real, 0.75),
    p90 = quantile(millones_usd_explotacion_real, 0.90),
    iqr = IQR(millones_usd_explotacion_real),
    .groups = "drop"
    )

head(gsj_explot_conv)
li_gsj_explot_conv = gsj_explot_conv$p25 - 1.5 * gsj_explot_conv$iqr
ls_gsj_explot_conv = gsj_explot_conv$p75 + 1.5 * gsj_explot_conv$iqr
cat("El límite inferior es", li_gsj_explot_conv, "y el superior", ls_gsj_explot_conv)

outliers_gsj_explot_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE" &
        tipo_explotacion == "Convencional" &
        (millones_usd_explotacion_real < li_gsj_explot_conv |
        millones_usd_explotacion_real > ls_gsj_explot_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_explotacion_real) |>
    arrange(desc(millones_usd_explotacion_real))

print.data.frame(outliers_gsj_explot_conv)

# inversión en explotación no convencional en cuenca GSJ
gsj_explot_no_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE",
        tipo_explotacion == "No Convencional",
        millones_usd_explotacion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_explotacion_real, 0.25),
    p50 = quantile(millones_usd_explotacion_real, 0.50),
    p75 = quantile(millones_usd_explotacion_real, 0.75),
    p90 = quantile(millones_usd_explotacion_real, 0.90),
    iqr = IQR(millones_usd_explotacion_real),
    .groups = "drop"
    )

head(gsj_explot_no_conv)
li_gsj_explot_no_conv = gsj_explot_no_conv$p25 - 1.5 * gsj_explot_no_conv$iqr
ls_gsj_explot_no_conv = gsj_explot_no_conv$p75 + 1.5 * gsj_explot_no_conv$iqr
cat("El límite inferior es", li_gsj_explot_no_conv, "y el superior", ls_gsj_explot_no_conv)

outliers_gsj_explot_no_conv = df |>
    filter(
        cuenca == "GOLFO SAN JORGE" &
        tipo_explotacion == "No Convencional" &
        (millones_usd_explotacion_real < li_gsj_explot_no_conv |
        millones_usd_explotacion_real > ls_gsj_explot_no_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_explotacion_real) |>
    arrange(desc(millones_usd_explotacion_real))

print.data.frame(outliers_gsj_explot_no_conv)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# inversión en explotación convencional en cuenca NEU
neu_explot_conv = df |>
    filter(
        cuenca == "NEUQUINA",
        tipo_explotacion == "Convencional",
        millones_usd_explotacion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_explotacion_real, 0.25),
    p50 = quantile(millones_usd_explotacion_real, 0.50),
    p75 = quantile(millones_usd_explotacion_real, 0.75),
    p90 = quantile(millones_usd_explotacion_real, 0.90),
    iqr = IQR(millones_usd_explotacion_real),
    .groups = "drop"
    )

head(neu_explot_conv)
li_neu_explot_conv = neu_explot_conv$p25 - 1.5 * neu_explot_conv$iqr
ls_neu_explot_conv = neu_explot_conv$p75 + 1.5 * neu_explot_conv$iqr
cat("El límite inferior es", li_neu_explot_conv, "y el superior", ls_neu_explot_conv)

outliers_neu_explot_conv = df |>
    filter(
        cuenca == "NEUQUINA" &
        tipo_explotacion == "Convencional" &
        (millones_usd_explotacion_real < li_neu_explot_conv |
        millones_usd_explotacion_real > ls_neu_explot_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_explotacion_real) |>
    arrange(desc(millones_usd_explotacion_real))

print.data.frame(outliers_neu_explot_conv)

# inversión en explotación no convencional en cuenca NEU
neu_explot_no_conv = df |>
    filter(
        cuenca == "NEUQUINA",
        tipo_explotacion == "No Convencional",
        millones_usd_explotacion_real > 0
    ) |>
    summarise(
    n = n(),
    p25 = quantile(millones_usd_explotacion_real, 0.25),
    p50 = quantile(millones_usd_explotacion_real, 0.50),
    p75 = quantile(millones_usd_explotacion_real, 0.75),
    p90 = quantile(millones_usd_explotacion_real, 0.90),
    iqr = IQR(millones_usd_explotacion_real),
    .groups = "drop"
    )

head(neu_explot_no_conv)
li_neu_explot_no_conv = neu_explot_no_conv$p25 - 1.5 * neu_explot_no_conv$iqr
ls_neu_explot_no_conv = neu_explot_no_conv$p75 + 1.5 * neu_explot_no_conv$iqr
cat("El límite inferior es", li_neu_explot_no_conv, "y el superior", ls_neu_explot_no_conv)

outliers_neu_explot_no_conv = df |>
    filter(
        cuenca == "NEUQUINA" &
        tipo_explotacion == "No Convencional" &
        (millones_usd_explotacion_real < li_neu_explot_no_conv |
        millones_usd_explotacion_real > ls_neu_explot_no_conv)
    ) |>
    select(anio_presentacion_ddjj, cuenca, empresa, tipo_explotacion, millones_usd_explotacion_real) |>
    arrange(desc(millones_usd_explotacion_real))

print.data.frame(outliers_neu_explot_no_conv)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# pregunta de criterio del profe: ¿son ERRORES o son DATOS REALES?
# respuesta: los outliers obtenidos son coherentes, pese a ser atípicos, por lo cual
# eliminarlos sería obviar datos reales y relacionados con eventos importantes

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# sintaxis alternativa:
# millones_usd_exploracion_real_vec = df |>
#     filter(cuenca %in% cuencas_relevantes & millones_usd_exploracion_real > 0) |>
#     pull(millones_usd_exploracion_real)

# q1 = quantile(millones_usd_exploracion_real_vec, 0.25)
# q3 = quantile(millones_usd_exploracion_real_vec, 0.75)
# iqr = q3 - q1 # igual a IQR(millones_usd_exploracion_real_vec)

# lim_inf_v2 = q1 - 1.5 * iqr
# lim_sup_v2 = q3 + 1.5 * iqr

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# resumen de outliers:
resumen_outliers = tibble(
    cuenca = c(
        "GOLFO SAN JORGE", "GOLFO SAN JORGE",
        "GOLFO SAN JORGE", "GOLFO SAN JORGE",
        "NEUQUINA", "NEUQUINA",
        "NEUQUINA", "NEUQUINA"
    ),
    tipo_inversion = c(
        "Exploración", "Exploración",
        "Explotación", "Explotación",
        "Exploración", "Exploración",
        "Explotación", "Explotación"
    ),
    tipo_explotacion = c(
        "Convencional", "No Convencional",
        "Convencional", "No Convencional",
        "Convencional", "No Convencional",
        "Convencional", "No Convencional"
    ),
    lim_inf = c(
        li_gsj_explor_conv,
        li_gsj_explor_no_conv,
        li_gsj_explot_conv,
        li_gsj_explot_no_conv,
        li_neu_explor_conv,
        li_neu_explor_no_conv,
        li_neu_explot_conv,
        li_neu_explot_no_conv
    ),
    lim_sup = c(
        ls_gsj_explor_conv,
        ls_gsj_explor_no_conv,
        ls_gsj_explot_conv,
        ls_gsj_explot_no_conv,
        ls_neu_explor_conv,
        ls_neu_explor_no_conv,
        ls_neu_explot_conv,
        ls_neu_explot_no_conv
    ),
    cant_outliers = c(
        nrow(outliers_gsj_explor_conv),
        nrow(outliers_gsj_explor_no_conv),
        nrow(outliers_gsj_explot_conv),
        nrow(outliers_gsj_explot_no_conv),
        nrow(outliers_neu_explor_conv),
        nrow(outliers_neu_explor_no_conv),
        nrow(outliers_neu_explot_conv),
        nrow(outliers_neu_explot_no_conv)
    )
)

print.data.frame(resumen_outliers)
