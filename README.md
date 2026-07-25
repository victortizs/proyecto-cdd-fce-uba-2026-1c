# Producción de hidrocarburos en Argentina

## Objetivo

Identificar cambios en las políticas de exploración, extracción e inversión de las empresas del sector en las principales cuencas del país (Golfo San Jorge y Neuquina).

## Integrantes

| Nombre y apellido | Nro. de registro |
|:---|---:|
| Ariana Patricia Tello Senmache | 916327 |
| Carolina Alejandra Rios Otoya | 903196 |
| Victor Adrian Ortiz Solis | 895568 |

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
            2009–2025 (los datos complementarios de inversión comienzan a partir de 2013)
    </li>
    <li>
        <strong>Unidades de análisis:</strong>
            cuencas y empresas
    </li>
</ul>

## Hipótesis

### Principal

A partir de 2017, la reasignación de inversiones hacia la cuenca Neuquina por parte de las principales empresas del sector hidrocarburífero se asocia con una tendencia descendente en la producción de la cuenca del Golfo San Jorge y con un crecimiento diferencial en la producción de la cuenca Neuquina.

### Complementarias

1. El desvío de inversiones puede reflejarse en una mayor concentración de la inversión empresarial y en cambios en la composición de la producción y de la inversión en la cuenca Neuquina a lo largo del tiempo.
2. Los cambios en las tendencias de producción de las cuencas y empresas hidrocarburíferas se relacionan con el tipo de explotación predominante hacia el cual se orientan las inversiones, convencional o no convencional.

## Descripción de ETL (Extract, Transform, Load)

Tras extraer los datos en su forma original o cruda *—raw—*, se filtraron los datasets solo con las variables consideradas relevantes para el análisis, es decir, obviando aquellas redundantes. Dichos datos se hallaron en formato tidy, por lo cual en primera instancia no necesitaron transformaciones extras para su manipulación.

La siguiente [sección](#var-principales) proporciona un panorama más completo de las variables mencionadas a continuación y consideradas al iniciar el proceso de limpieza, transformación y estandarización (ETL); cuyos códigos respectivos se hallan en la carpeta `scripts\01_etl`. A grandes rasgos, el proceso constó de los siguientes pasos:

1. Restringir los datos al periodo temporal fijado para el análisis:
    - Inversión prevista > 2013–2025
    - Inversión realizada > 2013–2025
    - Pozos en perforación > 2009–2025
    - Pozos terminados > 2009–2025
    - Producción de gas > 2009–2025
    - Producción de petróleo > 2009–2025

    Para la inversión fue necesario considerar la variable original `Año de presentación de la DDJJ` —omitida en un comienzo—, dado que el resto de variables referenciando a fechas presentaban datos incompletos *(missing values)*. Para esto se realizó un chequeo que comprobó que la variable en cuestión efectivamente mantenía coherencia con el resto de variables semejantes. Más detalle se halla en `scripts\01_etl\limpieza_inv.R`.
    
2. Agrupar los datos mediante la suma de las variables cuantitativas relativas a cada dataset (cantidad de pozos, millones de dólares, producción, etc.), según las siguientes categorías:
    - Inversión prevista > `anio_presentacion_ddjj`, `cuenca`, `empresa`, `tipo_explotacion`
    - Inversión realizada > `anio_presentacion_ddjj`, `cuenca`, `empresa`, `tipo_explotacion`
    - Pozos en perforación > `anio`, `mes`, `cuenca`, `empresa`, `concepto`
    - Pozos terminados > `anio`, `mes`, `cuenca`, `empresa`, `concepto`, `finalidad`
    - Producción de gas > `anio`, `mes`, `cuenca`, `empresa`, `tipo_explotacion`
    - Producción de petróleo > `anio`, `mes`, `cuenca`, `empresa`, `tipo_explotacion`

    La variable `finalidad` en pozos terminados es un paso **temporal** para la transformación de la variable original `cantidad` en `cant_pozos_term_petro` y `cant_pozos_term_gas`, y surge tras renombrar la variable `concepto`, que, cabe mencionar, no representa lo mismo en este caso que para pozos en perforación. Algo similar sucede con la variable `tipo_explotacion` en los datasets de producción, que surge de una transformación que requirió de la variable temporal `categoria_flujo`. Más detalle se halla en `scripts\01_etl\limpieza_pozos.R` y `scripts\01_etl\limpieza_prod.R`, respectivamente.

3. Consolidar los datasets mediante un `full_join()`, según las siguientes *keys* en común:
    - Inversión prevista y realizada > `anio_presentacion_ddjj`, `cuenca`, `empresa`, `tipo_explotacion`
    - Pozos en perforación y terminados > `anio`, `mes`, `cuenca`, `empresa`, `tipo_actividad`
    - Producción de gas y petróleo > `anio`, `mes`, `cuenca`, `empresa`, `tipo_explotacion`

    Ahora bien, al unir dos tablas provenientes de dos datasets distintos, las variables cuantitativas que no están presentes en una de ellas aparecen como `NA`. Por ejemplo, dadas las siguientes tablas:

    | tipo_inmueble | nro_inquilinos | nivel_comodidad |
    |:---|---:|---:|
    | casa | 3 | bueno |
    | hotel | 160 | excelente |
    
    | tipo_inmueble | nro_inquilinos | precio_calidad |
    |:---|---:|---:|
    | casa | 3 | excelente |
    | hotel | 160 | regular |
    | pensión | 24 | bueno |
    
    Al unirlas por `tipo_inmueble` y `nro_inquilinos` se llega a:

    | tipo_inmueble | nro_inquilinos | nivel_comodidad |  precio_calidad |
    |:---|---:|---:|---:|
    | casa | 3 | bueno | excelente |
    | hotel | 160 | excelente | regular |
    | pensión | 24 | `NA` | bueno |
    
    Por ello, se decidió reemplazar los valores faltantes (`NA`) con cero (0), considerando que para los análisis posteriores es necesario, en ciertas ocasiones, filtrar por valores mayores a cero para no generar resultados malinterpretados o estadísticamente erróneos —como podría ser el caso si se usaran regresiones—.

Otras operaciones como filtros y transformaciones de formato (de largo a ancho) fueron ejecutadas con el fin de lograr consolidar y, por tanto, reducir el número de insumos *—inputs—* a analizar. Por último, la elección de filtrar las cuencas `GOLFO SAN JORGE` y `NEUQUINA` posteriormente en cada análisis es puramente funcional: se busca que los archivos procesados sean útiles a más de un estudio.


<h2 id="var-principales">Variables principales</h2>

<details>
    <summary>Selección inicial (<code>raw</code>)</summary><br>

Corresponde a las variables presentes en los archivos originales descargados de la fuente de datos, antes del proceso de limpieza y estandarización.

| Variable | Clase | Dataset(s) | Descripción |
|:---|:---:|:---:|:---:|
| `Fecha Inicio Tareas` | `date` | inversiones previstas | formato `yyyy-MM-dd` |
| `Fecha Fin Tareas` | `date` | inversiones previstas | formato `yyyy-MM-dd` |
| `indice_tiempo` | `character` | inversiones anteriores | formato `yyyy-MM` |
| `anio` | `numeric` | pozos, producción | año calendario |
| `mes` | `numeric` | pozos, producción | mes calendario (1–12) |
| `Cuenca` | `character` | inversión | cuenca hidrocarburífera |
| `cuenca` | `character` | pozos, producción | cuenca hidrocarburífera |
| `Empresa informante` | `character` | inversión | empresa operadora |
| `empresa` | `character` | pozos, producción | empresa operadora |
| `Tipo de explotación` | `character` | inversión | convencional o no convencional |
| `concepto` | `character` | producción | finalidad de recurso en flujo energético |
| `concepto` | `character` | pozos en perforación | actividad prevista (exploración, explotación, etc.) |
| `concepto` | `character` | pozos terminados | recurso al que están destinados |
| `tipodepozoterminado` | `character` | pozos terminados | actividad prevista (exploración, explotación, etc.) |
| `Millones u$s Exploracion` | `numeric` | inversión | montos previstos y reales |
| `Millones u$s Explotacion` | `numeric` | inversión | montos previstos y reales |
| `Millones u$s Exp. Complementaria` | `numeric` | inversión | montos previstos y reales |
| `cantidad` | `numeric` | producción | gas: Mm³; petróleo: m³ |
| `cantidad` | `numeric` | pozos | unidades |

> **Nota(s):**
> - Esta instancia considera los siguientes archivos de la carpeta `raw`:
>   - pozos-en-perforacin.csv
>   - pozos-terminados.csv
>   - produccin-de-gas-por-yacimiento.csv
>   - produccin-de-petrleo-por-yacimiento.csv
>   - resolucin-2057-inversiones-previstas-ao-actual.csv
>   - resolucin-2057-inversiones-realizadas-ao-anterior.csv
> - La descripción de la variable `cantidad`, presente en los datasets de producción, refiere a que la producción de gas se expresa en millones de metros cúbicos (Mm³), mientras que la de petróleo se expresa en metros cúbicos (m³). A su vez, esta variable incluye también unidades no indicativas del volumen de producción, las cuales fueron excluidas durante el proceso de limpieza.

</details>

<details>
    <summary>Selección post-ETL (<code>input</code>)</summary><br>

Corresponde a las variables presentes en los datasets consolidados luego del proceso principal de ETL.

| Variable | Clase | Dataset(s) | Descripción |
|:---|:---:|:---:|:---:|
| `anio_presentacion_ddjj` | `numeric` | inversión | año calendario |
| `anio` | `numeric` | pozos, producción | año calendario |
| `mes` | `numeric` | pozos, producción | mes calendario (1–12) |
| `cuenca` | `character` | inversión, pozos, producción | cuenca hidrocarburífera |
| `empresa` | `character` | inversión, pozos, producción | empresa operadora |
| `tipo_explotacion` | `character` | inversión, producción | convencional o no convencional |
| `tipo_actividad` | `character` | pozos | exploración o explotación |
| `millones_usd_exploracion_prev` | `numeric` | inversión | inversión prevista en exploración (millones de USD) |
| `millones_usd_exploracion_real` | `numeric` | inversión | inversión realizada en exploración (millones de USD) |
| `millones_usd_explotacion_prev` | `numeric` | inversión | inversión prevista en explotación (millones de USD) |
| `millones_usd_explotacion_real` | `numeric` | inversión | inversión realizada en explotación (millones de USD) |
| `cant_gas_Mm3` | `numeric` | producción | producción de gas (Mm³) |
| `cant_petro_m3` | `numeric` | producción | producción de petróleo (m³) |
| `cant_pozos_en_perf` | `numeric` | pozos | unidades |
| `cant_pozos_term_gas` | `numeric` | pozos | unidades |
| `cant_pozos_term_petro` | `numeric` | pozos | unidades |

> **Nota(s):**
> - Esta instancia considera los siguientes archivos de la carpeta `input`:
>   - inv_prev_y_real.csv
>   - pozos_en_perf_y_term.csv
>   - prod_gas_y_petro.csv
> - Se utilizan los sufijos `prev` y `real` para distinguir los montos de inversión previstos de los efectivamente realizados.
> - Las variables `millones_usd_exploracion_prev` y `millones_usd_exploracion_real` se obtuvieron sumando `Millones u$s Exploración` y `Millones u$s Exp. Complementaria`, para sus montos previstos y reales, respectivamente, dado que esta última corresponde mayoritariamente a actividades de perforación de pozos exploratorios.

</details>

## Benchmark

Nivel de producción de las principales empresas en los años previos a 2015. Siendo que el boom de inversiones en Vaca Muerta comenzó tras los descubrimientos de 2010–2011 y se consolidó entre 2012 y 2014 (con la nacionalización de YPF en 2012 y grandes acuerdos/inversiones de compañías como Chevron y *rig contracts* en 2014).

## Estructura del repositorio

```
proyecto-cdd-fce-uba-2026-1c/
├── environment/             # Archivos auxiliares para reproducibilidad
│   └── conda/
│       └── conda-lock.yml   # Lockfile multiplataforma (Windows, MacOs, GNU/Linux)
├── input/                   # Bases procesadas y consolidadas
├── output/                  
│   ├── graficos/            # Visualizaciones generadas   
│   └── presentacion/        # Entrega final en formato pdf
├── raw/                     # Bases originales publicadas por la Secretaría de Energía
├── scripts/
│   ├── 01_etl/              # Proceso de limpieza, transformación y estandarización
│   ├── 02_eda/              # Análisis exploratorio de datos
│   ├── 03_tests/            # Tests de hipótesis y métodos estadísticos
│   └── 04_veda/             # Análisis visual exploratorio de datos   
├── utils/                   # Funciones/snippets reiterativos (boilerplate)
├── README.md                
└── environment.yml          # Snapshot de entorno usado en conda (gestor de paquetes y entornos)
```

## Reproducción

### Paquetes necesarios

#### Conda

Los paquetes necesarios para la reproducción se hallan en `environment.yml` detro del *root directory*, los mismos están dirigidos a usuarios que prefieren usar `conda` como gestor de paquetes y entornos de desarrollo.

Además, se pone a disposición un *lockfile* —*snapshot* del entorno con versiones de paquetes y dependencias, *checksums* de verificación y compatibilidad multiplataforma— adaptable a usuarios que usen `conda` tanto en Windows, Linux o MacOs. El mismo se halla en `environment\conda\conda-lock.yml`.

### Orden de ejecución

1. `scripts\01_etl` > Lee los archivos en `raw` y genera los archivos estandarizados en `input`.
2. `scripts\02_eda` > Lee los archivos en `input` y obtiene estadísticas descriptivas.
3. `scripts\03_tests` > Lee los archivos en `input` y realiza tests de hipótesis, más cálculos adicionales.
4. `scripts\04_veda` > Lee los archivos en `input`, genera gráficos editorializados y los guarda en `output\graficos`.

> **Nota(s):**
>
> Cada carpeta dentro de `scripts` contiene tres (3) archivos correspondientes a la temática del o de los datasets: inversión, pozos en perforación y terminados, producción de gas y petróleo. Sin embargo, para la exploración analítica de los datos y sus distribuciones (más outliers), se priorizó la inversión.

---

## Conclusiones principales

A través de los datos observados y la exploración de las variables, notamos que en el caso de las inversiones,
cuyo registro —del que se dispone en este trabajo— comienza en 2013, no hubo un desvío sino una profundización
en el caudal de fondos destinados hacia la explotación no convencional en el caso de las principales empresas.
Dicho de otra forma, la composición o predominancia del tipo no convencional alcanzó niveles cercanos al 50%
en 2025 y si la tendencia continúa, como otras variables dependientes de la inversión parecen indicar, pronto
este tipo de explotación será el principal motor del sector hidrocarburífero.

Focalizando en los jugadores del sector, analizamos puntualmente el comportamiento de las siete principales
empresas productoras de petróleo sumando ambas cuencas. Quien lideró transición fue YPF, casi de inmediato a la
puesta en marcha de los proyectos de inversión y *rig contracts* (contratos entre el dueño de un yacimiento —el Estado
representado en YPF en este caso— y compañías perforadoras) ejecutados en 2014 con empresas como Chevron.

Los índices recabados sobre los pozos en perforación hablan claramente de un fenónemo que llegó para quedarse,
en desmedro de la actividad económica y reducción flujo operativo (exploración, servicio, mantenimiento, almacenamiento)
en la cuenca Golfo San Jorge. A su vez, estos índices pueden tomarse como proxy o indicador futuro de los pozos terminados
"mañana" (uno sucede al otro), acentuando esta tendencia.

Yendo al apartado productivo es de notar que si bien la inversión en la cuenca Neuquina siempre fue a mayor a la
del Golfo San Jorge desde que comenzó su registro, esto no se trasladó a los niveles de producción de inmediato,
sino que hubo un crecimiento gradual en la cuenca Neuquina que en 2016—2017 marcó un quiebre que se confirmó en
los años venideros.

## Releases

En el apartado de *releases* ("liberaciones") se halla el snapshot del repositorio en el momento exacto de la entrega final de este proyecto para su evaluación por el docente, titulado **Entrega final 2026-06-30**, bajo el **tag v1.0.0**.

No obstante, este proyecto continuará a fin de servir como material de portfolio, siguiendo una metodología basada en la convención ***Semantic Versioning (SemVer):***

```
v1.0.0
 │ │ └── Patch: corrección de bugs, pequeñas mejoras en general (documentación, formato, etc.)
 │ └──── Minor: nuevos análisis y/o funcionalidades (scripts, gráficos, dashboards, etc.), mejor compatibilidad
 └────── Major: cambios de enfoque y/o rediseño del proyecto importantes
```

Por ejemplo:

```
v1.0.0   # Entrega final para la materia
v1.0.1   # Corrección de error de tipeo en README
v1.0.2   # Mejores instrucciones de reproducibilidad
v1.1.0   # Nuevas visualizaciones y análisis
v1.2.0   # Web App
v2.0.0   # Rediseño grande del proyecto
```