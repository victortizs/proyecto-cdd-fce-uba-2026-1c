library(readr)
library(dplyr)

df_1 = read_csv(r"(raw\pozos-en-perforacin.csv)")
glimpse(df_1)
pozos_en_perf = df_1 |>
    select(anio, mes, cuenca, empresa, cantidad, concepto)

write.csv(pozos_en_perf, "input/pozos_en_perf.csv", sep=",", row.names = FALSE, col.names = TRUE, fileEncoding = "UTF-8")

df_2 = read_csv(r"(raw\pozos-terminados.csv)")
glimpse(df_2)
pozos_terminados = df_2 |>
    select(anio, mes, cuenca, empresa, cantidad, tipodepozoterminado, concepto)

write.csv(pozos_terminados, "input/pozos_terminados.csv", sep=",", row.names = FALSE, col.names = TRUE, fileEncoding = "UTF-8")

df_3 = read_csv(r"(raw\produccin-de-gas-por-yacimiento.csv)")
glimpse(df_3)
prod_gas_yacim = df_3 |>
    select(anio, mes, cuenca, empresa, cantidad, concepto)

write.csv(prod_gas_yacim, "input/prod_gas_yacim.csv", sep=",", row.names = FALSE, col.names = TRUE, fileEncoding = "UTF-8")

df_4 = read_csv(r"(raw\produccin-de-petrleo-por-yacimiento.csv)")
glimpse(df_4)
prod_petro_yacim = df_4 |>
    select(anio, mes, cuenca, empresa, cantidad, concepto)

write.csv(prod_petro_yacim, "input/prod_petro_yacim.csv", sep=",", row.names = FALSE, col.names = TRUE, fileEncoding = "UTF-8")

df_5 = read_csv(r"(raw\resolucin-2057-inversiones-previstas-ao-actual.csv)")
glimpse(df_5)
inv_prev_anio_actual = df_5 |>
    select("Fecha Inicio Tareas", "Fecha Fin Tareas", "Cuenca", "Empresa informante", "Millones u$s Exploracion", "Millones u$s Explotacion", "Tipo de explotación")

write.csv(inv_prev_anio_actual, "input/inv_prev_anio_actual.csv", sep=",", row.names = FALSE, col.names = TRUE, fileEncoding = "UTF-8")

df_6 = read_csv(r"(raw\resolucin-2057-inversiones-realizadas-ao-anterior.csv)")
glimpse(df_6)
inv_anios_ant = df_6 |>
    select("indice_tiempo", "Cuenca", "Empresa informante", "Millones u$s Exploracion", "Millones u$s Explotacion", "Tipo de explotación")

write.csv(inv_anios_ant, "input/inv_anios_ant.csv", sep=",", row.names = FALSE, col.names = TRUE, fileEncoding = "UTF-8")
