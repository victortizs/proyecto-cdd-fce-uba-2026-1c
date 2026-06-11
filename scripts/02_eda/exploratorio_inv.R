library(readr)
library(dplyr)
library(tidyr)

# lectura de input file de inversiones
df = read_csv(r"(input\inv_prev_y_real.csv)")
glimpse(df)
sort(unique(df$empresa))

# estadísticos originales exploración real
exploracion = df |>
    filter(millones_usd_exploracion_real > 0) |>
    summarise(
        n = n(),
        media = mean(millones_usd_exploracion_real),
        mediana = median(millones_usd_exploracion_real),
        mín = min(millones_usd_exploracion_real),
        max = max(millones_usd_exploracion_real),
        varianza = var(millones_usd_exploracion_real),
        desvio   = sd(millones_usd_exploracion_real),
        rango    = max(millones_usd_exploracion_real) - min(millones_usd_exploracion_real),
        iqr      = IQR(millones_usd_exploracion_real),
        cv_pct   = sd(millones_usd_exploracion_real) / mean(millones_usd_exploracion_real) * 100      
    )

# se registra un potencial outlier (valor máximo)
print.data.frame(exploracion)

# para verificar dicho valor máximo se constata con valores previos
# , además, existe una posible explicación en el proyecto Argentina LNG
# (explotación de gas natural licuado en Vaca Muerta, en la costa de Río Negro principalmente), 
# iniciativa conjunta de YPF, ENI y ADNOC, cuyo brazo de inversiones XRG es el que rubricó el
# acuerdo previo al FID (Facilitación de las Inversiones para el Desarrollo).
# https://www.mejorenergia.com.ar/noticias/2025/11/04/4781-como-sigue-la-hoja-de-ruta-del-lng-argentina-tras-el-acuerdo-con-adnoc/

df[which.max(df$millones_usd_exploracion_real), ]
arg_lng = df |>
    filter(empresa %in% c("ENI ARGENTINA EXPLORACION Y EXPLOTACION S.A.", "YPF S.A.")) |>
    group_by(empresa, anio_presentacion_ddjj, cuenca) |>
    summarise(
        millones_usd_exploracion_prev = sum(millones_usd_exploracion_prev),
        millones_usd_exploracion_real = sum(millones_usd_exploracion_real),
        .groups = "drop"
    ) |>
    arrange(anio_presentacion_ddjj) |>
    mutate(across(c(millones_usd_exploracion_prev, millones_usd_exploracion_real),
        ~ formatC(.x, format="f", digits=4))
    )

# se descarta relación con el proyecto Argentina LNG y se halla probable relación
# con otro proyecto, en el cual YPF S.A. y Eni Uruguay Ltd. avanzan en la exploración offshore con un acuerdo clave en Uruguay.
# el área OFF-5 se extiende sobre aproximadamente 17.000 km² y se ubica a 200 kilómetros de la costa uruguaya
# , con profundidades marinas que alcanzan los 4.100 metros. quizá esto explique la inversión, de la filial argentina de ENI,
#  en la exploración de un área próxima. de todos modos, los valores son incoherentes.
# https://www.mejorenergia.com.ar/noticias/2025/11/25/4859-ypf-y-eni-avanzan-en-la-exploracion-offshore-con-un-acuerdo-clave-en-uruguay
print(as.data.frame(arg_lng))



# ------------------------------------------------------------------------------------------------------------------------------------------------------------

# estadísticos originales explotación real
explotacion = df |>
    filter(millones_usd_explotacion_real > 0) |>
    summarise(
        n = n(),
        media = mean(millones_usd_explotacion_real),
        mediana = median(millones_usd_explotacion_real),
        mín = min(millones_usd_explotacion_real),
        max = max(millones_usd_explotacion_real),
        varianza = var(millones_usd_explotacion_real),
        desvio   = sd(millones_usd_explotacion_real),
        rango    = max(millones_usd_explotacion_real) - min(millones_usd_explotacion_real),
        iqr      = IQR(millones_usd_explotacion_real),
        cv_pct   = sd(millones_usd_explotacion_real) / mean(millones_usd_explotacion_real) * 100        
    )

# se registra un potencial outlier (valor mínimo)
print.data.frame(explotacion)

# filtramos/verificamos dicho valor mínimo y observamos que se debe a un monto próximo a cero
df[which.min(df$millones_usd_explotacion_real), ]
df |>
    filter(empresa == "EPSUR S.A.") |>
    group_by(empresa, anio_presentacion_ddjj) |>
    summarise(
        millones_usd_explotacion_prev = sum(millones_usd_explotacion_prev),
        millones_usd_explotacion_real = sum(millones_usd_explotacion_real),
        .groups = "drop"
    )
