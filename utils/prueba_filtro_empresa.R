library(readr)
library(dplyr)

df = read_csv(r"(http://datos.energia.gob.ar/dataset/7ea2ac77-d7a0-4129-9fbf-6f1a25d94e21/resource/7fcd6c41-9358-4e16-96f1-0380444bff26/download/pozos-en-perforacin-por-empresa.csv)")
glimpse(df)

cat("Valores únicos por columna:")
for (col in names(df)) {
    cat(col, " -> ", n_distinct(df[[col]]), "\n", sep = "")
}

unique(df$anio)
unique(df$empresa)
unique(df$empresa[grepl("pampa energia", df$empresa, ignore.case = TRUE)])

filtro_empresa = grepl("pampa energia", df$empresa, ignore.case = TRUE)
class(filtro_empresa)
which(filtro_empresa)
print.data.frame(df[filtro_empresa, ])
