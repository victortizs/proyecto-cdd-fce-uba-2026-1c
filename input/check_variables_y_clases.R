library(readr)

# Pozos terminados
pozos_terminados = read_csv(r"(raw\pozos-terminados.csv)", show_col_types = FALSE)
glimpse(pozos_terminados)
names(pozos_terminados)
unique(pozos_terminados$indice_tiempo)
unique(pozos_terminados$concepto)
class(pozos_terminados$cuenca)

# Pozos en perforación
pozos_en_perf = read_csv(r"(raw\pozos-en-perforacin.csv)", show_col_types = FALSE)
glimpse(pozos_en_perf)
names(pozos_en_perf)
unique(pozos_en_perf$indice_tiempo)
class(pozos_en_perf$cuenca)

# Metros perforados por cuenca
metros_por_cuenca = read_csv(r"(raw\metros-perforados-por-cuenca.csv)", show_col_types = FALSE)
glimpse(metros_por_cuenca)
names(metros_por_cuenca)
unique(metros_por_cuenca$indice_tiempo)
unique(metros_por_cuenca$cuenca)
class(metros_por_cuenca$cuenca)

# Metros perforados por empresa
metros_por_empresa = read_csv(r"(raw\metros-perforados-por-empresa.csv)", show_col_types = FALSE)
glimpse(metros_por_empresa)
unique(metros_por_empresa$concepto_metros)
unique(metros_por_empresa$indice_tiempo)

# Producción de gas por yacimiento
prod_gas = read_csv(r"(raw\produccin-de-gas-por-yacimiento.csv)", show_col_types = FALSE)
glimpse(prod_gas)
unique(prod_gas$concepto)
unique(prod_gas$indice_tiempo)

# Producción de petróleo por yacimiento
prod_petroleo = read_csv(r"(raw\produccin-de-petrleo-por-yacimiento.csv)", show_col_types = FALSE)
glimpse(prod_petroleo)
unique(prod_petroleo$concepto)
unique(prod_petroleo$indice_tiempo)