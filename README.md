# Análisis Exploratorio de las Interrupciones del Servicio de Agua - SUNASS

## Descripción del Proyecto

Este proyecto desarrolla un **Análisis Exploratorio de Datos (EDA)** del **Registro de Interrupciones del Servicio de Agua**, utilizando información registrada por la **Superintendencia Nacional de Servicios de Saneamiento (SUNASS)**.

El objetivo es identificar y comprender los principales patrones relacionados con las interrupciones del servicio, considerando su **frecuencia, duración, causas, tipo de servicio, distribución geográfica, empresas prestadoras y cantidad de usuarios afectados**.

Mediante técnicas de estadística descriptiva y visualización de datos se busca obtener información relevante que permita comprender el comportamiento de las interrupciones del servicio de agua.

---

##  Autor

**Frank Gerson Lisonde Chocca**

**Carrera:** Economía  
**Universidad:** Universidad Nacional del Centro del Perú (UNCP)

---

# Objetivos del Proyecto

## Objetivo General

Realizar un **Análisis Exploratorio de Datos (EDA)** sobre las interrupciones del servicio de agua registradas por SUNASS, con la finalidad de identificar sus principales características, causas, duración y patrones temporales y geográficos.

## Objetivos Específicos

1. **Analizar** la frecuencia de las interrupciones según su tipo.
2. **Identificar** los principales motivos de interrupción del servicio.
3. **Analizar** la distribución de la duración de las interrupciones.
4. **Identificar** las empresas prestadoras con mayor cantidad de interrupciones.
5. **Analizar** la distribución geográfica de las interrupciones.
6. **Explorar** el comportamiento temporal de las interrupciones.
7. **Analizar** la cantidad de conexiones domiciliarias y unidades de uso afectadas.
8. **Identificar** valores extremos y datos faltantes.
9. **Generar visualizaciones** que permitan comunicar los principales resultados del análisis.

---

#  Pregunta de Investigación

> **¿Cuáles son las principales características, causas, duración y patrones temporales y geográficos de las interrupciones del servicio de agua registradas por SUNASS?**

### Hipótesis

> **Las interrupciones imprevistas representan la mayor proporción de los eventos registrados y están relacionadas principalmente con problemas en la infraestructura del sistema de agua potable.**

---

#  Base de Datos

La base de datos corresponde al **Registro de Interrupciones del Servicio de Agua de SUNASS**.

La base original contiene:

- **45,671 registros**
- **16 variables**

### Principales Variables

| Variable | Descripción |
|---|---|
| `IDINTERRUPCION` | Identificador de la interrupción |
| `EPS` | Empresa Prestadora de Servicios |
| `SEDE` | Sede de la empresa |
| `TIPOINTERRUPCION` | Tipo de interrupción |
| `TIPOSERVICIO` | Tipo de servicio afectado |
| `MOTIVOINTERRUPCION` | Motivo de la interrupción |
| `FECHAINICIO` | Fecha de inicio |
| `HORAINICIO` | Hora de inicio |
| `FECHAFIN` | Fecha de finalización |
| `HORAFIN` | Hora de finalización |
| `DEPARTAMENTO` | Departamento |
| `PROVINCIA` | Provincia |
| `DISTRITO` | Distrito |
| `NUMCONEXDOM` | Número de conexiones domiciliarias |
| `UNIDADESUSO` | Número de unidades de uso |
| `NUMCAMIONESPUNTOS` | Número de camiones/puntos |

---

#  Limpieza y Preparación de los Datos

Para el análisis se realizaron las siguientes actividades:

- Importación de la base de datos en formato Excel.
- Estandarización de nombres de variables.
- Eliminación de espacios innecesarios.
- Conversión de textos a mayúsculas.
- Conversión de fechas y horas.
- Cálculo de la duración de cada interrupción.
- Creación de variables temporales:
  - Año
  - Mes
  - Número de mes
  - Día de la semana
  - Trimestre
- Conversión de variables categóricas a factores.
- Identificación de valores faltantes.
- Identificación de valores extremos.
- Filtrado de duraciones superiores a 30 días para evitar distorsiones en el análisis.

---

#  Principales Hallazgos del EDA

## 1. Tipo de Interrupción

| Tipo | Frecuencia | Porcentaje |
|---|---:|---:|
| **Imprevista** | 34,693 | **76%** |
| **Programada** | 10,938 | **24%** |
| **Total** | **45,631** | **100%** |

### Interpretación

Las interrupciones **imprevistas representan el 76%** del total, mientras que las programadas representan el 24%.

Esto significa que aproximadamente **3 de cada 4 interrupciones son imprevistas**, lo que evidencia la importancia de analizar las causas asociadas a fallas no planificadas.

---

#  2. Tipo de Servicio

| Servicio | Frecuencia | Porcentaje |
|---|---:|---:|
| **Agua potable** | 44,941 | **98%** |
| **Alcantarillado** | 690 | **2%** |
| **Total** | **45,631** | **100%** |

### Interpretación

El **98% de las interrupciones** corresponde al servicio de **agua potable**, mientras que solamente el 2% corresponde al servicio de alcantarillado.

Por lo tanto, el análisis se concentra principalmente en la continuidad del servicio de agua potable.

---

# 🔧 3. Principales Motivos de Interrupción

| Motivo | Frecuencia | Porcentaje |
|---|---:|---:|
| Rotura de tubería de agua potable | 13,136 | 28.79% |
| Fuga en conexión | 8,446 | 18.51% |
| Otros | 6,084 | 13.33% |
| Limpieza y desinfección de reservorio/cisterna | 5,553 | 12.17% |
| Rotura de tubería por tercero | 3,577 | 7.84% |
| Ejecución de empalme | 2,158 | 4.73% |
| Cambio de válvula | 1,400 | 3.07% |
| Problemas en colectores | 1,096 | 2.40% |
| Corte de servicio de electricidad | 865 | 1.90% |
| Trabajos de mejoramiento/rehabilitación | 764 | 1.67% |

### Interpretación

La principal causa registrada es la **rotura de tubería de agua potable**, con **28.79%** de las interrupciones.

La segunda causa corresponde a las **fugas en conexiones**, con **18.51%**.

Estos resultados muestran que los problemas relacionados con la infraestructura y las conexiones constituyen una parte importante de las interrupciones registradas.

---

#  4. Empresas Prestadoras con Mayor Número de Interrupciones

| EPS | Frecuencia | Porcentaje |
|---|---:|---:|
| **SEDAPAL** | 29,365 | **64.35%** |
| **SEDAPAR** | 4,898 | **10.73%** |
| **SEDA AYACUCHO** | 2,031 | **4.45%** |
| **SEDACUSCO** | 864 | **1.89%** |
| **EPS EMAPAT** | 702 | **1.54%** |
| **EPS GRAU** | 637 | **1.40%** |
| **EPS AGUAS DE LIMA NORTE** | 553 | **1.21%** |
| **SEDALIB** | 515 | **1.13%** |
| **AGUA TUMBES** | 475 | **1.04%** |
| **EMUSAP ABANCAY** | 428 | **0.94%** |

### Interpretación

**SEDAPAL concentra el 64.35% de los registros** analizados.

Esta concentración debe interpretarse considerando también el tamaño y la cobertura de cada empresa prestadora, debido a que una mayor cantidad de interrupciones no necesariamente significa una peor calidad del servicio.

---

#  5. Distribución por Departamento

| Departamento | Frecuencia | Porcentaje |
|---|---:|---:|
| **Lima** | 27,942 | **61.23%** |
| **Arequipa** | 4,898 | **10.73%** |
| **Callao** | 2,448 | **5.36%** |
| **Ayacucho** | 2,031 | **4.45%** |
| **Cusco** | 1,043 | **2.29%** |
| **Madre de Dios** | 702 | **1.54%** |
| **Ica** | 662 | **1.45%** |
| **Piura** | 637 | **1.40%** |
| **Moquegua** | 561 | **1.23%** |
| **Junín** | 531 | **1.16%** |

### Interpretación

Existe una importante concentración geográfica de las interrupciones.

**Lima concentra el 61.23%** de los registros, seguida por Arequipa con 10.73% y Callao con 5.36%.

Estos resultados deben analizarse considerando el número de conexiones y usuarios atendidos en cada departamento.

---

#  6. Duración de las Interrupciones

| Indicador | Resultado |
|---|---:|
| Observaciones | 45,631 |
| Promedio | **8.89 horas** |
| Mediana | **6.00 horas** |
| Desviación estándar | **21.03 horas** |
| Mínimo | **0 horas** |
| Máximo | **720 horas** |
| Asimetría | **19.52** |
| Curtosis | **522.93** |

### Interpretación

La duración presenta una distribución **fuertemente sesgada hacia la derecha**.

La duración promedio es de **8.89 horas**, mientras que la mediana es de **6 horas**.

La elevada asimetría y curtosis muestran la existencia de **valores extremos**, correspondientes a interrupciones con duraciones considerablemente superiores al comportamiento habitual.

Por esta razón, la **mediana** constituye una medida más representativa de la duración típica.

---

#  7. Conexiones Domiciliarias Afectadas

| Indicador | Resultado |
|---|---:|
| Observaciones disponibles | 22,562 |
| Promedio | 21,906.08 |
| Mediana | 1,500 |
| Mínimo | 0 |
| Máximo | 21,646,684 |
| Asimetría | 46.02 |
| Curtosis | 3,869.09 |

### Interpretación

La variable presenta una distribución extremadamente asimétrica.

Existe una gran diferencia entre la **media de 21,906 conexiones** y la **mediana de 1,500 conexiones**, lo que evidencia la presencia de valores extremos.

---

#  8. Unidades de Uso Afectadas

| Indicador | Resultado |
|---|---:|
| Observaciones disponibles | 22,562 |
| Promedio | 7,680.59 |
| Mediana | 1,358.5 |
| Mínimo | 0 |
| Máximo | 2,004,060 |
| Asimetría | 28.77 |
| Curtosis | 1,443.01 |

### Interpretación

Al igual que las conexiones domiciliarias, las unidades de uso presentan una elevada dispersión y valores extremos.

La diferencia entre promedio y mediana indica que unos pocos registros presentan cantidades excepcionalmente altas de unidades afectadas.

---

#  9. Valores Faltantes

| Variable | Valores faltantes |
|---|---:|
| `numcamionespuntos` | 43,329 |
| `numconexdom` | 23,069 |
| `unidadesuso` | 23,069 |
| `distrito` | 188 |
| `sede` | 1 |

### Interpretación

Los valores faltantes se concentran principalmente en las variables relacionadas con las conexiones, unidades de uso y camiones/puntos.

Estos valores deben considerarse al realizar análisis posteriores, debido a que pueden reducir el número de observaciones disponibles.

---

#  Análisis Temporal

Se realizó un análisis temporal para identificar patrones en:

- Interrupciones por mes.
- Interrupciones por día de la semana.
- Evolución de las interrupciones por año.
- Interrupciones programadas e imprevistas.

El análisis temporal permite identificar posibles períodos de mayor concentración de interrupciones y observar el comportamiento del fenómeno a través del tiempo.

---

# Análisis Geográfico

El análisis geográfico permitió identificar:

- Departamentos con mayor número de interrupciones.
- EPS con mayor cantidad de registros.
- Distribución de interrupciones programadas e imprevistas.
- Concentración territorial de los eventos.

Los resultados muestran una importante concentración de registros en **Lima**, tanto a nivel departamental como en relación con SEDAPAL.

---

#  Análisis Bivariado

## Duración según Tipo de Interrupción

Se utilizó un **boxplot** para comparar la distribución de la duración entre interrupciones programadas e imprevistas.

Este análisis permite identificar diferencias en la duración y detectar observaciones atípicas.

## Conexiones Afectadas según Motivo

También se analizó la cantidad de conexiones afectadas según los principales motivos de interrupción.

Esto permite identificar qué tipos de eventos están asociados con una mayor cantidad de conexiones potencialmente afectadas.

---

#  Visualizaciones

El proyecto contiene diferentes visualizaciones desarrolladas mediante `ggplot2`:

### Visualizaciones Univariadas

- Tipo de interrupción.
- Tipo de servicio.
- Principales motivos.
- Distribución de la duración.

### Visualizaciones Temporales

- Interrupciones por mes.
- Interrupciones por día de la semana.
- Interrupciones por año.

### Visualizaciones Geográficas

- Interrupciones por departamento.
- Interrupciones por EPS.
- Tipo de interrupción según departamento.

### Visualizaciones Bivariadas

- Duración según tipo de interrupción.
- Conexiones afectadas según motivo.

---

#  Tecnologías Utilizadas

## Lenguaje y Entorno

| Tecnología | Propósito |
|---|---|
| **R** | Análisis estadístico y procesamiento de datos |
| **RStudio** | Entorno de desarrollo |
| **Microsoft Excel** | Fuente de datos |

## Paquetes de R

| Paquete | Función |
|---|---|
| `tidyverse` | Manipulación y visualización de datos |
| `readxl` | Importación de archivos Excel |
| `lubridate` | Manejo de fechas y horas |
| `ggplot2` | Visualización de datos |
| `psych` | Estadística descriptiva |

---

#  Flujo del Proyecto

```text
Base de Datos SUNASS
        ↓
Importación de datos
        ↓
Exploración inicial
        ↓
Limpieza de datos
        ↓
Transformación de variables
        ↓
Tratamiento de fechas y horas
        ↓
Cálculo de duración
        ↓
Análisis de valores faltantes
        ↓
Estadística descriptiva
        ↓
Análisis de frecuencias
        ↓
Visualización de datos
        ↓
Análisis temporal
        ↓
Análisis geográfico
        ↓
Análisis bivariado
        ↓
Conclusiones y recomendaciones
