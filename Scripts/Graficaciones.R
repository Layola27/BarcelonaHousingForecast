# Instalar y cargar paquetes necesarios
# Si no los tienes instalados, descomenta las siguientes líneas:
# install.packages("readr")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("stringr") # Para manipulación de strings en la limpieza de 'floor'
# install.packages("forcats") # Para fct_infreq y fct_reorder

library(readr)
library(dplyr)
library(ggplot2)
library(stringr)
library(forcats) # Asegurarse de que forcats está cargado

# --- 1. Cargar el conjunto de datos ---
# Asegúrate de que el archivo CSV esté en tu directorio de trabajo o proporciona la ruta completa.
file_path <- "pisosBarcelona-21-04-2025-clean-muestra.csv"
tryCatch({
  datos_pisos <- read_csv(file_path)
}, error = function(e) {
  stop("Error al cargar el archivo CSV. Asegúrate de que la ruta '", file_path, "' es correcta y el archivo existe. Detalles del error: ", e$message)
})

print("Dimensiones del dataset cargado:")
print(dim(datos_pisos))
print("Primeras filas del dataset:")
print(head(datos_pisos))
print("Resumen del dataset:")
print(summary(datos_pisos))

# --- 2. Limpieza y Preparación de Datos ---

# Renombrar columnas para mayor claridad y uso en R (evitar espacios, usar snake_case)
datos_pisos <- datos_pisos %>%
  rename(
    area_construida_m2 = size,
    n_habitaciones = rooms,
    n_banos = bathrooms,
    tipo_propiedad = propertyType,
    precio = price,
    tiene_ascensor = hasLift,
    es_exterior = exterior,
    es_obra_nueva = newDevelopment,
    tiene_parking = hasParking,
    parking_incluido = isParkingIncludedInPrice,
    nombre_barrio = neighborhood,
    nombre_distrito = district,
    nombre_municipio = municipality,
    estado_conservacion = status
  )

# Limpieza de la columna 'floor'
# 'bj' (bajo) -> 0
# 'en' (entresuelo) -> 0.5 (valor numérico aproximado para ordenación)
# 'ss' (semisótano) -> -1
# 'Unknown' -> NA
# Valores numéricos se mantienen
datos_pisos <- datos_pisos %>%
  mutate(
    planta_numerica = case_when(
      tolower(floor) == "bj" ~ 0,
      tolower(floor) == "en" ~ 0.5,
      tolower(floor) == "ss" ~ -1,
      tolower(floor) == "unknown" ~ NA_real_,
      !is.na(suppressWarnings(as.numeric(floor))) ~ as.numeric(floor),
      TRUE ~ NA_real_
    )
  )

# Convertir columnas relevantes a factores con etiquetas más descriptivas
datos_pisos$tipo_propiedad <- factor(datos_pisos$tipo_propiedad)
datos_pisos$nombre_distrito <- factor(datos_pisos$nombre_distrito)
datos_pisos$nombre_municipio <- factor(datos_pisos$nombre_municipio)
datos_pisos$nombre_barrio <- factor(datos_pisos$nombre_barrio)
datos_pisos$estado_conservacion <- factor(datos_pisos$estado_conservacion,
                                       levels = c("good", "renew", "newdevelopment"),
                                       labels = c("Buen estado", "A reformar", "Obra nueva"))


# Convertir columnas booleanas (0/1) a factores
cols_booleanas <- c("tiene_ascensor", "es_obra_nueva", "tiene_parking", "parking_incluido", "hasVideo", "hasPlan", "has3DTour", "has360", "hasStaging")
for (col in cols_booleanas) {
  if (col %in% names(datos_pisos)) {
    # Asegurarse de que la columna existe antes de intentar convertirla
    if(all(unique(datos_pisos[[col]]) %in% c(0,1,NA))) { # Verificar que solo contenga 0, 1 o NA
        datos_pisos[[col]] <- factor(datos_pisos[[col]], levels = c(0, 1), labels = c("No", "Sí"))
    } else {
        print(paste("Advertencia: La columna", col, "contiene valores inesperados y no será convertida a factor binario."))
    }
  }
}

# La columna 'es_exterior' es TRUE/FALSE/Unknown. Convertir a factor.
if ("es_exterior" %in% names(datos_pisos)) {
    datos_pisos$es_exterior <- factor(
        ifelse(datos_pisos$es_exterior == "Unknown", NA, datos_pisos$es_exterior),
        levels = c("False", "True"), # Asegurarse que los niveles coinciden con los datos después de NA
        labels = c("Interior", "Exterior")
    )
}


# Crear columna de precio por metro cuadrado
datos_pisos <- datos_pisos %>%
  mutate(precio_por_m2 = ifelse(area_construida_m2 > 0, precio / area_construida_m2, NA))

# Usar el dataset completo para visualización, ya que el filtrado de outliers es opcional
datos_pisos_viz <- datos_pisos

print("Resumen del dataset después de la limpieza y preparación:")
print(summary(datos_pisos_viz))
print("Niveles de las variables categóricas importantes:")
if("es_exterior" %in% names(datos_pisos_viz) && "tiene_ascensor" %in% names(datos_pisos_viz)) {
    print(lapply(datos_pisos_viz[c("tipo_propiedad", "nombre_distrito", "nombre_municipio", "estado_conservacion", "tiene_ascensor", "es_exterior")], function(x) if(is.factor(x)) levels(x) else "No es factor"))
} else {
    print(lapply(datos_pisos_viz[c("tipo_propiedad", "nombre_distrito", "nombre_municipio", "estado_conservacion")], function(x) if(is.factor(x)) levels(x) else "No es factor"))
}


# --- 3. Generación de Visualizaciones ---

theme_set(theme_minimal(base_size = 12) +
            theme(
              plot.title = element_text(hjust = 0.5, face = "bold"),
              axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
              legend.position = "top"
            ))

# A. Distribuciones de variables numéricas

# Histograma del Precio
p_hist_precio <- ggplot(datos_pisos_viz, aes(x = precio)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = 50000, fill = "skyblue", color = "black", alpha = 0.7) +
  geom_density(alpha = .2, fill = "#FF6666") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Distribución de Precios", x = "Precio (€)", y = "Densidad")
print(p_hist_precio)

# Histograma del Área Construida
p_hist_area <- ggplot(datos_pisos_viz, aes(x = area_construida_m2)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = 10, fill = "lightgreen", color = "black", alpha = 0.7) +
  geom_density(alpha = .2, fill = "#FF6666") +
  labs(title = "Distribución del Área Construida", x = "Área (m²)", y = "Densidad")
print(p_hist_area)

# Histograma del Precio por m²
p_hist_precio_m2 <- ggplot(filter(datos_pisos_viz, !is.na(precio_por_m2)), aes(x = precio_por_m2)) +
  geom_histogram(aes(y = after_stat(density)), binwidth = 500, fill = "salmon", color = "black", alpha = 0.7) +
  geom_density(alpha = .2, fill = "#66CCFF") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Distribución del Precio por m²", x = "Precio por m² (€/m²)", y = "Densidad")
print(p_hist_precio_m2)

# Histograma del Número de Habitaciones
p_hist_habitaciones <- ggplot(datos_pisos_viz, aes(x = n_habitaciones)) +
  geom_histogram(binwidth = 1, fill = "cornflowerblue", color = "black", alpha = 0.7) +
  scale_x_continuous(breaks = seq(min(datos_pisos_viz$n_habitaciones, na.rm=T), max(datos_pisos_viz$n_habitaciones, na.rm=T), by = 1)) +
  labs(title = "Distribución del Número de Habitaciones", x = "Número de Habitaciones", y = "Frecuencia")
print(p_hist_habitaciones)

# Histograma del Número de Baños
p_hist_banos <- ggplot(datos_pisos_viz, aes(x = n_banos)) +
  geom_histogram(binwidth = 1, fill = "gold", color = "black", alpha = 0.7) +
  scale_x_continuous(breaks = seq(min(datos_pisos_viz$n_banos, na.rm=T), max(datos_pisos_viz$n_banos, na.rm=T), by = 1)) +
  labs(title = "Distribución del Número de Baños", x = "Número de Baños", y = "Frecuencia")
print(p_hist_banos)

# B. Gráficos de barras para variables categóricas

# Conteo por Tipo de Propiedad
p_bar_tipo_propiedad <- ggplot(datos_pisos_viz, aes(x = fct_infreq(tipo_propiedad), fill = tipo_propiedad)) +
  geom_bar(color = "black", alpha = 0.8) +
  geom_text(stat='count', aes(label=after_stat(count)), vjust=-0.5) +
  labs(title = "Número de Propiedades por Tipo", x = "Tipo de Propiedad", y = "Cantidad") +
  theme(legend.position = "none")
print(p_bar_tipo_propiedad)

# Conteo por Municipio
if (n_distinct(datos_pisos_viz$nombre_municipio, na.rm = TRUE) > 1) {
  p_bar_municipio <- ggplot(filter(datos_pisos_viz, !is.na(nombre_municipio)), aes(x = fct_infreq(nombre_municipio), fill = nombre_municipio)) +
    geom_bar(color = "black", alpha = 0.8) +
    geom_text(stat='count', aes(label=after_stat(count)), vjust=-0.5) +
    labs(title = "Número de Propiedades por Municipio", x = "Municipio", y = "Cantidad") +
    theme(legend.position = "none", axis.text.x = element_text(angle = 25, hjust = 1))
  print(p_bar_municipio)
}

# Conteo por Distrito (Top N distritos)
top_n_distritos <- 10
conteo_distritos <- datos_pisos_viz %>%
  filter(!is.na(nombre_distrito)) %>%
  count(nombre_distrito, sort = TRUE) %>%
  slice_head(n = top_n_distritos) # Usar slice_head para dplyr >= 1.0.0

datos_distritos_top_n <- datos_pisos_viz %>%
  filter(nombre_distrito %in% conteo_distritos$nombre_distrito)

if (nrow(datos_distritos_top_n) > 0) {
    p_bar_distrito <- ggplot(datos_distritos_top_n, aes(x = fct_reorder(nombre_distrito, nombre_distrito, function(x) -length(x)), fill = nombre_distrito)) +
    geom_bar(color = "black", alpha = 0.8) +
    geom_text(stat='count', aes(label=after_stat(count)), vjust=-0.5) +
    labs(title = paste("Número de Propiedades por Distrito (Top", top_n_distritos, ")"), x = "Distrito", y = "Cantidad") +
    theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))
  print(p_bar_distrito)
}

# Conteo por Estado de Conservación
p_bar_estado <- ggplot(filter(datos_pisos_viz, !is.na(estado_conservacion)), aes(x = estado_conservacion, fill = estado_conservacion)) +
  geom_bar(color = "black", alpha = 0.8) +
  geom_text(stat='count', aes(label=after_stat(count)), vjust=-0.5) +
  labs(title = "Estado de Conservación de las Propiedades", x = "Estado", y = "Cantidad") +
  theme(legend.position = "none")
print(p_bar_estado)

# C. Box plots

# Precio por Tipo de Propiedad
p_box_precio_tipo <- ggplot(datos_pisos_viz, aes(x = tipo_propiedad, y = precio, fill = tipo_propiedad)) +
  geom_boxplot(alpha = 0.8, outlier.shape = NA) +
  geom_jitter(width = 0.2, alpha = 0.3, size=1.5, color="grey30") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Precio por Tipo de Propiedad", x = "Tipo de Propiedad", y = "Precio (€)") +
  theme(legend.position = "none")
print(p_box_precio_tipo)

# Precio por Número de Habitaciones
p_box_precio_habitaciones <- ggplot(filter(datos_pisos_viz, n_habitaciones > 0 & n_habitaciones < 8), aes(x = factor(n_habitaciones), y = precio, fill = factor(n_habitaciones))) +
  geom_boxplot(alpha = 0.8, outlier.shape = NA) +
  geom_jitter(width = 0.2, alpha = 0.3, size=1.5, color="grey30") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Precio por Número de Habitaciones", x = "Número de Habitaciones", y = "Precio (€)") +
  theme(legend.position = "none")
print(p_box_precio_habitaciones)

# Precio por si Tiene Ascensor
if ("tiene_ascensor" %in% names(datos_pisos_viz) && is.factor(datos_pisos_viz$tiene_ascensor)) {
  p_box_precio_ascensor <- ggplot(filter(datos_pisos_viz, !is.na(tiene_ascensor)), aes(x = tiene_ascensor, y = precio, fill = tiene_ascensor)) +
    geom_boxplot(alpha = 0.8, outlier.shape = NA) +
    geom_jitter(width = 0.2, alpha = 0.3, size=1.5, color="grey30") +
    scale_y_continuous(labels = scales::comma) +
    labs(title = "Precio vs. Existencia de Ascensor", x = "¿Tiene Ascensor?", y = "Precio (€)") +
    theme(legend.position = "none")
  print(p_box_precio_ascensor)
}

# Precio por si es Exterior
if ("es_exterior" %in% names(datos_pisos_viz) && is.factor(datos_pisos_viz$es_exterior)) {
  p_box_precio_exterior <- ggplot(filter(datos_pisos_viz, !is.na(es_exterior)), aes(x = es_exterior, y = precio, fill = es_exterior)) +
    geom_boxplot(alpha = 0.8, outlier.shape = NA) +
    geom_jitter(width = 0.2, alpha = 0.3, size=1.5, color="grey30") +
    scale_y_continuous(labels = scales::comma) +
    labs(title = "Precio vs. Si es Exterior/Interior", x = "Tipo", y = "Precio (€)") +
    theme(legend.position = "none")
  print(p_box_precio_exterior)
}

# Precio por m² por Tipo de Propiedad
p_box_preciom2_tipo <- ggplot(filter(datos_pisos_viz, !is.na(precio_por_m2)), aes(x = tipo_propiedad, y = precio_por_m2, fill = tipo_propiedad)) +
  geom_boxplot(alpha = 0.8, outlier.shape = NA) +
  geom_jitter(width = 0.2, alpha = 0.3, size=1.5, color="grey30") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Precio por m² por Tipo de Propiedad", x = "Tipo de Propiedad", y = "Precio por m² (€/m²)") +
  theme(legend.position = "none")
print(p_box_preciom2_tipo)

# Precio por m² por Distrito (Top N)
if (nrow(datos_distritos_top_n) > 0 && "precio_por_m2" %in% names(datos_distritos_top_n)) {
  p_box_preciom2_distrito <- ggplot(filter(datos_distritos_top_n, !is.na(precio_por_m2)), aes(x = fct_reorder(nombre_distrito, precio_por_m2, .fun=median, .desc=TRUE), y = precio_por_m2, fill = nombre_distrito)) +
    geom_boxplot(alpha = 0.8, outlier.shape = NA) +
    scale_y_continuous(labels = scales::comma) +
    labs(title = paste("Precio por m² por Distrito (Top", top_n_distritos, ")"), x = "Distrito", y = "Precio por m² (€/m²)") +
    theme(legend.position = "none", axis.text.x = element_text(angle = 30, hjust = 1))
  print(p_box_preciom2_distrito)
}

# D. Scatter plots

# Precio vs. Área Construida
p_scatter_precio_area <- ggplot(datos_pisos_viz, aes(x = area_construida_m2, y = precio)) +
  geom_point(aes(color = tipo_propiedad), alpha = 0.6, size = 2) +
  geom_smooth(method = "lm", color = "red", se = FALSE, formula = y ~ x) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Precio vs. Área Construida",
       x = "Área Construida (m²)",
       y = "Precio (€)",
       color = "Tipo Propiedad") +
  theme(legend.position = "right")
print(p_scatter_precio_area)

# Precio vs. Área Construida, facetado por tipo de propiedad
p_scatter_precio_area_facet <- ggplot(datos_pisos_viz, aes(x = area_construida_m2, y = precio)) +
  geom_point(aes(color = nombre_distrito), alpha = 0.6, size = 2, show.legend = FALSE) +
  geom_smooth(method = "lm", color = "blue", se = FALSE, formula = y ~ x) +
  scale_y_continuous(labels = scales::comma) +
  scale_x_continuous(labels = scales::comma) +
  facet_wrap(~ tipo_propiedad, scales = "free", ncol = 2) +
  labs(title = "Precio vs. Área Construida por Tipo de Propiedad",
       x = "Área Construida (m²)",
       y = "Precio (€)")
print(p_scatter_precio_area_facet)

# Visualización de la columna 'planta_numerica'
if ("planta_numerica" %in% names(datos_pisos_viz)) {
    p_hist_planta <- ggplot(filter(datos_pisos_viz, !is.na(planta_numerica)), aes(x = planta_numerica)) +
    geom_histogram(binwidth = 1, fill="orchid", color="black", alpha=0.7) +
    labs(title="Distribución de Plantas (Numérica)", x="Planta (0=Bajo, 0.5=Entresuelo)", y="Frecuencia")
  print(p_hist_planta)

  p_box_precio_planta <- ggplot(filter(datos_pisos_viz, !is.na(planta_numerica) & planta_numerica < 10), aes(x = factor(planta_numerica), y = precio, fill=factor(planta_numerica))) +
    geom_boxplot(alpha = 0.8, outlier.shape = NA) +
    geom_jitter(width = 0.2, alpha = 0.3, size=1.5, color="grey30") +
    scale_y_continuous(labels = scales::comma) +
    labs(title="Precio por Planta (Numérica, <10)", x="Planta", y="Precio (€)") +
    theme(legend.position = "none")
  print(p_box_precio_planta)
}

# --- Fin del Script ---
print("El script de visualización ha finalizado. Revisa los gráficos generados.")

# Consideraciones adicionales para un dataset más grande:
# 1. Para variables categóricas con muchos niveles (ej. 'nombre_barrio'), considera agrupar los menos frecuentes en una categoría "Otros" o visualizar solo los Top N.
# 2. El filtrado de outliers puede ser más sofisticado.
# 3. Podrías querer guardar los gráficos en archivos (e.g., usando ggsave()).
#    Ejemplo: ggsave("histograma_precio.png", plot = p_hist_precio, width = 8, height = 6)
