graficar_indices <- function(df, tipo, cuenca, colores) {
  
  titulo <- sprintf("Índice de pozos %s (%s)", tipo, cuenca)
  subtitulo <- paste0(
    "Base 2016 = 100 (promedio mensual de 2016).",
    "<br>",
    "Se presentan la serie original, ",
    "la serie desestacionalizada mediante STL<sup>1</sup> y la tendencia estimada."
  )
  
  # preparación de datos
  df_long <- df |>
    tidyr::pivot_longer(
      -fecha,
      names_to = "serie",
      values_to = "indice"
    ) |>
    dplyr::mutate(
      serie = factor(
        serie,
        levels = c("original", "desestacionalizada", "tendencia"),
        labels = c("Serie original", "Desestacionalizada (STL)", "Tendencia")
      )
    )
  
  # captura del último punto para las etiquetas
  etiquetas <- df_long |> 
    dplyr::filter(fecha == max(fecha))
  
  # calculo dinámico de un desfase a la derecha
  rango_x <- diff(range(df_long$fecha))
  desfase_x <- rango_x * 0.03
  
  # gráfico
  ggplot2::ggplot(df_long, ggplot2::aes(x = fecha, y = indice, color = serie, linewidth = serie)) +
    ggplot2::geom_line() +
    
    # ggrepel con restricciones direccionales
    ggrepel::geom_text_repel(
      data = etiquetas,
      ggplot2::aes(
        x = fecha + desfase_x, 
        label = serie
      ),
      hjust = 0,
      size = 3.8,
      fontface = "bold", 
      show.legend = FALSE,
      
    # parámetros para que las etiquetas no se pisen si
    # el valor en el eje y de los índices es similar
      direction     = "y",         
      nudge_x       = 0,           
      segment.color = NA,          
      box.padding   = 0.25,        
      min.segment.length = Inf     
    ) +
    
    # paleta de colores elegidos por el usuario
    ggplot2::scale_color_manual(values = colores) +
    
    # ancho predeterminado de los índices
    # (busca destacar la serie de tendencia-ciclo)
    ggplot2::scale_linewidth_manual(
      values = c(
        "Serie original"           = 0.5,
        "Desestacionalizada (STL)" = 0.8,
        "Tendencia"                = 1.3
      ),
      guide = "none"
    ) +
    
    # margen de seguridad "invisible" en ambos extremos
    # del eje x para que no se peguen a los bordes
    ggplot2::scale_x_date(expand = ggplot2::expansion(mult = c(0.02, 0.28))) +
    
    ggplot2::labs(
      title = titulo,
      subtitle = subtitulo,
      caption = paste0(
        "**Nota<sup>1</sup>:** Acrónimo de *Seasonal and Trend decomposition using Loess*.",
        "<br>",
        "**Fuente:** Secretaría de Energía. Subsecretaría de Hidrocarburos"
      ),
      x = NULL,
      y = "Base = 100",
      color = NULL
    ) +
    tema_owid()
}