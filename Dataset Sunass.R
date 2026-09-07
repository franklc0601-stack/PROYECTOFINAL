# ============================================================
# PROYECTO FINAL - ANÁLISIS EXPLORATORIO DE DATOS (EDA)
# Base de datos: Registro de Interrupciones del Servicio de Agua (SUNASS)
# Autor: Frank Gerson Lisonde Chocca - Economía (UNCP)
# Formato: EXCEL (.xlsx)
# ============================================================

# ============================================================
# 1. CONFIGURACIÓN INICIAL Y PAQUETES
# ============================================================

# 1.1 LIMPIAR EL ENTORNO
rm(list = ls())  
gc()             

# 1.2 INSTALACIÓN AUTOMÁTICA Y CARGA DE PAQUETES
# Agregamos "readxl" para procesar datos de Excel
paquetes <- c("tidyverse", "lubridate", "patchwork", "psych", "scales", "readxl")

for (p in paquetes) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p, dependencies = TRUE)
    library(p, character.only = TRUE)
  }
}

# ============================================================
# 2. IMPORTAR DATOS DESDE EXCEL
# ============================================================

# IMPORTANTE: Reemplaza "TU_ARCHIVO.xlsx" con el nombre real de tu archivo
ruta_excel <- "C:/Users/frank/Downloads/R/TU_ARCHIVO.xlsx"

# Leer el archivo Excel
datos_completos <- read_excel(ruta_excel)

# Renombrar primera columna por seguridad
names(datos_completos)[1] <- "IDINTERRUPCION"

print("=== ESTRUCTURA DEL DATASET ===")
glimpse(datos_completos)
print(paste("Dimensiones:", dim(datos_completos)[1], "filas y", dim(datos_completos)[2], "columnas"))

# ============================================================
# 3. FILTRAR DATOS DE LA REGIÓN JUNÍN
# ============================================================

junin <- datos_completos %>%
  filter(DEPARTAMENTO == "JUNIN")

print(paste("Observaciones de Junín extraídas:", dim(junin)[1], "filas"))

# ============================================================
# 4. TRANSFORMACIÓN Y CREACIÓN DE NUEVAS VARIABLES 
# ============================================================

eda_junin <- junin %>%
  mutate(
    FECHA_INICIO = ymd(as.character(FECHAINICIO)),
    FECHA_FIN = ymd(as.character(FECHAFIN)),
    
    TIPOINTERRUPCION = str_to_title(TIPOINTERRUPCION),
    
    DATETIME_INICIO = ymd_hm(paste(FECHAINICIO, HORAINICIO)),
    DATETIME_FIN = ymd_hm(paste(FECHAFIN, HORAFIN)),
    DURACION_HORAS = as.numeric(difftime(DATETIME_FIN, DATETIME_INICIO, units = "hours")),
    
    IMPACTO_CATEGORIA = case_when(
      NUMCONEXDOM < 500 ~ "Impacto Bajo",
      NUMCONEXDOM >= 500 & NUMCONEXDOM <= 2500 ~ "Impacto Medio",
      NUMCONEXDOM > 2500 ~ "Impacto Severo",
      TRUE ~ "Sin datos"
    ),
    
    LOG_CONEXIONES = log(NUMCONEXDOM + 1)
  )

eda_analisis <- eda_junin %>%
  filter(!is.na(NUMCONEXDOM), NUMCONEXDOM > 0, DURACION_HORAS > 0, IMPACTO_CATEGORIA != "Sin datos")

print(paste("Observaciones válidas para graficar:", nrow(eda_analisis)))

# ============================================================
# 5. ESTADÍSTICAS DESCRIPTIVAS
# ============================================================

tabla_tipo <- eda_analisis %>%
  group_by(TIPOINTERRUPCION) %>%
  summarise(
    Eventos = n(),
    Promedio_Horas = mean(DURACION_HORAS, na.rm = TRUE),
    Promedio_Conexiones = mean(NUMCONEXDOM, na.rm = TRUE),
    Total_Afectados = sum(NUMCONEXDOM, na.rm = TRUE)
  )
print("=== RESUMEN POR TIPO DE CORTE ===")
print(tabla_tipo)

# ============================================================
# 6. VISUALIZACIÓN DE DATOS CON GGPLOT2
# ============================================================
# Establecer el directorio de trabajo para guardar los archivos
setwd("C:/Users/frank/Downloads/R") 

if (!dir.exists("figures")) dir.create("figures")
if (!dir.exists("data_exportada")) dir.create("data_exportada")

# --- GRÁFICO 1: DISTRIBUCIÓN DEL IMPACTO ---
media_conex <- mean(eda_analisis$LOG_CONEXIONES, na.rm = TRUE)
mediana_conex <- median(eda_analisis$LOG_CONEXIONES, na.rm = TRUE)
limite_conex <- quantile(eda_analisis$LOG_CONEXIONES, 0.98, na.rm = TRUE)

grafico1 <- ggplot(eda_analisis, aes(x = LOG_CONEXIONES)) +
  geom_histogram(bins = 30, fill = "#2E86AB", color = "white", alpha = 0.8) +
  geom_vline(aes(xintercept = media_conex), color = "#A23B72", linetype = "dashed", linewidth = 1.2) +
  geom_vline(aes(xintercept = mediana_conex), color = "#F18F01", linetype = "dotted", linewidth = 1.2) +
  scale_x_continuous(limits = c(0, limite_conex)) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Distribución de Conexiones Afectadas",
    subtitle = paste0("Escala Logarítmica | Media: ", round(media_conex, 2), " | Mediana: ", round(mediana_conex, 2)),
    x = "Log(Conexiones Domiciliarias)",
    y = "Frecuencia",
    caption = "Fuente: SUNASS (Excel)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5, color = "#1B4965"),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "#4A4A4A"),
    panel.grid.minor = element_blank()
  )

# --- GRÁFICO 2: DURACIÓN VS IMPACTO ---
correlacion <- cor(eda_analisis$DURACION_HORAS, eda_analisis$NUMCONEXDOM, use = "complete.obs")

grafico2 <- ggplot(eda_analisis, aes(x = DURACION_HORAS, y = NUMCONEXDOM)) +
  geom_point(alpha = 0.4, color = "#2E86AB", size = 2) +
  geom_smooth(method = "lm", color = "#A23B72", fill = "#A23B72", alpha = 0.2) +
  scale_y_continuous(labels = scales::comma) +
  labs(
    title = "Eficiencia Operativa: Duración vs Impacto",
    subtitle = paste0("Correlación (r) = ", round(correlacion, 3)),
    x = "Duración del Corte (Horas)",
    y = "Conexiones Inhabilitadas"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5, color = "#1B4965"),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "#4A4A4A"),
    panel.grid.minor = element_blank()
  )

# --- GRÁFICO 3: IMPACTO POR CATEGORÍA ---
estadisticas_impacto <- eda_analisis %>%
  group_by(IMPACTO_CATEGORIA) %>%
  summarise(
    N = n(),
    Media = mean(NUMCONEXDOM, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  mutate(IMPACTO_CATEGORIA = factor(IMPACTO_CATEGORIA, levels = c("Impacto Bajo", "Impacto Medio", "Impacto Severo")))

grafico3 <- ggplot(estadisticas_impacto, aes(x = IMPACTO_CATEGORIA, y = Media, fill = IMPACTO_CATEGORIA)) +
  geom_col(alpha = 0.85, width = 0.6) +
  geom_text(aes(label = comma(round(Media, 0))), vjust = -0.5, fontface = "bold", size = 4.5) +
  scale_y_continuous(labels = scales::comma, expand = expansion(mult = c(0, 0.15))) +
  scale_fill_manual(values = c("Impacto Bajo" = "#1B4965", "Impacto Medio" = "#2E86AB", "Impacto Severo" = "#A23B72")) +
  labs(
    title = "Conexiones Promedio por Nivel de Impacto",
    subtitle = "Diferenciación de magnitud en fallas de servicio",
    x = "Nivel de Severidad",
    y = "Promedio de Hogares Afectados"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5, color = "#1B4965"),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "#4A4A4A"),
    legend.position = "none",
    panel.grid.minor = element_blank()
  )

# ============================================================
# 7. ENSAMBLAJE FINAL (PATCHWORK) Y EXPORTACIÓN
# ============================================================

collage_final <- (grafico1 + grafico2) / grafico3 +
  plot_annotation(
    title = "EDA: Interrupciones del Servicio de Agua en Junín",
    subtitle = "Análisis de distribución, eficiencia de reparación y severidad de cortes",
    caption = "Elaboración propia | Data: SUNASS",
    theme = theme(
      plot.title = element_text(size = 18, face = "bold", hjust = 0.5, color = "#1B4965"),
      plot.subtitle = element_text(size = 14, hjust = 0.5, color = "#4A4A4A"),
      plot.background = element_rect(fill = "white", color = NA)
    )
  )

print(collage_final)

ggsave("figures/grafico_01.png", plot = grafico1, width = 10, height = 7, dpi = 300)
ggsave("figures/grafico_02.png", plot = grafico2, width = 10, height = 7, dpi = 300)
ggsave("figures/grafico_03.png", plot = grafico3, width = 10, height = 7, dpi = 300)
ggsave("figures/collage_dashboard_final.png", plot = collage_final, width = 14, height = 12, dpi = 300)
write.csv(tabla_tipo, "data_exportada/resumen_tipo_corte.csv", row.names = FALSE)

print("=== SCRIPT COMPLETADO: Todos los gráficos han sido exportados a C:/Users/frank/Downloads/R/figures ===")