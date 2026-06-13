library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggtext)
library(scales)

# -------------------------------------------------------------------------
rojo = "#F54927"
celeste = "#27D3F5"

theme_owid <- function(base_size = 13, base_family = "") {
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      plot.title.position   = "plot",
      plot.caption.position = "plot",
      plot.title    = element_markdown(face = "bold", size = rel(1.35),
                                       colour = "#1d1d1d", lineheight = 1.2,
                                       margin = margin(b = 4)),
      plot.subtitle = element_markdown(size = rel(1.0), colour = "#5b5b5b",
                                       margin = margin(b = 16)),
      plot.caption  = element_markdown(hjust = 0, size = rel(0.72),
                                       colour = "#8a8a8a", margin = margin(t = 14)),
      axis.title    = element_blank(),         # OWID casi no usa titulos de eje
      axis.text     = element_text(colour = "#5b5b5b"),
      axis.ticks    = element_blank(),
      panel.grid.major.y = element_line(colour = "#e6e6e6", linewidth = 0.4),
      panel.grid.major.x = element_blank(),    # solo grilla horizontal
      panel.grid.minor   = element_blank(),
      legend.position    = "none",             # usamos etiquetas directas
      plot.margin = margin(t = 14, r = 110, b = 10, l = 16)  # der.: espacio etiquetas
    )
}

# -------------------------------------------------------------------------
df = read_csv(r"(input\pozos_term_y_en_perf.csv)")

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
