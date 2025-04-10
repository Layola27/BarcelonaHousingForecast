# 🏘️ Predicción de Precios de Viviendas en Barcelona con IA y Big Data

## 📌 Descripción del Proyecto

Este proyecto tiene como objetivo el desarrollo de un sistema inteligente capaz de **predecir los precios de viviendas en Barcelona** basándose en un análisis exhaustivo de sus características estructurales y de ubicación. Aprovechando tecnologías de inteligencia artificial y big data, el sistema permite obtener **estimaciones precisas y confiables** que pueden ser utilizadas por compradores, vendedores, agencias inmobiliarias y entidades financieras para la **toma de decisiones informadas**.

La solución combina técnicas de **procesamiento y análisis de datos**, **machine learning supervisado**, **visualización interactiva** y herramientas colaborativas para construir un flujo de trabajo integral, desde la recolección de datos hasta la entrega de resultados visuales.

## 🎯 Objetivos

- Analizar las características más influyentes en los precios de viviendas en Barcelona.
- Implementar modelos predictivos con algoritmos de IA.
- Visualizar los resultados a través de paneles interactivos.
- Facilitar la exploración de datos y predicciones mediante una interfaz web.
- Gestionar el desarrollo del proyecto de forma colaborativa y ágil.

---

## 🚀 Características del Proyecto

- Limpieza y preprocesamiento avanzado de datos.
- Análisis exploratorio de variables.
- Modelado predictivo con técnicas como regresión.
- Evaluación comparativa de modelos.
- Paneles dinámicos con visualizaciones en Power BI.
- Interfaz web para usuarios finales.
- Gestión ágil del proyecto con control de versiones y tareas.

---

## 🛠️ Tecnologías y Herramientas Utilizadas

| Herramienta / Lenguaje | Descripción |
|------------------------|-------------|
| **Python**             | Procesamiento de datos, modelado y scripts automatizados. |
| **R**                  | Análisis estadístico y validación de modelos. |
| **Orange Data Mining** | Prototipado visual de flujos de datos y modelos. |
| **Power BI**           | Dashboards y visualización de resultados. |
| **HTML + JavaScript (Bootstrap)** | Interfaz web responsiva para exploración de predicciones. |
| **PostgreSQL**         | Almacenamiento y gestión eficiente de datos estructurados. |
| **GitHub**             | Control de versiones y colaboración en equipo. |
| **Jira**               | Gestión ágil de tareas, sprints y documentación. |

---

## 🧠 Metodología General

1. **Obtención de datos**: Extracción de información de fuentes abiertas e internas.
2. **Limpieza y transformación**: Tratamiento de valores nulos, normalización y codificación.
3. **Análisis exploratorio (EDA)**: Visualización y descubrimiento de patrones relevantes.
4. **Entrenamiento de modelos**: Regresión lineal, random forest, XGBoost, redes neuronales, etc.
5. **Evaluación**: Métricas como MAE, RMSE, R² para comparar modelos.
6. **Visualización de resultados**: Dashboards y gráficos en Power BI.
7. **Despliegue parcial**: Presentación de resultados en entorno web.

---

![ChatGPT Image 10 abr 2025, 18_47_41](https://github.com/user-attachments/assets/2de13236-7fee-48e4-88db-0700255b4de4)


## 🔌 Obtención de Datos vía API

Para obtener los datos utilizados en este proyecto, se implementó un sistema automatizado de extracción utilizando la **API oficial de Idealista**. Este proceso permite acceder a información en tiempo real sobre propiedades inmobiliarias disponibles en Barcelona.

### ⚙️ Proceso de Autenticación

Idealista requiere autenticación basada en el protocolo **OAuth 2.0**. Para acceder a la API, se utilizan credenciales personales (API Key y API Secret), que deben ser **codificadas en Base64** y utilizadas para obtener un token de acceso temporal.

El flujo general es el siguiente:

1. Se realiza una solicitud `POST` al endpoint de autenticación (`/oauth/token`).
2. Se envía la combinación de clave y secreto en el encabezado `Authorization`.
3. La respuesta devuelve un `access_token` necesario para realizar las consultas.

> 🔒 **Importante:** Las credenciales son confidenciales y no se incluyen en el repositorio público. Se recomienda almacenarlas en variables de entorno o archivos de configuración excluidos mediante `.gitignore`.

### 🔍 Consulta de Propiedades

Una vez autenticado, se realiza una llamada `POST` al endpoint de búsqueda de propiedades, proporcionando parámetros como:

- **Tipo de operación**: `sale` (venta)
- **Tipo de propiedad**: `homes` (viviendas)
- **Ubicación**: coordenadas centrales de Barcelona
- **Radio de búsqueda**: hasta 15 km
- **Paginación**: automatizada para recorrer múltiples páginas
- **Orden**: publicaciones más recientes primero


## 🗂️ Descripción del Dataset

El proyecto se apoya en un conjunto de datos que contiene información detallada sobre anuncios de viviendas ubicadas en la ciudad de **Barcelona**. Cada registro representa una propiedad individual y está compuesto por múltiples características tanto estructurales como contextuales, fundamentales para el análisis y la predicción del precio de los inmuebles.

### 🔍 Principales Categorías de Información

- **Características físicas del inmueble**  
  Incluye variables como:
  - Superficie en metros cuadrados (`size`)
  - Número de habitaciones (`rooms`)
  - Número de baños (`bathrooms`)
  - Planta en la que se encuentra la propiedad (`floor`)
  - Tipo de propiedad (`propertyType`), como piso, ático, etc.

- **Ubicación geográfica**
  - Distrito y barrio dentro de la ciudad
  - Coordenadas geográficas (`latitude`, `longitude`)
  - Dirección y visibilidad pública de la misma (`showAddress`)

- **Datos económicos**
  - Precio total de la propiedad (`price`)
  - Precio por metro cuadrado (`priceByArea`)
  - Información relacionada con la oferta y variaciones de precio (`change`, `status`)

- **Estado del anuncio**
  - Tipo de operación (por ejemplo, venta)
  - Si la propiedad forma parte de una promoción de obra nueva (`newDevelopment`)
  - Si el anuncio es destacado o parte de una campaña especial (`highlight`, `topPlus`, etc.)

- **Atributos adicionales**
  - Ascensor (`hasLift`)
  - Espacio de parking (`parkingSpace`)
  - Disponibilidad de planos, tour 360°, staging virtual, etc.

- **Multimedia**
  - Número de fotos disponibles (`numPhotos`)
  - Miniatura del inmueble (`thumbnail`)
  - Descripción textual del anuncio (`description`)
  - Disponibilidad de video y otros medios visuales (`hasVideo`, `has3DTour`, etc.)

- **Identificadores y metadatos**
  - Código único de propiedad (`propertyCode`)
  - Referencia externa (`externalReference`)
  - URL del anuncio original

Este conjunto de datos ha sido limpiado y depurado para eliminar entradas duplicadas y estandarizar la representación de valores. Su estructura robusta lo convierte en una base confiable tanto para el análisis exploratorio como para la construcción de modelos de predicción.

> ⚠️ Nota: Algunas columnas contienen valores nulos, especialmente en campos opcionales o específicos de ciertos anuncios. Estos casos se gestionan durante las fases de preprocesamiento y modelado.
>
> ## 🔄 Proceso

Con el objetivo de ampliar la automatización, escalabilidad y capacidad de análisis del sistema, el proyecto ha sido actualizado con una serie de funcionalidades clave que optimizan todo el flujo de trabajo, desde la adquisición de datos hasta la visualización final:

### 🧹 1. Preprocesamiento Avanzado Automatizado

Se ha incorporado un módulo dedicado al preprocesamiento inteligente de los datos obtenidos a través de la API de Idealista. Este módulo realiza automáticamente:

- Validación de la estructura de los datos recibidos.
- Detección y tratamiento de valores nulos o inconsistentes.
- Conversión de tipos de datos (por ejemplo, fechas, booleanos y numéricos).
- Codificación de variables categóricas para su uso en modelos predictivos.
- Normalización y transformación de escalas si es necesario.
- Enriquecimiento de datos con nuevas variables derivadas, como densidad de precio por zona o ratios por número de habitaciones.

Este proceso permite estandarizar y optimizar los datos antes de ser almacenados, garantizando su integridad y calidad para usos posteriores.

### 🗄️ 2. Persistencia en Base de Datos PostgreSQL

Una vez preprocesados, los datos son almacenados en una base de datos relacional PostgreSQL. Este enfoque trae múltiples beneficios:

- Mejora el acceso concurrente y la escalabilidad del sistema.
- Permite ejecutar consultas SQL complejas para análisis exploratorios, filtrado y auditoría.
- Facilita el acceso desde herramientas externas como Power BI, Jupyter Notebook u otros clientes BI.
- Garantiza una trazabilidad completa de los datos históricos, esencial para estudios temporales o actualizaciones incrementales del modelo.

La base de datos se estructura en tablas normalizadas que representan entidades clave como propiedades, ubicaciones, precios históricos y predicciones realizadas.

### 🔁 3. Reentrenamiento Periódico del Modelo de Regresión Forest

Se ha implementado un mecanismo de aprendizaje continuo donde el modelo de predicción (basado en Random Forest Regressor) se actualiza automáticamente a medida que se incorporan nuevos datos en la base de datos. Esta funcionalidad incluye:

- Carga incremental de registros nuevos desde PostgreSQL.
- Reentrenamiento parcial o completo del modelo para adaptarse a cambios en el mercado inmobiliario.
- Validación cruzada automática y registro del desempeño (MAE, RMSE, R²).
- Almacenamiento del modelo entrenado mediante serialización (joblib/pickle) para su uso inmediato en la API o interfaz web.

Este enfoque garantiza que el modelo esté siempre actualizado con las últimas tendencias del mercado, manteniendo una alta precisión en las predicciones.

### 📊 4. Dashboard Interactivo con Power BI

Los datos alojados en PostgreSQL se vinculan directamente con Power BI para construir paneles de control interactivos, accesibles a usuarios no técnicos. El dashboard permite:

- Visualizar mapas dinámicos de precios por distrito y barrio.
- Filtrar propiedades por rango de superficie, número de habitaciones, planta o tipo de vivienda.
- Analizar la evolución temporal de los precios medios por zona.
- Explorar indicadores clave como el precio por m², la densidad de anuncios o la distribución de tipos de propiedad.
- Exportar visualizaciones o informes en PDF o Excel para toma de decisiones.

Gracias a esta capa de visualización, el sistema se convierte en una herramienta útil tanto para analistas como para usuarios finales (inversores, agentes inmobiliarios, compradores particulares).




