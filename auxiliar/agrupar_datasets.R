library(readr)
library(dplyr)

pozos_en_perf = read_csv(r"(input\pozos_en_perf.csv)", show_col_types = FALSE)
pozos_terminados = read_csv(r"(input\pozos_terminados.csv)", show_col_types = FALSE)

head(pozos_en_perf)
head(pozos_terminados)

colnames(pozos_terminados) <- c("anio", "mes", "cuenca", "empresa", "cantidad", "concepto", "finalidad")
# df2 = rename(df2, tipodepozoterminado = "concepto", concepto = "finalidad")
unique(pozos_en_perf$empresa)
unique(pozos_terminados$empresa)

temp_1 = unique(pozos_en_perf$empresa)
temp_2 = unique(pozos_terminados$empresa)

glimpse(pozos_en_perf)
glimpse(pozos_terminados)

filtrado_perf = pozos_en_perf |>
    group_by(anio, mes, cuenca, empresa, concepto) |>
    summarise(
        cantidad = sum(cantidad)
    ) |>
    filter(cantidad != 0)

write.csv(filtrado_perf, "input/filtro_pozos_en_perf.csv", row.names = FALSE, fileEncoding = "UTF-8")

filtrado_terminados = pozos_terminados |>
    filter(finalidad != "Improductivos") |>
    group_by(anio, mes, cuenca, empresa, concepto, finalidad) |>
    summarise(
        cantidad = sum(cantidad)
    ) |>
    filter(cantidad != 0)

write.csv(filtrado_terminados, "input/filtro_pozos_term.csv", row.names = FALSE, fileEncoding = "UTF-8")
    # arrange(empresa)
head(filtrado_perf)
head(filtrado_terminados)

# Preguntas para profe
# 1- Filtramos para excluir sevicios en pozos terminados por "finalidad"
# 2- No podemos agrupar más o mezclar (en perforación con terminados) porque terminados
# tiene más de un valor por finalidad y si agregamos cantidad de pozos en perforación
# se duplicarían los valores por fila (observación) de finalidad