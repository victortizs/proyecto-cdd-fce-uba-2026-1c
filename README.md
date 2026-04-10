# Producción Argentina de Hidrocarburos

## Objetivo

Comparar las extracciones de hidrocarburos y perforaciones de pozos en las principales cuencas del país y su situación en las provincias energéticas entre los años 2009–2025.

## Integrantes

| Nombre y apellido | Nro. de registro |
|:---|---:|
| Ariana Patricia Tello Senmache | 916327 |
| Carolina Alejandra Rios Otoya | 903196 |
| Victor Adrian Ortiz Solis | 895568 |

## Datos

- **Fuente principal:**
    <a href="https://datos.gob.ar/dataset/energia-perforacion-pozos-petroleo-gas" target="_blank" rel="noopener noreferrer">Perforación de pozos de petróleo y gas en Argentina</a> – Secretaría de Energía

- **Fuente complementaria:**
    Sidicaro, N.; Aneise, A. J.; Argoitia, J. M.; della Paolera, Carola; Freytes, C. y Schteingart, D. (2025).<br>
    <a href="https://fund.ar/wp-content/uploads/2025/12/Fundar_Comodoro-Rivadavia-y-el-fin-de-un-ciclo_CC-BY-NC-ND-4.0-1.pdf" target="_blank" rel="noopener noreferrer">Comodoro Rivadavia y el fin de un ciclo. Hacia una transición productiva justa para la Cuenca del Golfo San Jorge.</a> Fundar.

- **Período:**
    2009–2025

- **Unidad de análisis:**
    provincias y cuencas argentinas

## Variables principales

| Nombre | Clase | Detalle |
|:---|:---:|:---:|
| completar | completar| completar |

## Hipótesis

El motivo del redireccionamiento de las inversiones hacia Vaca Muerta no es solo la mayor capacidad de producción, sino también las proyecciones de aumento en la exclusividad para la venta al extranjero. Por lo tanto, en las demás cuencas, se mantendría la inversión mínima suficiente para abastecer el consumo local.

## Descripción de ETL (Extract, Transform, Load)

Completar con texto y quizá imágenes y pequeños ejemplos

## Benchmark

Completar con texto y links a fuentes de info y/o indicadores

## Estructura del repositorio

```
proyecto/
├── raw/                     # Bases originales de (completar)
├── auxiliar/                # Proyecciones de (completar)
├── input/                   # Bases procesadas y listas para análisis
├── output/
│   ├── tablas/              # Tablas de resultados exportadas
│   └── graficos/            # Visualizaciones generadas
├── scripts/                 # Instrucciones (código) con objetivo específico
│   ├── 01_limpieza.R
│   ├── 02_exploratorio.R
│   ├── 03_analisis.R
│   └── 04_visualizaciones.R
├── utils/                   # Funciones propias (un script por función)
│   └── prueba_filtro_empresa.R
├── instructivo-tp/          # Info sobre lo solicitado para el TP
│   ├── checklist_entregas.md 
│   ├── consignas_trabajo_final.md
│   ├── cronograma_cdd_econ_y_neg_2026_1c.xlsx
│   └── guia_readme.md
└── README.md                # Descripción del proyecto y guía del repositorio
```