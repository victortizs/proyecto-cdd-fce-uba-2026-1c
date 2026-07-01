crear_indices <- function(x, fecha, base = NULL){

    if (is.null(base)) {
        base <- x[1]
    }

    stopifnot(
        length(x) == length(fecha),
        length(base) == 1,
        is.numeric(base),
        base > 0
    )

    indice <- x / base * 100

    indice_ts <- ts(
    indice,
    start = c(
        lubridate::year(min(fecha)),
        lubridate::month(min(fecha))
    ),
    frequency = 12
    )

    stl_fit <- stl(
    indice_ts,
    s.window = 13, # permite que la estacionalidad evolucione lentamente
    t.window = 25, # produce una tendencia suficientemente suave para una serie mensual
    robust = TRUE # reduce la influencia de meses atípicos
    )

    tibble::tibble(
    fecha = fecha,
    original = as.numeric(indice_ts),
    desestacionalizada =
        as.numeric(indice_ts -
        stl_fit$time.series[, "seasonal"]
        ),
    tendencia =
        as.numeric(
        stl_fit$time.series[, "trend"]
        )
    )
}