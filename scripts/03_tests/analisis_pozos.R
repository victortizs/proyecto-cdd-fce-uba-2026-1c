library(readr)
library(dplyr)
library(tidyr)
library(lubridate)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# lectura de input file de pozos en perforación y terminados
pozos <- read_csv(r"(input\pozos_en_perf_y_term.csv)")
glimpse(pozos)
cuencas_relevantes = c("GOLFO SAN JORGE", "NEUQUINA")

# check rápido de cantidades anuales
# (2016 aparece como un quiebre ratificado en 2017)

print.data.frame(pozos |>
    filter(cuenca %in% c(cuencas_relevantes)) |>
    group_by(cuenca, anio) |>
    summarise(
        cant_pozos_en_perf = sum(cant_pozos_en_perf),
        cant_pozos_term = sum(cant_pozos_term_gas + cant_pozos_term_petro),
        .groups = "drop"
    ) |>
    arrange(anio)
)

# check rápido de cantidades mensuales
print.data.frame(pozos |>
    filter(cuenca %in% c(cuencas_relevantes)) |>
    group_by(cuenca, mes) |>
    summarise(
        cant_pozos_en_perf = sum(cant_pozos_en_perf),
        cant_pozos_term = sum(cant_pozos_term_gas + cant_pozos_term_petro),
        .groups = "drop"
    ) |>
    arrange(mes)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# dataframe para construcción de índices
pozos_mensual <- pozos |>
    filter(cuenca %in% c(cuencas_relevantes)) |>
    group_by(cuenca, anio, mes) |>
    summarise(
        cant_pozos_en_perf = sum(cant_pozos_en_perf),
        cant_pozos_term = sum(cant_pozos_term_gas + cant_pozos_term_petro),
        .groups = "drop"
    ) |>
    mutate(
        fecha = make_date(anio, mes, 1)
    ) |>
    arrange(fecha) |>
    select(-(c(anio, mes))) |>
    relocate(fecha, .before = "cuenca")

print.data.frame(pozos_mensual)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# base de pozos en perforación en cuenca GSJ (promedio anual 2016)
base_2016_pozos_en_perf_gsj = mean(pozos_mensual |>
    filter(
        cuenca == "GOLFO SAN JORGE",
        year(fecha) == 2016
    ) |>
    pull(cant_pozos_en_perf)
)

base_2016_pozos_en_perf_gsj

# base de pozos terminados en cuenca GSJ (promedio anual 2016)
base_2016_pozos_term_gsj = mean(pozos_mensual |>
    filter(
        cuenca == "GOLFO SAN JORGE",
        year(fecha) == 2016
    ) |>
    pull(cant_pozos_term)
)

base_2016_pozos_term_gsj

# base de pozos en perforación en cuenca NEU (promedio anual 2016)
base_2016_pozos_en_perf_neu = mean(pozos_mensual |>
    filter(
        cuenca == "NEUQUINA",
        year(fecha) == 2016
    ) |>
    pull(cant_pozos_en_perf)
)

base_2016_pozos_en_perf_neu

# base de pozos terminados en cuenca NEU (promedio anual 2016)
base_2016_pozos_term_neu = mean(pozos_mensual |>
    filter(
        cuenca == "NEUQUINA",
        year(fecha) == 2016
    ) |>
    pull(cant_pozos_term)
)

base_2016_pozos_term_neu

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# llamo a una función portable para crear los índices con las series
# original, desestacionalizada (con método STL) y tendencia-ciclo

source(r"(utils\crear_indices.R)")

# la función tiene la siguiente estructura:
# crear_indices(x, fecha, base)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# índices de pozos en perforación para cuenca GSJ
ind_pozos_en_perf_gsj = crear_indices(pozos_mensual |>
    filter(cuenca == "GOLFO SAN JORGE") |>
    pull(cant_pozos_en_perf), 
    unique(pozos_mensual$fecha),
    base_2016_pozos_en_perf_gsj
)

print.data.frame(ind_pozos_en_perf_gsj)

# chequeo que sean 12 observaciones, dado que se considera el promedio anual de 2016
length(ind_pozos_en_perf_gsj |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# chequeo el valor promedio, que debe ser igual 100 para 2016
mean(ind_pozos_en_perf_gsj |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# índices de pozos terminados para cuenca GSJ
ind_pozos_term_gsj = crear_indices(pozos_mensual |>
    filter(cuenca == "GOLFO SAN JORGE") |>
    pull(cant_pozos_term), 
    unique(pozos_mensual$fecha),
    base_2016_pozos_term_gsj
)

print.data.frame(ind_pozos_term_gsj)

# chequeo que sean 12 observaciones, dado que se considera el promedio anual de 2016
length(ind_pozos_term_gsj |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# chequeo el valor promedio, que debe ser igual 100 para 2016
mean(ind_pozos_term_gsj |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# índices de pozos en perforación para cuenca NEU
ind_pozos_en_perf_neu = crear_indices(pozos_mensual |>
    filter(cuenca == "NEUQUINA") |>
    pull(cant_pozos_en_perf), 
    unique(pozos_mensual$fecha),
    base_2016_pozos_en_perf_neu
)

print.data.frame(ind_pozos_en_perf_neu)

# chequeo que sean 12 observaciones, dado que se considera el promedio anual de 2016
length(ind_pozos_en_perf_neu |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# chequeo el valor promedio, que debe ser igual 100 para 2016
mean(ind_pozos_en_perf_neu |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# índices de pozos terminados para cuenca NEU
ind_pozos_term_neu = crear_indices(pozos_mensual |>
    filter(cuenca == "NEUQUINA") |>
    pull(cant_pozos_term), 
    unique(pozos_mensual$fecha),
    base_2016_pozos_term_neu
)

print.data.frame(ind_pozos_term_neu)

# chequeo que sean 12 observaciones, dado que se considera el promedio anual de 2016
length(ind_pozos_term_neu |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# chequeo el valor promedio, que debe ser igual 100 para 2016
mean(ind_pozos_term_neu |>
    filter(year(fecha) == 2016) |>
    pull(original)
)

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
# # forma manual previa a definición de base (solo para info)
 
# # construcción de índice de pozos en perforación en cuenca GSJ
# ind_pozos_en_perf_gsj <- ts(
#     pozos_mensual |>
#         filter (cuenca == "GOLFO SAN JORGE") |>
#         pull(cant_pozos_en_perf),
#     start = c(year(min(pozos_mensual$fecha)), month(min(pozos_mensual$fecha))),
#     frequency = 12
# )

# ind_pozos_en_perf_gsj

# # check
# print(window(ind_pozos_en_perf_gsj, start = c(2012, 1), end = c(2012, 12))) # año al azar
# frequency(ind_pozos_en_perf_gsj)  # 12
# cycle(ind_pozos_en_perf_gsj) |> head(12) # meses observados

# # construcción de índice de pozos en perforación en cuenca NEU
# ind_pozos_en_perf_neu <- ts(
#     pozos_mensual |>
#         filter (cuenca == "NEUQUINA") |>
#         pull(cant_pozos_en_perf),
#     start = c(year(min(pozos_mensual$fecha)), month(min(pozos_mensual$fecha))),
#     frequency = 12
# )

# ind_pozos_en_perf_neu

# # check
# print(window(ind_pozos_en_perf_neu, start = c(2012, 1), end = c(2012, 12))) # año al azar
# frequency(ind_pozos_en_perf_neu)  # 12
# cycle(ind_pozos_en_perf_neu) |> head(12) # meses observados

# ------------------------------------------------------------------------------------------------------------------------------------------------------------
