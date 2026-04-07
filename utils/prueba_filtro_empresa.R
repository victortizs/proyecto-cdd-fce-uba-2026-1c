library(readr)
library(dplyr)

df = read_csv(r"(http://datos.energia.gob.ar/dataset/7ea2ac77-d7a0-4129-9fbf-6f1a25d94e21/resource/af6838ef-f675-4409-ac6a-e7c391a5dbab/download/pozos-en-perforacin.csv)")
glimpse(df)

cat("Valores únicos por columna:")
for (col in names(df)) {
    cat(col, " -> ", n_distinct(df[[col]]), "\n", sep = "")
}

unique(df$anio)
unique(df$empresa)
unique(df$empresa[grepl("ypf", df$empresa, ignore.case = TRUE)])

filtro_empresa = grepl("ypf", df$empresa, ignore.case = TRUE)
class(filtro_empresa)
# which(filtro_empresa)
print.data.frame(head(df[filtro_empresa, ], 5))
