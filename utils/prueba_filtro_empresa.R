library(readr)
library(dplyr)

df = read_csv(r"(C:\Users\victo\Downloads\pozos-en-perforacin.csv)")
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
