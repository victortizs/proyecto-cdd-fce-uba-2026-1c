# Producción Argentina de Hidrocarburos

## Integrantes

| Nombre y apellido | Nro. de registro |
|:---|---:|
| Ariana Patricia Tello Senmache | 916327 |
| Carolina Alejandra Rios Otoya | 903196 |
| Victor Adrian Ortiz Solis | 895568 |

## Objetivo

Identificar cambios en las políticas de exploración, extracción e inversión de las empresas del sector en las principales cuencas del país (Golfo San Jorge y Neuquina).

## Datos

<ul>
    <li>
        <strong>Fuente principal:</strong>
            <a href="https://datos.gob.ar/dataset/energia-perforacion-pozos-petroleo-gas" target="_blank" rel="noopener noreferrer">Perforación de pozos de petróleo y gas</a>
            <details>
                <summary>Datasets</summary>
                <ul>
                    <li>
                        <a href="https://datos.gob.ar/dataset/energia-perforacion-pozos-petroleo-gas/archivo/energia_af6838ef-f675-4409-ac6a-e7c391a5dbab" target="_blank" rel="noopener noreferrer">Pozos en perforación</a> – Secretaría de Energía  
                    </li>
                    <li>
                        <a href="https://datos.gob.ar/dataset/energia-perforacion-pozos-petroleo-gas/archivo/energia_a2ce14af-5c56-45c2-9b9c-c7a1e5156dff" target="_blank" rel="noopener noreferrer">Pozos terminados</a> – Secretaría de Energía  
                    </li>                       
                </ul>
            </details>
    </li>
    <li>
        <strong>Fuentes complementarias:</strong>
            <details>
                <summary>Datasets</summary>
                <ul>
                    <li>
                        <a href="http://datos.energia.gob.ar/dataset/produccion-de-petroleo-y-gas-tablas-dinamicas/archivo/ce479c85-2e8b-441e-9c68-9681597b3694" target="_blank" rel="noopener noreferrer">Producción de gas por yacimiento</a> – Secretaría de Energía
                    </li>
                    <li>
                        <a href="http://datos.energia.gob.ar/dataset/produccion-de-petroleo-y-gas-tablas-dinamicas/archivo/745facdc-73dc-46d8-83d5-d027bdaa3210" target="_blank" rel="noopener noreferrer">Producción de petróleo por yacimiento</a> – Secretaría de Energía
                    </li>
                    <li>
                        <a href="http://datos.energia.gob.ar/dataset/inversiones-en-mercado-de-hidrocarburos-upstream/archivo/8ab4098a-842b-42f7-bf1a-b7b3637d226d" target="_blank" rel="noopener noreferrer">Resolución 2057 - Inversiones previstas año actual</a> – Secretaría de Energía
                    </li>
                    <li>
                        <a href="http://datos.energia.gob.ar/dataset/inversiones-en-mercado-de-hidrocarburos-upstream/archivo/285d45e5-1b88-4dae-8e5c-c01843c7c8c0" target="_blank" rel="noopener noreferrer">Resolución 2057 - Inversiones realizadas año anterior</a> – Secretaría de Energía
                    </li>
                </ul>
            </details>
            <details>
                <summary>Informes y reportes</summary>
                <ul>
                    <li>
                        <a href="https://www.energia.gob.ar/contenidos/archivos/Reorganizacion/contenidos_didacticos/publicaciones/hidrocarburos.pdf" target="_blank" rel="noopener noreferrer">Conceptos</a> – Secretaría de Energía (2012)
                    </li>
                    <li>
                        <a href="https://www.energia.gob.ar/contenidos/archivos/Reorganizacion/informacion_del_mercado/mercado_hidrocarburos/informacion_estadistica/reservas/Consolidacion_de_reservas_de_gas_y_petroleo_reporte_anual_2021.pdf" target="_blank" rel="noopener noreferrer">CONSOLIDACION DE RESERVAS DE GAS Y PETROLEO DE LA REPUBLICA ARGENTINA - Reporte anual - 2021</a> – Secretaría de Energía
                    </li>
                    <li>
                        Sidicaro, N.; Aneise, A. J.; Argoitia, J. M.; della Paolera, Carola; Freytes, C. y Schteingart, D. (2025).<br>
                        <a href="https://fund.ar/wp-content/uploads/2025/12/Fundar_Comodoro-Rivadavia-y-el-fin-de-un-ciclo_CC-BY-NC-ND-4.0-1.pdf" target="_blank" rel="noopener noreferrer">Comodoro Rivadavia y el fin de un ciclo. Hacia una transición productiva justa para la Cuenca del Golfo San Jorge.</a> Fundar.
                    </li>
                </ul>
            </details>
    </li>
    <li>
        <strong>Período:</strong>
            2009–2025
    </li>
    <li>
        <strong>Unidad de análisis:</strong>
            Cuencas y empresas
    </li>
</ul>

## Hipótesis

### Principal

A partir de 2017, la reasignación de inversiones hacia la cuenca Neuquina por parte de las principales empresas del sector hidrocarburífero se asocia con una tendencia descendente en la producción de la cuenca del Golfo San Jorge y con un crecimiento diferencial de la producción en la cuenca Neuquina.

### Complementarias

1. Se propone comparar la evolución de los niveles de producción de la cuenca Neuquina tras la recepción de mayores inversiones con los niveles de producción observados en la cuenca GSJ durante el mismo período, con el objetivo de identificar los impactos diferenciales del desvío de inversiones sobre ambas cuencas.
2. Los cambios en las tendencias de producción de las cuencas y empresas hidrocarburíferas pueden atribuirse a su relación de dependencia con el tipo de explotación predominante hacia el cual se orientan las inversiones, ya sea convencional o no convencional.

## Descripción de ETL (Extract, Transform, Load)

Luego de extraer los datos en su formato crudo *(raw)*, se filtran los datasets con las variables relevantes para el análisis, es decir, eliminando variables redundantes. Los datos originales ya se hallan en formato tidy, por lo cual no requieren transformación extra para su manipulación, aunque posteriormente se agruparán las variables en una sola base.

## Variables principales

<details>
    <summary>Selección inicial (<code>raw</code>)</summary><br>

| Nombre | Clase | Detalle | Dataset(s) |
|:---|:---:|:---:|:---:|
| `Fecha Inicio Tareas` | `date` | `yyyy-MM-dd` | inversiones previstas |
| `Fecha Fin Tareas` | `date` | `yyyy-MM-dd` | inversiones previstas |
| `indice_tiempo` | `character` | `yyyy-MM` | inversiones anteriores |
| `anio` | `numeric` | `n/a` | pozos y producción |
| `mes` | `numeric` | `n/a` | pozos y producción |
| `cuenca` | `character` | aparece como `Cuenca` en datasets de inversión | inversión, pozos y producción |
| `Empresa informante` | `character` | `na` | inversión |
| `empresa` | `character` | `n/a` | pozos y producción |
| `Tipo de explotación` | `character` | convencional o no convencional | inversión |
| `Millones u$s Exploracion` | `numeric` | valores previstos y reales | inversión |
| `Millones u$s Explotacion` | `numeric` | valores previstos y reales | inversión |
| `concepto` | `character` | finalidad de recurso en flujo energético | producción |
| `cantidad` | `numeric` | Mm3 para gas y m3 para petróleo | producción |
| `concepto` | `character` | actividad prevista (exploración, explotación, etc.) | pozos en perforación |
| `concepto` | `character` | recurso al que están destinados | pozos terminados |
| `tipodepozoterminado` | `character` | actividad prevista (exploración, explotación, etc.) | pozos terminados |
| `cantidad` | `numeric` | unidades | pozos |

</details>

<details>
    <summary>Selección post-ETL (<code>input</code>)</summary><br>

| Nombre | Clase | Detalle | Dataset(s) |
|:---|:---:|:---:|:---:|
| `anio_presentacion_ddjj` | `numeric` | `n/a` | inversión |
| `anio` | `numeric` | `n/a` | pozos y producción |
| `mes` | `numeric` | `n/a` | pozos y producción |
| `cuenca` | `character` | `n/a` | inversión, pozos y producción |
| `empresa` | `character` | `n/a` | inversión, pozos y producción |
| `tipo_explotacion` | `character` | convencional o no convencional | inversión y producción |
| `millones_usd_exploracion_prev` | `numeric` | `n/a` | inversión |
| `millones_usd_exploracion_real` | `numeric` | `n/a` | inversión |
| `millones_usd_explotacion_prev` | `numeric` | `n/a` | inversión |
| `millones_usd_explotacion_real` | `numeric` | `n/a` | inversión |
| `cant_gas_Mm3` | `numeric` | `n/a` | producción |
| `cant_petroleo_m3` | `numeric` | `n/a` | producción |
| `tipo_actividad` | `character` | exploración, explotación, etc. | pozos |
| `cant_pozos_en_perf` | `numeric` | `n/a` | pozos |
| `cant_pozos_term_gas` | `numeric` | `n/a` | pozos |
| `cant_pozos_term_petroleo` | `numeric` | `n/a` | pozos |

<!-- TODO: agregar total de variables de ambas tablas antes o después de ellas -->
<!-- ? ¿Cambiar de lugar columnas "Dataset(s)" y "Detalle" en tablas? -->
<!-- TODO: cambiar columnas de lugar para probar y decidir -->
<!-- TODO: agregar cambios/transformaciones posteriores a sección de ETL -->
<!-- ? ¿Deberíamos filtrar solo exploración y explotación en `tipo_actividad`? -->
<!-- TODO: si se filtra solo exploración y explotación debemos cambiar el detalle en la tabla de 'input' -->

</details>

## Benchmark

Nivel de producción de las principales empresas en los años previos a 2015. Siendo que el boom de inversiones en Vaca Muerta comenzó tras los descubrimientos de 2010–2011 y se consolidó entre 2012 y 2014 (con la nacionalización de YPF en 2012 y grandes acuerdos/inversiones de compañías como Chevron y *rig contracts* en 2014).

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