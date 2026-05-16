library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)

pozos_term_y_en_perf = read_csv(r"(input\pozos_term_y_en_perf.csv)")
glimpse(pozos_term_y_en_perf)
head(pozos_term_y_en_perf, 10)
  
head(df, 10)

df_long <- pozos_term_y_en_perf |>
  filter(concepto == "Explotación") |> # mezclar con | concepto == "Exploración" o cambiar filtro
  pivot_longer(cols = c(cant_pozos_term_gas, cant_pozos_term_petroleo, cant_pozos_en_perf), names_to = "series", values_to = "value") |>
  filter(series == "cant_pozos_term_petroleo" & cuenca == "GOLFO SAN JORGE") |> # cambiar filtro con cant_pozos_term_gas o cant_pozos_en_perf y otras cuencas
  filter(anio == 2016) |>
  group_by(anio, mes, cuenca, concepto, series) |>
  summarise(value = sum(value)) |>
  mutate(date = make_date(year = anio, month = mes, day = 1))

head(df_long, 10)

ggplot(df_long, aes(x = date, y = value, color = series)) +
  geom_line(size = 1) +
  labs(x = "Date", y = "Value", color = "Series") +
  theme_minimal()


# ggplot(df_long, aes(x = date, y = value, color = series)) +
  # geom_line(size = 0.9) +
  # add a horizontal mean line per series (use linetype to distinguish)
  # geom_hline(data = hlines, aes(yintercept = y, color = series), linetype = "dashed", size = 0.6, show.legend = FALSE) +
  # geom_hline(yintercept = 0, color = "black", linetype = "solid", size = 0.4) +
  # scale_x_date(date_labels = "%Y-%m", date_breaks = "6 months") +
  # labs(x = "Month", y = "Count", color = "Series", title = "Time series of pozos (monthly)") +
  # theme_minimal() +
  # theme(axis.text.x = element_text(angle = 45, hjust = 1))
