# Producción Argentina de Hidrocarburos

## Objetivo

Identificar cambios en las políticas de extracción y exploración a nivel empresarial, su presencia en las principales cuencas del país (Golfo San Jorge y Neuquina) y la evolución de la producción en ellas.

## Integrantes

| Nombre y apellido | Nro. de registro |
|:---|---:|
| Ariana Patricia Tello Senmache | 916327 |
| Carolina Alejandra Rios Otoya | 903196 |
| Victor Adrian Ortiz Solis | 895568 |

## Datos

<ul>
    <li>
        <b>Fuente principal:</b><br>
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
        <b>Fuentes complementarias:</b>
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
        <b>Período:</b>
        2009–2025
    </li>
    <li>
        <b>Unidad de análisis:</b>
        empresas y cuencas
    </li>
</ul>

## Hipótesis

### Principal

Se plantea que existe un desvío de inversiones desde la cuenca del Golfo San Jorge (GSJ) hacia la cuenca Neuquina (NEU) por parte de las principales empresas del sector hidrocarburífero, y que este proceso genera diferencias en los niveles de producción de la cuenca GSJ.

Para evaluar este fenómeno, se propone comparar:

- Los niveles de producción de la cuenca GSJ en 2025 (último año con datos completos) respecto del período inmediatamente posterior al desvío de inversiones, con el objetivo de identificar si la producción alcanzó una etapa de estabilidad o un nuevo piso productivo.
- Los niveles de producción de la cuenca GSJ en 2025 respecto del período previo al desvío de inversiones, a fin de analizar la magnitud del cambio productivo asociado a la reasignación de inversiones.

### Complementarias

1. Se propone comparar la evolución de los niveles de producción de la cuenca Neuquina tras la recepción de mayores inversiones con los niveles de producción observados en la cuenca GSJ durante el mismo período, con el objetivo de identificar posibles impactos diferenciales del desvío de inversiones sobre ambas cuencas.
2. Los cambios en las tendencias de producción de las cuencas y empresas hidrocarburíferas pueden atribuirse a su relación de dependencia con el tipo de explotación predominante hacia el cual se orientan las inversiones, ya sea convencional o no convencional.

## Descripción de ETL (Extract, Transform, Load)

Luego de extraer los datos en su formato crudo *(raw)*, se filtran los datasets con las variables relevantes para el análisis, es decir, eliminando variables redundantes. Los datos originales ya se hallan en formato tidy, por lo cual no requieren transformación extra para su manipulación, aunque posteriormente se agruparán las variables en una sola base.

## Variables principales

<details>
    <summary>Selección inicial: <code>raw</code></summary><br>

| Nombre | Clase | Detalle |
|:---|:---:|:---:|
| `anio` | `numeric` | `n/a` |
| `mes` | `numeric` | `n/a` |
| `cuenca` | `character` | `n/a` |
| `empresa` | `character` | `n/a` |
| `tipodepozoterminado` | `character` | actividad prevista |
| `concepto` | `character` | tipo de producción pozos terminados |
| `cantidad` | `numeric` | pozos terminados |
| `concepto` | `character` | actividad prevista pozos en perforación |
| `cantidad` | `numeric` | pozos perforación |
| `cantidad` | `numeric` | Mm3 de gas |
| `concepto` | `character` | finalidad de producción de gas |
| `cantidad` | `numeric` | m3 de petróleo |
| `concepto` | `character` | finalidad de producción de petróleo |
| `Fecha Inicio Tareas` | `date` | inversiones previstas |
| `Fecha Fin Tareas` | `date` | inversiones previstas |
| `Empresa informante` | `character` | inversiones previstas |
| `Millones u$s Explotacion` | `numeric` | valores previstos de inversión |
| `Millones u$s Exploracion` | `numeric` | valores previstos de inversión |
| `indice_tiempo` | `character` | año-mes inversiones reales |
| `Empresa informante` | `character` | inversiones reales |
| `Millones u$s Explotacion` | `numeric` | valores reales de inversión |
| `Millones u$s Exploracion` | `numeric` | valores reales de inversión |
| `Millones u$s Exploracion` | `numeric` | valores reales de inversión |
| `Tipo de explotación` | `character` | referente a inversión |

</details>

<details>
    <summary>Selección post-ETL: <code>input</code></summary><br>

| Nombre | Clase | Detalle |
|:---|:---:|:---:|
| `anio` | `numeric` | `n/a` |
| `anio_presentacion_ddjj` | `numeric` | `n/a` |
| `mes` | `numeric` | `n/a` |
| `cuenca` | `character` | `n/a` |
| `empresa` | `character` | `n/a` |
| `tipo_actividad` | `character` | exploración, explotación, etc. |
| `tipo_explotacion` | `character` | convencional o no convencional |
| `cant_pozos_en_perf` | `numeric` | `n/a` |
| `cant_pozos_term_gas` | `numeric` | `n/a` |
| `cant_pozos_term_petroleo` | `numeric` | `n/a` |
| `cant_gas_Mm3` | `numeric` | `n/a` |
| `cant_petroleo_m3` | `numeric` | `n/a` |
| `millones_usd_exploracion_prev` | `numeric` | `n/a` |
| `millones_usd_exploracion_real` | `numeric` | `n/a` |
| `millones_usd_explotacion_prev` | `numeric` | `n/a` |
| `millones_usd_explotacion_real` | `numeric` | `n/a` |

<!-- TODO: reordenar filas de tabla de manera que queden las numéricas al final -->
<!-- TODO: acortar nombres de archivos input de inversión y producción en `write.csv()` -->
<!-- TODO: agregar columna, a ambas tablas de variables, de dataset de proveniencia -->
<!-- TODO: agregar total de variables de ambas tablas antes o después de ellas -->
<!-- ? Deberíamos filtrar solo exploración y explotación en `tipo_actividad`? -->
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