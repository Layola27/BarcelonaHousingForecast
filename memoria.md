# Memoria del Proyecto: Análisis y Pronóstico de Viviendas en Barcelona

**Fecha:** 14 de mayo de 2025
**Autor:** Gerard Layola Lopez
**Versión:** 1.2 (Formato mejorado y contenido completo)

---

## Resumen Ejecutivo

Este documento constituye la memoria técnica del proyecto "Análisis y Pronóstico de Viviendas en Barcelona". El proyecto se centra en la recopilación, procesamiento, análisis y modelado de datos del mercado inmobiliario de la ciudad de Barcelona con el objetivo de desarrollar un sistema capaz de predecir precios de viviendas y ofrecer insights valiosos.

Para ello, se ha implementado un flujo de trabajo completo que abarca desde la extracción de datos mediante la API de Idealista, su almacenamiento y gestión en una base de datos PostgreSQL con capacidades espaciales (PostGIS), hasta el preprocesamiento exhaustivo, la construcción de modelos de Machine Learning en Python (Scikit-learn), y la visualización de resultados.

El proyecto utiliza un stack tecnológico diverso, incluyendo:
* **Lenguajes y Frameworks:** Python (Pandas, NumPy, Joblib), SQL, R, FastAPI (para el backend), React (para el frontend).
* **Herramientas de Desarrollo:** Jupyter Notebooks, Visual Studio Code.
* **Base de Datos:** PostgreSQL con PostGIS.
* **Análisis y Visualización:** Orange, Power BI, Matplotlib, Seaborn.
* **LLM y Agentes:** Langchain con Google Gemini para consultas en lenguaje natural.

El resultado principal es un pipeline de predicción robusto (`pipeline_idealista_completo.joblib`), exportado para su uso en aplicaciones. Se describe un ejemplo de aplicación web (Frontend con React y Material-UI, Backend con FastAPI) que consume este modelo para ofrecer valoraciones interactivas y consultas en lenguaje natural a la base de datos mediante un agente LLM. Adicionalmente, los resultados pueden ser explorados mediante dashboards en Power BI y visualizaciones específicas en R.

Este documento detalla la metodología seguida, las herramientas empleadas, los resultados obtenidos y las posibles líneas de trabajo futuras.

---

# Abstract

This document details the technical aspects of the "Analysis and Forecasting of Housing in Barcelona" project.

**Main Objective:** The project focuses on gathering, processing, analyzing, and modeling real estate market data from Barcelona. The fundamental goal is to develop a system capable of predicting housing prices and providing valuable insights to stakeholders.

**Implemented Workflow:** A comprehensive workflow was implemented, spanning:
* Data extraction from the Idealista API.
* Storage and management in a spatially-enabled PostgreSQL database (PostGIS).
* Thorough data preprocessing.
* Machine Learning model building (using Python and Scikit-learn).
* Results visualization.

**Technologies Used:** The project leverages a diverse technology stack, including:
* **Data Languages and Tools:** Python, SQL, R, Jupyter Notebooks.
* **Frameworks and Libraries:** FastAPI, React, Scikit-learn, Matplotlib, Seaborn.
* **Databases:** PostgreSQL/PostGIS.
* **Visualization and BI Tools:** Orange, Power BI.
* **Natural Language Processing:** Langchain with Google Gemini for natural language queries.

**Core Outcome:** The central outcome is a robust prediction pipeline that enables a web application (React frontend, FastAPI backend). This application offers interactive valuations and natural language data queries.

**Presentation of Results:** Results are also presented via Power BI dashboards and R visualizations.

**Document Content:** The document describes the methodology, tools used, results obtained, and potential future work.

## Tabla de Contenidos

1.  **Introducción**
    1.1. Contexto y Justificación
    1.2. Objetivos del Proyecto
    1.3. Alcance del Proyecto
2.  **Herramientas y Tecnologías Utilizadas**
3.  **Metodología y Flujo de Trabajo**
    3.1. Descripción General del Flujo de Trabajo
    3.2. Fase 1: Adquisición y Recopilación de Datos
        3.2.1. Fuente de Datos: API de Idealista
        3.2.2. Proceso de Extracción
    3.3. Fase 2: Almacenamiento y Gestión de Datos
        3.3.1. Diseño de la Base de Datos PostgreSQL
        3.3.2. Carga y Actualización de Datos
        3.3.3. Optimización Espacial
    3.4. Fase 3: Análisis Exploratorio de Datos (EDA)
        3.4.1. EDA con Python y Jupyter Notebooks
        3.4.2. Uso de Orange para Análisis Visual
    3.5. Fase 4: Preprocesamiento de Datos
        3.5.1. Limpieza de Datos
        3.5.2. Transformación de Variables
        3.5.3. Ingeniería de Características (Feature Engineering)
    3.6. Fase 5: Modelado Predictivo
        3.6.1. Selección de Modelos de Machine Learning
        3.6.2. Entrenamiento y Validación
        3.6.3. Optimización de Hiperparámetros
        3.6.4. Evaluación del Modelo Final
    3.7. Fase 6: Exportación del Modelo
    3.8. Fase 7: Ejemplo de Uso del Modelo Desplegado (Aplicación Web)
        3.8.1. Frontend (Interfaz de Usuario)
        3.8.2. Backend (Servidor de Aplicación)
        3.8.3. Interacción Frontend-Backend
    3.9. Fase 8: Visualización de Resultados (Alternativa)
        3.9.1. Visualizaciones Avanzadas con R
        3.9.2. Dashboard Interactivo en Power BI
4.  **Estructura del Repositorio del Proyecto**
5.  **Resultados y Discusión**
    5.1. Principales Hallazgos del Análisis Exploratorio
    5.2. Rendimiento del Modelo Predictivo
    5.3. Análisis de Pronósticos
    5.4. Limitaciones del Estudio
6.  **Conclusiones**
7.  **Lecciones Aprendidas y Retos Superados**
8.  **Trabajos Futuros y Líneas de Mejora**
9.  **Referencias**
10. **Apéndices**
    10.1. Apéndice A: Esquema Detallado de la Base de Datos
    10.2. Apéndice B: Scripts SQL Clave
    10.3. Apéndice C: Métricas Detalladas de Evaluación del Modelo

## 1. Introducción

### 1.1. Contexto y Justificación

El mercado inmobiliario en grandes ciudades como Barcelona es un sistema complejo y dinámico, influenciado por múltiples factores socioeconómicos, demográficos y urbanísticos. Comprender las tendencias de precios, la distribución de la oferta y la demanda, y ser capaz de realizar pronósticos precisos sobre el valor de las viviendas es de crucial importancia para diversos actores: compradores, vendedores, inversores, promotores inmobiliarios y administraciones públicas.

Este proyecto surge de la necesidad de aplicar técnicas avanzadas de análisis de datos y Machine Learning para extraer conocimiento útil a partir de los datos de vivienda disponibles públicamente, con un enfoque específico en la ciudad de Barcelona. La capacidad de predecir precios y entender los factores que los determinan puede mejorar la toma de decisiones y la transparencia en el mercado, culminando en herramientas prácticas como una aplicación web de valoración.

### 1.2. Objetivos del Proyecto

#### Objetivo General
Desarrollar un sistema integral para el análisis y pronóstico de precios de viviendas en la ciudad de Barcelona, utilizando datos de Idealista y aplicando técnicas de Machine Learning, con la capacidad de servir el modelo resultante a través de una API para su consumo por aplicaciones externas y una presentación final de resultados mediante herramientas de Business Intelligence.

#### Objetivos Específicos
* Implementar un pipeline de adquisición automática de datos de viviendas en Barcelona desde la API de Idealista.
* Diseñar y gestionar una base de datos relacional (PostgreSQL) optimizada para almacenar y consultar eficientemente los datos recopilados, incluyendo información geoespacial.
* Realizar un Análisis Exploratorio de Datos (EDA) exhaustivo para identificar patrones, tendencias, correlaciones y posibles anomalías en los datos.
* Aplicar técnicas de preprocesamiento de datos para limpiar, transformar y preparar los datos para el modelado predictivo.
* Desarrollar, entrenar y evaluar diferentes modelos de Machine Learning para pronosticar el precio de las viviendas.
* Seleccionar y exportar el modelo con mejor rendimiento (`pipeline_idealista_completo.joblib`) para su uso en predicciones futuras.
* Demostrar el uso del modelo a través de una aplicación web interactiva (Frontend React, Backend FastAPI) que permita:
    * Introducir características de una vivienda y obtener una estimación de precio.
    * Realizar consultas en lenguaje natural a la base de datos mediante un agente LLM.
* Crear visualizaciones descriptivas y analíticas utilizando R (opcional, si complementa otras herramientas).
* Diseñar y construir un dashboard interactivo en Power BI (opcional, si se requiere una herramienta de BI específica).
* Documentar exhaustivamente todo el proceso, desde la concepción hasta la presentación de resultados.

### 1.3. Alcance del Proyecto

El proyecto abarca las siguientes fases y entregables principales:
* **Recopilación de Datos:** Uso de la API de Idealista.
* **Almacenamiento:** Base de datos PostgreSQL.
* **Análisis y Preprocesamiento:** Jupyter Notebooks (Python), Orange (opcional).
* **Modelado:** Python (Scikit-learn).
* **Exportación del Modelo:** Creación del archivo `pipeline_idealista_completo.joblib`.
* **Despliegue del Modelo (Ejemplo):**
    * Backend API (FastAPI) para servir el modelo y un agente LLM.
    * Frontend (React) para interacción del usuario y solicitud de predicciones.
* **Visualización (Alternativa/Complementaria):** R, Power BI.
* **Documentación:** `memoria.md`, `workflow.md`, `readme.md`.

No se incluye en el alcance de este proyecto el despliegue en un entorno de producción a gran escala con alta disponibilidad, ni el análisis de sentimiento avanzado a partir de descripciones de las viviendas, aunque podrían ser líneas de trabajo futuras.

---

## 2. Herramientas y Tecnologías Utilizadas

El proyecto ha empleado un conjunto diverso de herramientas y tecnologías, seleccionadas por su idoneidad para cada etapa del ciclo de vida del análisis de datos y el despliegue del modelo:

* **Python (v3.x):** Lenguaje de programación principal. Utilizado para:
    * Adquisición de datos (interacción con APIs).
    * Manipulación y preprocesamiento de datos (Pandas, NumPy).
    * Análisis exploratorio de datos.
    * Desarrollo y entrenamiento de modelos de Machine Learning (Scikit-learn).
    * Serialización de modelos y pipelines (Joblib).
    * Desarrollo del backend de la API (FastAPI).
* **Jupyter Notebooks (.ipynb):** Entorno de desarrollo interactivo para Python, facilitando la combinación de código, texto explicativo y visualizaciones.
* **PostgreSQL (vX.Y) con PostGIS:** Sistema de gestión de bases de datos relacional de código abierto, con extensión PostGIS para funcionalidades espaciales.
* **SQL (Structured Query Language):** Lenguaje estándar para interactuar con PostgreSQL.
* **R (vX.Y.Z):** Lenguaje y entorno para análisis estadístico y gráficos (utilizado para visualizaciones específicas).
* **Power BI Desktop (.pbix):** Herramienta de Business Intelligence de Microsoft para crear dashboards interactivos (opcional).
* **Joblib:** Librería de Python para serialización eficiente de objetos Python, especialmente pipelines de Scikit-learn.
* **Orange (vX.Y):** Software de código abierto para minería de datos y visualización (opcional, para análisis exploratorio visual).
* **Visual Studio Code (VS Code):** Editor de código fuente principal para Python, SQL, R, React (JSX) y Markdown.
* **FastAPI:** Framework moderno y rápido de Python para construir APIs. Utilizado para el backend.
* **React (JSX, JavaScript):** Librería de JavaScript para construir interfaces de usuario interactivas. Utilizada para el frontend.
    * **Material-UI (MUI):** Biblioteca de componentes React para un diseño visualmente atractivo y consistente.
    * **Leaflet:** Biblioteca JavaScript para mapas interactivos, utilizada en el frontend para la selección de ubicación.
* **Langchain con Google Gemini:** Framework para desarrollar aplicaciones impulsadas por Modelos de Lenguaje Grandes (LLM). Utilizado en el backend para crear un agente SQL que permite consultas en lenguaje natural a la base de datos.
* **N8N (Webhook):** Herramienta de automatización de flujos de trabajo, mencionada en el frontend para la funcionalidad de envío de informes por email (el flujo N8N no se desarrolla en este proyecto).
* **Git y GitHub/GitLab (asumido):** Sistema de control de versiones para la gestión del código fuente y colaboración.

---

## 3. Metodología y Flujo de Trabajo

### 3.1. Descripción General del Flujo de Trabajo

El proyecto sigue un flujo de trabajo estructurado, desde la obtención de los datos brutos hasta la presentación y uso de los resultados finales. Este flujo se detalla en el archivo `workflow.md` y se puede resumir en las siguientes macro-etapas:

1.  **Adquisición de Datos:** Obtención de datos de Idealista.
2.  **Integración y Almacenamiento:** Carga y preparación en PostgreSQL.
3.  **Análisis Exploratorio (EDA):** Comprensión inicial de los datos.
4.  **Preprocesamiento:** Limpieza y transformación para el modelado.
5.  **Modelado Predictivo:** Construcción, entrenamiento y evaluación de modelos.
6.  **Exportación del Modelo:** Guardado del modelo para uso futuro.
7.  **Despliegue y Uso del Modelo (Ejemplo Aplicación Web):** Interfaz para predicciones y consultas.
8.  **Visualización (Alternativa/Complementaria):** Creación de gráficos en R y/o dashboard en Power BI.
9.  **Documentación:** Elaboración de la memoria y otros documentos.

### 3.2. Fase 1: Adquisición y Recopilación de Datos

#### 3.2.1. Fuente de Datos: API de Idealista

La principal fuente de datos para este proyecto es la **API de Idealista**, uno de los portales inmobiliarios líderes en España. Esta API proporciona acceso programático a una vasta cantidad de listados de propiedades, incluyendo detalles como precio, superficie, número de habitaciones, ubicación (coordenadas geográficas), características (ascensor, terraza, etc.), tipo de propiedad, entre otros. Se gestionaron las credenciales de la API (API Key y Secret) y se tuvieron en cuenta los límites de uso (rate limits) y las políticas de la API.

#### 3.2.2. Proceso de Extracción (`Scripts/1.IdealistaAPI.ipynb`)

El notebook `1.IdealistaAPI.ipynb` es el responsable de esta fase. Su lógica principal incluye:

1.  **Obtención de Token de Acceso:**
    * Se utilizan la API Key y el API Secret para solicitar un token de acceso OAuth2 al endpoint de autenticación de Idealista (`https://api.idealista.com/oauth/token`).
    * Las credenciales se codifican en Base64 y se envían en la cabecera `Authorization`.
    ```python
    import requests
    import base64
    import pandas as pd
    import time # Para manejar tiempos de espera

    API_KEY = "TU_API_KEY_AQUI" # Reemplazar con la clave real
    API_SECRET = "TU_API_SECRET_AQUI" # Reemplazar con el secreto real
    TOKEN_URL = "[https://api.idealista.com/oauth/token](https://api.idealista.com/oauth/token)"

    auth_string = f"{API_KEY}:{API_SECRET}"
    auth_bytes = auth_string.encode("utf-8")
    auth_base64 = base64.b64encode(auth_bytes).decode("utf-8")

    token_headers = {
        "Authorization": f"Basic {auth_base64}",
        "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8"
    }
    token_params = {"grant_type": "client_credentials"}

    # response = requests.post(TOKEN_URL, headers=token_headers, data=token_params)
    # response.raise_for_status() # Lanza un error si la petición falla
    # access_token = response.json()["access_token"]
    # print("Token de acceso obtenido con éxito.")
    ```

2.  **Búsqueda y Extracción de Propiedades:**
    * Se define la URL de búsqueda (`https://api.idealista.com/3.5/es/search`) y se construye una petición POST con el token de acceso en la cabecera `Authorization`.
    * Los parámetros de búsqueda incluyen: operación (`sale`), tipo de propiedad (`homes`), centro geográfico (coordenadas de Barcelona), distancia/radio, país (`es`), y número máximo de ítems por página (`maxItems`).
    * Se itera por las páginas de resultados (`numPage`), extrayendo la `elementList` de cada respuesta.
    * Los datos de cada página se añaden a una lista y se guardan progresivamente en un archivo CSV para evitar la pérdida de datos en caso de interrupción.
    * Se incluye un `time.sleep(1)` entre peticiones para respetar los límites de la API.
    ```python
    # SEARCH_URL = "[https://api.idealista.com/3.5/es/search](https://api.idealista.com/3.5/es/search)"
    # search_headers = {"Authorization": f"Bearer {access_token}"}
    # search_params = {
    #     "operation": "sale", "propertyType": "homes",
    #     "center": "41.3851,2.1734", "distance": "5000", # Radio en metros
    #     "country": "es", "maxItems": "50", "numPage": "1"
    # }
    # all_properties = []
    # max_pages_to_fetch = 50 # Límite para no exceder cuotas o tiempo
    # output_csv_path = 'pisos_barcelona_api.csv'

    # for page_num in range(1, max_pages_to_fetch + 1):
    #     search_params["numPage"] = str(page_num)
    #     try:
    #         # response_search = requests.post(SEARCH_URL, headers=search_headers, data=search_params)
    #         # response_search.raise_for_status()
    #         # data = response_search.json()
    #         # if data.get("elementList"):
    #         #     all_properties.extend(data["elementList"])
    #         #     df_temp = pd.DataFrame(data["elementList"])
    #         #     if page_num == 1:
    #         #         df_temp.to_csv(output_csv_path, index=False, header=True)
    #         #     else:
    #         #         df_temp.to_csv(output_csv_path, index=False, header=False, mode='a')
    #         # else: break # No hay más propiedades
    #         # time.sleep(1) 
    #     except requests.exceptions.HTTPError as e:
    #         # print(f"Error HTTP en la página {page_num}: {e}")
    #         # if response_search.status_code == 401 or response_search.status_code == 403: break
    #         break
    #     except Exception as e:
    #         # print(f"Ocurrió un error inesperado: {e}")
    #         break
    # df_final = pd.DataFrame(all_properties)
    # print(f"Extracción completada. Total de propiedades: {len(df_final)}")
    ```

### 3.3. Fase 2: Almacenamiento y Gestión de Datos

Una vez adquiridos, los datos se integran, almacenan y gestionan en una base de datos PostgreSQL.
PostgreSQL tiene la capacidad de crear y almacenar variables geoespaciales gracias a su libreria PostGIS lo que lo hace perfecto para este tipo de datos.

#### 3.3.1. Diseño de la Base de Datos PostgreSQL (`PostgreSQL/CrearTabla.sql`)


Se diseñó un esquema de base de datos relacional para albergar los datos de las viviendas. El script `CrearTabla.sql` define la estructura de la tabla principal (e.g., `pisos_barcelona`), especificando:
* Nombres de las columnas.
* Tipos de datos apropiados (e.g., `VARCHAR`, `INTEGER`, `NUMERIC`, `BOOLEAN`, `TIMESTAMP`).
* Para datos geoespaciales (latitud, longitud), se utiliza el tipo `GEOMETRY` de PostGIS para almacenar puntos, lo que permite consultas espaciales eficientes.
* Restricciones como claves primarias (`id_interno`), unicidad (`propertyCode`), y `NOT NULL` donde sea aplicable.

#### 3.3.2. Diseño de la Base de Datos PostgreSQL (`PostgreSQL/CrearIndiceEspacial.sql`)

* Script que crea los indices geoespaciales para trabajar con las variables latitud y longitud del dataset.

#### 3.3.2. Diseño de la Base de Datos PostgreSQL (`PostgreSQL/PasarDatos.sql`)

* Una vez creada la base de datos se agregan los valores del csv ya preprocesdo

Tras acabar esta secuencia se crea una tabla de datos actualizada y se almacena la anterior con la fecha (por si se requiere rollback).

### 3.4. Fase 3: Análisis Exploratorio de Datos (EDA)
El EDA es fundamental para comprender las características de los datos, descubrir patrones, identificar anomalías y formular hipótesis antes de proceder al modelado.

#### 3.4.1. EDA con Python y Jupyter Notebooks (Scripts/Aux.EDA.ipynb)
El notebook `Aux.EDA.ipynb` se dedica a este fin. Las tareas típicas incluyen:

* **Estadísticas Descriptivas:** Cálculo de medidas de tendencia central (media, mediana), dispersión (desviación estándar, rango intercuartílico) y forma de la distribución para las variables numéricas. Tablas de frecuencia para variables categóricas.
* **Análisis de Distribuciones:** Visualización de histogramas y funciones de densidad de probabilidad (KDE plots) para entender cómo se distribuyen variables clave como el precio, superficie, etc., utilizando Matplotlib y Seaborn.
* **Identificación de Outliers:** Uso de box plots y otras técnicas (como el rango intercuartílico) para detectar valores atípicos que podrían requerir tratamiento.
* **Análisis de Correlaciones:** Cálculo y visualización de matrices de correlación (mapas de calor) entre variables numéricas para identificar relaciones lineales.
* **Relaciones entre Variables:** Gráficos de dispersión (scatter plots) para visualizar la relación entre pares de variables. Gráficos de barras agrupados o apilados y box plots por categoría para analizar variables numéricas frente a categóricas.
* **Análisis de Valores Faltantes:** Identificación y visualización del patrón de datos ausentes (e.g., usando `missingno`).

#### 3.4.2. Uso de Orange para Análisis Visual (Orange/OrangeWorkflow.ows)

**Tipo de minado:** Minado de modelos de regresión y clasificación

**Secuencia del workflow:**
* Carga de los datos
* Limpieza e imputación
* OneHotEncoder
* Separación Interpolación/Extrapolación
* Separación Train/Test dentro de interpolación
* Entrenamiento de los modelos Random Forest (RF) y XGBoost
* Evaluación de los modelos (en train/test)
* Evaluación de los modelos (en interpolación/extrapolación)

**Replicación del Modelo con Orange Data Mining:**
![image](https://github.com/user-attachments/assets/83d3b0ea-0d73-411e-8393-709063c47762)

**Métricas del modelo en Orange Data Mining:**
![image](https://github.com/user-attachments/assets/473ee3f1-b156-4414-923e-bdf3356d3f81)

Se debe describir qué tipo de análisis específico se realizó con Orange y qué insights se obtuvieron a través de su interfaz visual.

### 3.5. Fase 4: Preprocesamiento de Datos
Este notebook (`Scripts/3.PreProcesamiento.ipynb`) es crucial para transformar los datos brutos en un formato adecuado para los algoritmos de Machine Learning, basándose en los hallazgos del EDA. El preprocesamiento más exhaustivo y específico para el modelo se encapsula luego en un pipeline de Scikit-learn (Fase 5).

#### 3.5.1. Limpieza de Datos (Scripts/3.PreProcesamiento.ipynb)
El notebook `3.PreProcesamiento.ipynb` realiza una limpieza inicial del dataset unificado. A continuación, se muestran ejemplos de las transformaciones aplicadas:

```python
import pandas as pd
import numpy as np
from datetime import datetime

# from google.colab import drive # Si se usa Google Drive
# drive.mount('/content/drive')

# Cargar el dataset unificado
# file_path = "/content/drive/MyDrive/Dataset Idealista/pisos_barcelona_unificado.csv"
# df = pd.read_csv(file_path)
# print(f"Dataset cargado con {df.shape[0]} filas y {df.shape[1]} columnas.")

# 1. Eliminación de columnas innecesarias o con demasiados nulos
# (ejemplos, la lista real dependerá del análisis previo)
cols_to_drop = [
    'thumbnail', 'externalReference', 'numPhotos', 'showAddress', 
    'url', 'distance', 'description', 'hasVideo', 'hasPlan', 
    'has3DTour', 'has360', 'hasStaging', 'highlight', 'savedAd', 
    'notes', 'topNewDevelopment', 'topPlus', 'newDevelopmentFinished',
    'priceInfo', 'suggestedTexts', 'detailedType', 'change', 'parkingSpace' # Ejemplos
]
# df.drop(columns=cols_to_drop, inplace=True, errors='ignore') # errors='ignore' evita error si alguna col ya no existe
# print(f"Columnas eliminadas. Shape actual: {df.shape}")

# 2. Conversión de tipos y manejo de booleanos (ejemplo con 'exterior' y 'hasLift')
# Idealista puede devolverlos como True/False o strings. Se mapean a 0/1 y se imputan nulos con la moda.
boolean_like_cols = ['exterior', 'hasLift', 'newDevelopment'] # Añadir otras si aplica
# for col in boolean_like_cols:
#     if col in df.columns:
#         df[col] = df[col].map({True: 1, False: 0, 'True': 1, 'False': 0, 1:1, 0:0})
#         # Imputar con la moda si hay nulos tras el mapeo, o si eran numéricos y quedaron
#         if df[col].isnull().any():
#             mode_val = 0 # Valor por defecto si la moda no se puede calcular
#             if not df[col].mode().empty:
#                 mode_val = df[col].mode()[0]
#             df[col].fillna(mode_val, inplace=True)
#         df[col] = df[col].astype(int) # Asegurar tipo entero para 0/1

# 3. Tratamiento de la columna 'floor' para convertirla a numérica ('floor_numeric')
# Esta columna puede contener valores como 'bj' (bajo), 'en' (entresuelo), 'st' (sótano), 'ático', etc.
def clean_floor_extended(floor_val):
    if pd.isna(floor_val):
        return np.nan
    s = str(floor_val).lower().strip()
    if 'bj' in s or 'bajo' in s: return 0
    if 'en' in s or 'entresuelo' in s: return 0.5 
    if 'st' in s or 'sótano' in s: return -1
    if 'ático' in s or 'at' in s: # Ejemplo para ático, podría ser un valor alto o manejarse como categórica
        try: return int(''.join(filter(str.isdigit, s))) if any(char.isdigit() for char in s) else 10 # Valor ejemplo
        except ValueError: return 10
    try: # Intentar extraer cualquier número
        return int(''.join(filter(str.isdigit, s)))
    except ValueError:
        return np.nan # Si no se puede convertir a número y no es un caso especial

# df['floor_numeric'] = df['floor'].apply(clean_floor_extended)
# # Imputar nulos en floor_numeric con la mediana
# df['floor_numeric'].fillna(df['floor_numeric'].median(), inplace=True) # Corregido: .median() es un método
# df.drop(columns=['floor'], inplace=True, errors='ignore') # Eliminar la columna original 'floor'

# 4. Limpieza de columnas categóricas clave (ejemplos con 'status', 'propertyType', 'district', 'neighborhood')
# Se rellenan nulos con la moda (o 'Unknown') y se asegura consistencia de tipo string.
categorical_cols_to_clean = ['status', 'propertyType', 'conservation', 'district', 'neighborhood']
# for col in categorical_cols_to_clean:
#     if col in df.columns:
#         fill_value = 'Unknown'
#         if not df[col].mode().empty:
#             fill_value = df[col].mode()[0]
#         df[col] = df[col].fillna(fill_value)
#         df[col] = df[col].astype(str) # Asegurar que son strings

# 5. Limpieza y conversión de columnas numéricas principales (price, size, rooms, bathrooms)
# Se convierten a numérico (forzando errores a NaN) y se imputan NaNs con la mediana.
numeric_cols_to_clean = ['price', 'size', 'rooms', 'bathrooms']
# for col in numeric_cols_to_clean:
#     if col in df.columns:
#         df[col] = pd.to_numeric(df[col], errors='coerce')
#         df[col].fillna(df[col].median(), inplace=True)

# (Opcional) Eliminación de outliers basada en IQR para 'price' y 'size' (ejemplo)
# for col_outlier in ['price', 'size']:
#     if col_outlier in df.columns:
#         Q1 = df[col_outlier].quantile(0.25)
#         Q3 = df[col_outlier].quantile(0.75)
#         IQR = Q3 - Q1
#         lower_bound = Q1 - 1.5 * IQR
#         upper_bound = Q3 + 1.5 * IQR
#         df = df[(df[col_outlier] >= lower_bound) & (df[col_outlier] <= upper_bound)]

# Guardar el DataFrame limpiado con fecha en el nombre
# fecha_actual = datetime.now().strftime('%Y-%m-%d') # Formato AAAA-MM-DD para mejor ordenación
# output_path_clean = f'/content/drive/MyDrive/Dataset Idealista/pisosBarcelona-{fecha_actual}-clean.csv'
# df.to_csv(output_path_clean, index=False)
# print(f"Dataset limpiado guardado en: {output_path_clean} con {df.shape[0]} filas y {df.shape[1]} columnas.")
# print("\nPrimeras filas del dataset limpiado:")
# print(df.head())
# print("\nInformación del dataset limpiado:")
# df.info()
```

#### 3.5.2. Transformación de Variables y 3.5.3. Ingeniería de Características (Feature Engineering)
Estas tareas, si bien algunas se inician en `3.PreProcesamiento.ipynb`, se definen y aplican de manera más estructurada y reproducible dentro del pipeline de Scikit-learn en la fase de modelado (Fase 5). Incluyen:

* **Manejo de Valores Faltantes (Nulos):** Se utiliza `SimpleImputer` de Scikit-learn. Para variables numéricas, se imputa con la mediana (`strategy='median'`). Para variables categóricas, se imputa con la moda (`strategy='most_frequent'`).
* **Codificación de Variables Categóricas:**
    * **Target Encoding (`category_encoders.TargetEncoder`):** Se aplica a variables categóricas con alta cardinalidad (muchos valores únicos), como `district` y `neighborhood`. Este método reemplaza cada categoría con la media de la variable objetivo (precio) para esa categoría, con técnicas de regularización (`smoothing`, `min_samples_leaf`) para evitar sobreajuste.
    * **One-Hot Encoding (`sklearn.preprocessing.OneHotEncoder`):** Se aplica a variables categóricas nominales con un número menor de categorías (e.g., `propertyType`, `status`). Crea nuevas columnas binarias (0/1) para cada categoría. Se usa `handle_unknown='ignore'` para manejar categorías no vistas durante el entrenamiento.
* **Escalado/Normalización de Variables Numéricas:** Se utiliza `StandardScaler` de Scikit-learn para estandarizar las características numéricas, eliminando la media y escalando a la varianza unitaria. Esto es importante para algoritmos sensibles a la escala de las características.
* **(Opcional) Transformaciones para Asimetría:** Si variables como `price` o `size` muestran una fuerte asimetría, se podrían aplicar transformaciones logarítmicas (`np.log1p`) o Box-Cox para acercarlas a una distribución normal. Esto se haría antes del escalado.
* **(Opcional) Creación de Nuevas Características:**
    * **Interacciones Polinómicas (`sklearn.preprocessing.PolynomialFeatures`):** Para capturar relaciones no lineales e interacciones entre características. Se puede limitar a `interaction_only=True`.
    * **Características Basadas en Fechas:** Si se dispusiera de fechas relevantes (e.g., fecha de construcción, fecha de última reforma), se podrían derivar características como la antigüedad de la propiedad.
    * **Características Geoespaciales Avanzadas:** Más allá de latitud/longitud, se podrían calcular distancias a puntos de interés (requiere datos POI adicionales).

Todos estos pasos de preprocesamiento se integran en un `ColumnTransformer` dentro del pipeline principal de Scikit-learn para asegurar que se apliquen de manera consistente.

### 3.6. Fase 5: Modelado Predictivo (`Scripts/4.ModeloExport.ipynb`)

Esta fase se centra en la construcción, entrenamiento, evaluación y exportación de un modelo de Machine Learning para predecir el precio de las viviendas. Se utiliza principalmente el notebook `Scripts/4.ModeloExport.ipynb`.

#### 3.6.1. Carga de Datos, Limpieza y Preprocesamiento Inicial

El proceso comienza con la carga del dataset limpio (`pisosBarcelona-DD-MM-YYYY-clean.csv`). Se seleccionan columnas relevantes y se realiza una limpieza exhaustiva que incluye:
* **Formateo de Columnas:** Conversión de tipos de datos (ej. `floor` a numérico, manejando valores especiales como 'bj', 'en', 'ss').
* **Imputación de Nulos:** Los valores faltantes en columnas como `floor`, `exterior`, `hasLift` se imputan utilizando la mediana o la moda. Para columnas numéricas clave (`size`, `rooms`, `bathrooms`, `latitude`, `longitude`), se crean *flags* indicadoras de nulos antes de imputar con la mediana. Estos valores de imputación (medianas, modas) se guardan para su uso en la predicción.
* **Combinación de Características:** Las columnas `hasParking` e `isParkingIncludedInPrice` se combinan en una única característica categórica: `parking_status`.

```python
# BLOQUE 2: Carga de Datos y Selección Inicial de Columnas
# ... (Código relevante de carga y selección) ...
# df = pd.read_csv(file_path, encoding='latin1')
# relevant_cols = [...]
# df_model = df[relevant_cols].copy()

# BLOQUE 3: Limpieza, Formateo e Imputación de Nulos
# ... (Código de limpieza e imputación) ...
# floor_map = {'bj': 0.0, 'en': 0.5, 'ss': -1.0}
# df_model['floor'] = pd.to_numeric(df_model['floor'].replace(floor_map), errors='coerce').fillna(median_floor_mapped)
# imputation_values = {} # Se guardan medianas/modas
# for c in numeric_cols_to_impute:
# df_model[f'isna_{c}'] = df_model[c].isna().astype(int)
#     median_val = df_model[c].median()
#     df_model[c] = df_model[c].fillna(median_val)
#     imputation_values[f'median_{c}'] = median_val
```

#### 3.6.2. Ingeniería de Características Avanzada
Se realiza una extensa ingeniería de características para enriquecer el modelo:

**Características Espaciales:**
* Distancias a Puntos de Interés (POIs): Se calculan distancias geodésicas a POIs clave de Barcelona (ej. 'Catalunya', 'Barceloneta') y se añaden como nuevas características.
* Clustering Geográfico: Se aplica `KMeans` (con $k=8$) a las coordenadas escaladas (`latitude`, `longitude`) para crear `geo_cluster`. Se guarda el `StandardScaler` (`scaler_geo`) y el modelo `KMeans` (`kmeans_geo`).
* PCA Geográfico: Se aplica `PCA` (1 componente) a las coordenadas escaladas para obtener `geo_pca1`. Se guarda el objeto `PCA` (`pca_geo`).
* Precio Medio por Cluster: Se calcula el precio medio logarítmico (`price_log`) por `geo_cluster` y se añade como `cluster_avg_logprice`. Se guarda el mapeo `cluster_avg_logprice_map`.

```python
# BLOQUE 4: Ingeniería de Características Espaciales
# pois = {'Catalunya':(41.3874,2.1700), ...}
# scaler_geo = StandardScaler()
# geo = scaler_geo.fit_transform(df_model[['latitude','longitude']])
# kmeans = KMeans(n_clusters=8, random_state=RNG, n_init='auto').fit(geo)
# df_model['geo_cluster'] = kmeans.labels_
# pca_geo = PCA(n_components=1, random_state=RNG)
# df_model['geo_pca1'] = pca_geo.fit_transform(geo).flatten()
# df_model['price_log'] = np.log1p(df_model['price'])
# df_model['cluster_avg_logprice'] = df_model.groupby('geo_cluster')['price_log'].transform('mean')
# cluster_avg_logprice_map = df_model.groupby('geo_cluster')['price_log'].mean()
```

**Codificación de Variables Categóricas:**

Se utiliza `TargetEncoder` de la librería `category_encoders` para convertir columnas como `propertyType`, `status`, y `parking_status` a representaciones numéricas, utilizando `price_log` como variable objetivo. Se guarda el `TargetEncoder` ajustado (`te`).

```python
# BLOQUE 5: Codificación de Variables Categóricas (Target Encoding)
# te_cols = ['propertyType','status','parking_status']
# te = ce.TargetEncoder(cols=te_cols, smoothing=10)
# df_model[te_cols] = te.fit_transform(df_model[te_cols], df_model['price_log'])
```

**Creación de Características No Lineales:**

* **Splines:** Se aplica `SplineTransformer` (cúbicos, 5 nudos) a la columna `size` y a las distancias a POIs para capturar relaciones no lineales. Se guarda el `SplineTransformer` (`spline`).
* **Interacciones Polinómicas:** Se generan términos de interacción de grado 2 entre un conjunto de características numéricas base (ej. `size`, `rooms`, `geo_pca1`) utilizando `PolynomialFeatures`. Se guarda el objeto `PolynomialFeatures` (`poly`).

```python
# BLOQUE 6: Creación de Características No Lineales (Splines y Polinomios)
# spline_input_cols = ['size'] + [f'DistKm_{p}' for p in pois]
# spline = SplineTransformer(degree=3, n_knots=5, include_bias=False)
# spline_feats = spline.fit_transform(df_model[spline_input_cols])
# df_model = pd.concat([df_model, pd.DataFrame(spline_feats, ...)], axis=1)
#
# num_base = ['size','rooms','bathrooms','floor','numPhotos', ...]
# poly = PolynomialFeatures(degree=2, interaction_only=True, include_bias=False)
# X_poly = poly.fit_transform(df_model[num_base])
# df_model = pd.concat([df_model, df_poly[new_ints]], axis=1)
```
#### 3.6.3. Filtrado de Outliers y Preparación Final de Datos
* Se aplica un filtrado de outliers basado en los percentiles 1 y 99 de `price_log` para estabilizar el entrenamiento.
* Los datos se dividen en conjuntos de entrenamiento (80%) y prueba (20%).
* Finalmente, todas las características numéricas resultantes en `X_train` y `X_test` se escalan utilizando `StandardScaler`. Este escalador (`scaler`) se ajusta solo con `X_train` y luego se aplica a ambos conjuntos. Se guarda el orden final de las columnas (`feature_order`).

```
# BLOQUE 7: Filtrado de Outliers
# y = df_model['price_log']
# low, high = y.quantile([0.01, 0.99])
# df_model = df_model[y.between(low, high)]

# BLOQUE 8: División en Conjuntos de Entrenamiento y Prueba y Escalado Final
# X = df_model.drop(columns=['price','price_log'])
# y = df_model['price_log']
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=RNG)
# num_cols = X_train.select_dtypes(include=np.number).columns
# scaler = StandardScaler()
# X_train[num_cols] = scaler.fit_transform(X_train[num_cols])
# X_test[num_cols] = scaler.transform(X_test[num_cols])
# feature_order = X_train.columns.tolist()
```
#### 3.6.4. Selección, Entrenamiento y Optimización del Modelo
El modelo principal seleccionado es `XGBoost Regressor` (`xgb.XGBRegressor`) debido a su alto rendimiento y capacidad para manejar datos tabulares complejos.

**Optimización de Hiperparámetros:** Se utiliza `RandomizedSearchCV` con validación cruzada (5 folds) para encontrar la combinación óptima de hiperparámetros para XGBoost. Se define un espacio de búsqueda para parámetros como `n_estimators`, `learning_rate`, `max_depth`, `subsample`, `colsample_bytree`, y parámetros de regularización (`reg_alpha`, `reg_lambda`). La métrica optimizada es `'neg_mean_absolute_error'`.

```python
# BLOQUE 9: Búsqueda de Hiperparámetros y Entrenamiento del Modelo XGBoost
# param_dist = {'n_estimators': [100, 200, ...], ...}
# xgb_model = xgb.XGBRegressor(objective='reg:squarederror', random_state=RNG, n_jobs=-1, tree_method='hist')
# rand_search = RandomizedSearchCV(xgb_model, param_dist, n_iter=50, cv=5, scoring='neg_mean_absolute_error', ...)
# rand_search.fit(X_train, y_train)
# best_model = rand_search.best_estimator_
```
**Entrenamiento del Modelo Final:** Mejores hiperparámetros encontrados:
{'subsample': 0.8, 'reg_lambda': 0.5, 'reg_alpha': 0, 'n_estimators': 300, 'max_depth': 9, 'learning_rate': 0.05, 'colsample_bytree': 0.7}

#### 3.6.5. Evaluación del Modelo Final
El rendimiento del `best_model` se evalúa sobre el conjunto de prueba (`X_test`, `y_test`), que no se utilizó durante el entrenamiento ni la optimización.

Las predicciones (`y_pred_log`) y los valores reales de prueba (`y_test`) se revierten de la transformación logarítmica (usando `np.expm1`) para evaluar en la escala original de precios.
Se calculan métricas clave:

* **MAE : 68,804.19 € (Error Absoluto Medio):** Proporciona el error promedio en euros.
* **RMSE: 137,169.68 € (Raíz del Error Cuadrático Medio):** Similar al MAE pero penaliza más los errores grandes.
* **R²: 0.8706 (Coeficiente de Determinación):** Indica la proporción de la varianza del precio explicada por el modelo.

```python
# BLOQUE 10: Evaluación Final del Modelo
# y_pred_log = best_model.predict(X_test)
# y_test_orig = np.expm1(y_test)
# y_pred_orig = np.expm1(y_pred_log)
# mae  = mean_absolute_error(y_test_orig, y_pred_orig)
# rmse = np.sqrt(mean_squared_error(y_test_orig, y_pred_orig))
# r2   = r2_score(y_test_orig, y_pred_orig)
# print(f"MAE  (Mean Absolute Error) : {mae:,.2f} €")
# print(f"R²   (R-squared)           : {r2:.4f}")
```

Los resultados típicos obtenidos (ej. $MAE \approx 68,000 \text{€}$, $R^2 \approx 0.87$) indican un buen ajuste del modelo, aunque siempre hay margen de mejora.

### 3.7. Fase 6: Exportación del Pipeline Completo (`Scripts/4.ModeloExport.ipynb`)
Una vez entrenado y evaluado, el pipeline de preprocesamiento y el modelo predictivo se guardan para su reutilización, especialmente para el despliegue en la aplicación web.

#### Exportación de Todos los Componentes Necesarios
El notebook `4.ModeloExport.ipynb`, en su `BLOQUE 11`, utiliza la librería `joblib` para serializar un diccionario llamado `pipeline_completo`. Este diccionario no solo contiene el modelo `XGBoost` entrenado (`best_model`), sino también todos los transformadores ajustados y metadatos críticos para asegurar que los nuevos datos pasen exactamente por las mismas transformaciones:

* **Transformadores Ajustados:**
    * `scaler_geo`: `StandardScaler` para coordenadas geográficas.
    * `kmeans_geo`: Modelo `KMeans` para clustering geográfico.
    * `pca_geo`: Modelo `PCA` para componente principal geográfica.
    * `target_encoder`: `TargetEncoder` ajustado.
    * `spline_transformer`: `SplineTransformer` ajustado.
    * `poly_features`: `PolynomialFeatures` ajustado.
    * `scaler_final`: `StandardScaler` final para todas las características numéricas.
* **Modelo Entrenado:**
    * `xgb_model`: El modelo `XGBoost` final (`best_model`).
* **Metadatos y Parámetros:**
    * `pois`: Diccionario de Puntos de Interés.
    * `floor_map`: Mapeo para la columna `'floor'`.
    * `imputation_values`: Valores utilizados para la imputación de nulos.
    * `cluster_avg_logprice_map`: Mapeo de cluster geográfico a precio medio logarítmico.
    * `spline_input_cols`: Lista de columnas de entrada para el `SplineTransformer`.
    * `poly_base_cols`: Lista de columnas base para `PolynomialFeatures`.
    * `te_cols`: Lista de columnas para el `TargetEncoder`.
    * `scaled_num_cols`: Lista de columnas que fueron escaladas por `scaler_final`.
    * `feature_order`: El orden exacto de las columnas que espera el modelo `XGBoost`.

Este enfoque integral asegura que el proceso de predicción en nuevos datos sea consistente y reproducible.

```python
# BLOQUE 11: Guardado del Pipeline Completo (CORREGIDO)
import joblib
import os
# from google.colab import drive # Si se usa Google Drive
# drive.mount('/content/drive')

# save_dir = '/content/drive/MyDrive/ModelosIdealista'
# os.makedirs(save_dir, exist_ok=True)

# pipeline_completo = {
#     'scaler_geo': scaler_geo,
#     'kmeans_geo': kmeans,
#     'pca_geo': pca_geo,
#     'target_encoder': te,
#     'spline_transformer': spline,
#     'poly_features': poly,
#     'scaler_final': scaler,
#     'xgb_model': best_model,
#     'pois': pois,
#     'floor_map': floor_map,
#     'imputation_values': imputation_values,
#     'cluster_avg_logprice_map': cluster_avg_logprice_map,
#     'spline_input_cols': spline_input_cols,
#     'poly_base_cols': num_base, # num_base son las poly_base_cols
#     'te_cols': te_cols,
#     'scaled_num_cols': num_cols, # num_cols son las scaled_num_cols
#     'feature_order': feature_order
# }

# file_save_path = os.path.join(save_dir, 'pipeline_idealista_completo.joblib')
# joblib.dump(pipeline_completo, file_save_path)

# print(f"\n✅ Pipeline COMPLETO exportado correctamente en: {file_save_path}")
# print(f"   Componentes guardados: {list(pipeline_completo.keys())}")
```
El archivo `.joblib` resultante (e.g., `pipeline_idealista_completo.joblib`) es autocontenido y contiene todo lo necesario. Un notebook complementario (o una función dentro de la aplicación) cargaría este archivo y utilizaría los componentes almacenados para preprocesar nuevos datos de entrada y luego realizar la predicción del precio, asegurando la coherencia con el proceso de entrenamiento. Este archivo es el artefacto clave para el backend de la aplicación web.

## 3.8. Fase 7: Ejemplo de Uso del Modelo Desplegado (Aplicación Web)
Para demostrar la utilidad práctica del modelo predictivo y la base de datos construida, se ha desarrollado un prototipo de aplicación web. Esta aplicación consta de un frontend (interfaz de usuario) y un backend (servidor de aplicación) que trabajan conjuntamente.

### 3.8.1. Frontend (Interfaz de Usuario)
La interfaz de usuario ha sido desarrollada con React, utilizando componentes de Material-UI (MUI) para un diseño moderno y responsivo. Las principales funcionalidades ofrecidas al usuario son:

* **Página de Inicio (`HomePage.jsx`):** Presenta la aplicación, sus características principales (valoración, análisis de ubicación, asistente IA) y dirige al usuario hacia la herramienta de valoración mediante un botón "Comenzar Valoración".
* **Página de Valoración (`ValuationPage.jsx`):**
    * **Formulario de Valoración (`ValuationForm.jsx`):** Un formulario multi-paso (Stepper de MUI) donde el usuario introduce las características de la vivienda. La configuración de estos pasos (Datos Principales, Características, Ubicación) y los campos asociados se definen en `valuationForm.utils.jsx`. Los campos incluyen tamaño, número de habitaciones, baños, planta, tipo de propiedad, estado, y características adicionales (exterior, ascensor, parking).
    * **Selección de Ubicación en Mapa (`LocationMarker.jsx`):** Integrado en el último paso del formulario, muestra un mapa interactivo (usando `react-leaflet`) centrado en Barcelona. El usuario puede hacer clic en el mapa para seleccionar la ubicación exacta de la propiedad. Se valida que la ubicación esté dentro de un radio geográfico predefinido (`MAX_RADIUS_METERS` desde `MAP_CENTER_COORDS` definidos en `utils/constants.js`).
    * **Visualización de la Predicción:** Una vez completado el formulario y realizada la predicción por el backend, se muestra el precio estimado de la vivienda de forma clara.
    * **Asistente IA (`ChatDialog.jsx`):** Un diálogo de chat flotante (accesible mediante un Fab - Floating Action Button) que permite al usuario realizar preguntas en lenguaje natural sobre el mercado inmobiliario de Barcelona o datos específicos de la base. Los mensajes se muestran en una lista, diferenciando entre usuario y bot.
    * **Solicitud de Informe por Email (`EmailReportSection.jsx`):** Una sección en la `ValuationPage` donde el usuario puede introducir su correo electrónico para solicitar un informe más detallado. La lógica de envío se delega a un webhook externo (`N8N_WEBHOOK_URL` de `utils/constants.js`).

El componente principal `App.jsx` gestiona la navegación entre `HomePage` y `ValuationPage`, y la visibilidad del `ChatDialog`. Se utiliza `CssBaseline` de MUI para estilos base consistentes.

### 3.8.2. Backend (Servidor de Aplicación)
El backend se ha construido con FastAPI (Python), proporcionando una API RESTful para dar servicio al frontend. Sus responsabilidades clave son (`main.py`):

* **Servir el Modelo Predictivo:**
    * Al iniciarse, carga el archivo `.joblib` (`pipeline_idealista_completo.joblib`) que contiene el diccionario con el pipeline completo y los metadatos necesarios (listas de columnas, etc.).
    * Expone un endpoint (ej. `/predict/`) que recibe las características de una vivienda (definidas por un modelo Pydantic como `ValuationData`) introducidas por el usuario en el frontend.
    * Preprocesa estos datos de entrada utilizando los transformadores y el orden de columnas guardados en el pipeline cargado para asegurar consistencia.
    * Utiliza el modelo (regresor) del pipeline para generar una predicción de precio.
    * Devuelve la predicción (y opcionalmente otra información relevante) al frontend.
* **Agente LLM para Consultas a la Base de Datos:**
    * Se conecta a la base de datos PostgreSQL del proyecto (`DATABASE_URL`) utilizando SQLAlchemy.
    * Utiliza Langchain y un modelo de lenguaje grande como Google Gemini (configurado con `GOOGLE_API_KEY`) para crear un agente SQL (`create_sql_agent`). Este agente está diseñado para interactuar con la base de datos SQL especificada (`SQLDatabase` de Langchain).
    * Expone un endpoint (ej. `/chat/`) que recibe las preguntas en lenguaje natural del usuario desde el `ChatDialog.jsx` del frontend.
    * El agente LLM traduce la pregunta a una consulta SQL, la ejecuta contra la base de datos `pisos_barcelona`, procesa el resultado y devuelve una respuesta en lenguaje natural al frontend. Se realiza una limpieza de la respuesta del agente para mejorar la presentación.
* **Gestión de la API:**
    * Maneja la configuración de CORS (CORSMiddleware) para permitir la comunicación con el frontend (que se ejecuta en un origen diferente durante el desarrollo).
    * Validación de datos de entrada para los endpoints usando modelos Pydantic.
    * Proporciona documentación automática de la API (Swagger UI en `/docs`, ReDoc en `/redoc`).
    * Un endpoint raíz (`/`) para verificar el estado de la API y sus componentes (modelo cargado, conexión a BD, agente LLM inicializado).

### 3.8.3. Interacción Frontend-Backend
* **Para Predicción de Precio:**
    * El usuario rellena el `ValuationForm.jsx` en el frontend.
    * Al presionar "Estimar Precio", el frontend empaqueta los datos del formulario (incluyendo latitud y longitud del `LocationMarker.jsx`) y realiza una petición HTTP (POST) al endpoint `/predict/` del backend FastAPI.
    * El backend FastAPI recibe los datos, los valida con su modelo Pydantic `ValuationData`, los pasa al pipeline predictivo cargado (que realiza el preprocesamiento necesario), obtiene la predicción del precio.
    * El backend devuelve la predicción (un número) en formato JSON.
    * El frontend recibe la respuesta, actualiza su estado y muestra el precio estimado al usuario. Maneja posibles errores de la API.
* **Para Asistente IA:**
    * El usuario escribe una pregunta en el `ChatDialog.jsx`.
    * Al enviar, el frontend realiza una petición HTTP (POST) al endpoint `/chat/` del backend, enviando la consulta del usuario.
    * El backend FastAPI pasa la consulta al agente Langchain/LLM. El agente genera y ejecuta una consulta SQL contra la base de datos `pisos_barcelona`.
    * La respuesta generada por el LLM (basada en los resultados de la consulta SQL) se devuelve al frontend.
    * El frontend actualiza el historial del chat con la pregunta del usuario y la respuesta del bot.

Esta arquitectura modular y desacoplada permite un desarrollo y mantenimiento más sencillos, donde el frontend se encarga de la presentación y la interacción con el usuario, mientras que el backend maneja la lógica de negocio, el modelado y el acceso a datos.

## 3.9. Fase 8: Visualización de Resultados (Alternativa)
Además de la aplicación web interactiva, los resultados y análisis del proyecto se pueden explorar mediante otras herramientas visuales si se requiere un análisis más profundo o una presentación diferente para stakeholders específicos.

### 3.9.1. Visualizaciones Avanzadas con R (`Scripts/Graficaciones.R`)

El script `Graficaciones.R` ha sido desarrollado para llevar a cabo un análisis exploratorio del dataset. Las principales funcionalidades del script incluyen:

1.  **Carga de Librerías:** Importa paquetes esenciales como `readr` para la lectura de datos, `dplyr` y `tidyr` para la manipulación de datos, `ggplot2` para la creación de gráficos, `scales` para el formateo de ejes, `viridis` para paletas de colores, `ggcorrplot` para mapas de calor de correlaciones, `patchwork` para combinar gráficos y `lubridate` para el manejo de fechas.
2.  **Carga de Datos:** Lee un archivo CSV (`pisosBarcelona-10-05-2025-clean.csv`) que contiene la información inmobiliaria, realizando una verificación de existencia del archivo y manejo de errores durante la carga.
3.  **Limpieza y Preparación de Datos:**
    * Renombra columnas para mayor claridad (ej. `priceByArea` a `price_per_m2`).
    * Calcula `price_per_m2` si no existe, a partir de `price` y `size`.
    * Convierte columnas a tipos de datos apropiados (numérico, factor, lógico a factor Sí/No).
    * Maneja valores ausentes en columnas clave (`price`, `size`).
4.  **Visualización de Datos:**
    * Establece un tema visual coherente para todos los gráficos.
    * Crea un directorio para guardar los gráficos generados.
    * Define una función para guardar los gráficos en formato PNG.
    * Genera una variedad de visualizaciones, entre ellas:
        * Histogramas y boxplots de precios y áreas (tamaño).
        * Gráfico de dispersión de precio vs. área con línea de regresión.
        * Histograma de precio por metro cuadrado.
        * Boxplots de precios agrupados por número de habitaciones, baños, distrito y estado de la propiedad.
        * Boxplot de precios según la presencia de ascensor.
        * Mapa de calor de correlaciones entre variables numéricas.
    * Cada gráfico se muestra en una ventana individual si se ejecuta en un entorno interactivo y se guarda como archivo de imagen.
5.  **Combinación de Gráficos:** Utiliza `patchwork` para combinar una selección de los gráficos más relevantes en un panel resumen, proporcionando una visión general del análisis.

El script está diseñado para ser robusto, incluyendo verificaciones de la existencia de columnas, manejo de datos faltantes y filtrado de datos atípicos (outliers) para mejorar la claridad de las visualizaciones. Además, proporciona retroalimentación en la consola sobre los pasos realizados y posibles advertencias.

Ejemplo graficos:

  *![image](https://github.com/user-attachments/assets/80173fc4-8079-4b53-b530-aa63c2489c21)


### 3.9.2. Dashboard Interactivo en Power BI (`BarcelonaHousingForecastBI.pbix`)
El archivo `BarcelonaHousingForecastBI.pbix` (si se desarrolla) contendría un dashboard en Power BI. Esta herramienta de Business Intelligence permite crear informes interactivos y cuadros de mando para la exploración de los datos y los resultados del modelo.

* **Indicadores Clave de Rendimiento (KPIs):** Precio medio de venta, número de propiedades analizadas, ticket medio, métricas de error del modelo (MAE, RMSE), etc.
* **Filtros Interactivos:** Permitir filtrar zonas segmentar y explorar los datos por distrito, barrio.
* **Visualizaciones de Datos:**
    * **Mapas Interactivos:** Mostrando la ubicación de las viviendas, con colores o tamaños de puntos representando el precio o alguna otra variable. Posibilidad de hacer drill-down geográfico.
    * **Gráficos de Tendencias:** Evolución de precios medios (si hay componente temporal).
    * **Distribuciones:** Histogramas o gráficos de densidad para precios, superficies, etc.
    * **Comparativas:** Gráficos de barras o para comparar precios o características entre diferentes barrios o tipos de vivienda.
    * 
<img width="1137" alt="image" src="https://github.com/user-attachments/assets/8c207aec-c0be-4c6c-bba8-2ae459a84466" />

 
---
### Estructura del Repositorio del Proyecto
```markdown
## 4. Estructura del Repositorio del Proyecto

El repositorio del proyecto está organizado de la siguiente manera para facilitar la comprensión, la reproducibilidad y la colaboración:
├── backend/                             # Contiene el código del servidor FastAPI
│   ├── main.py                          # Lógica del servidor, API endpoints, carga del modelo y agente LLM
│   ├── pipeline_idealista_completo.joblib # Copia del modelo .joblib para el backend
│   ├── Dockerfile                       # (Opcional) Para la contenerización del backend
│   └── requirements.txt                 # Dependencias Python del backend
├── frontend/                            # Contiene el código de la aplicación React
│   ├── public/                          # Archivos estáticos (index.html, favicons, etc.)
│   ├── src/
│   │   ├── components/                  # Componentes React reutilizables
│   │   │   ├── ValuationForm/
│   │   │   │   ├── ValuationForm.jsx
│   │   │   │   └── valuationForm.utils.jsx
│   │   │   ├── ChatDialog/
│   │   │   │   └── ChatDialog.jsx
│   │   │   ├── EmailReportSection/
│   │   │   │   └── EmailReportSection.jsx
│   │   │   ├── HomePage.jsx
│   │   │   ├── LocationMarker.jsx
│   │   │   └── ValuationPage.jsx
│   │   ├── App.jsx                      # Componente raíz de React, maneja el enrutamiento
│   │   ├── main.jsx                     # Punto de entrada de la aplicación React (renderiza App)
│   │   └── utils/                       # Utilidades del frontend (constantes, helpers)
│   ├── index.html                       # Plantilla HTML principal para la Single Page Application (SPA)
│   ├── package.json                     # Dependencias y scripts del frontend (npm/yarn)
│   ├── vite.config.js                   # Configuración de Vite (empaquetador del frontend)
│   └── Dockerfile                       # (Opcional) Para la contenerización del frontend
├── Modelos/                             # Modelos de Machine Learning serializados (versión "maestra")
│   └── pipeline_idealista_completo.joblib  # Pipeline completo (preprocesador + modelo)
├── Orange/                              # (Opcional) Archivos de flujos de trabajo del software Orange
│   └── OrangeWorkflow.ows
├── PostgreSQL/                          # Scripts SQL para la gestión de la base de datos
│   ├── AjustarValores.sql
│   ├── CrearIndiceEspacial.sql
│   ├── CrearTabla.sql
│   └── PasarDatosCSV.sql
├── Scripts/                             # Jupyter Notebooks y scripts de R para análisis y modelado
│   ├── 1.IdealistaAPI.ipynb
│   ├── 2.AgregarNuevasViviendas.ipynb
│   ├── 3.PreProcesamiento.ipynb
│   ├── 4.ModeloExport.ipynb
│   ├── Aux.EDA.ipynb
│   ├── Aux.IdealistaModelo.ipynb           # Modelado predictivo (base/exploratorio)
│   ├── Aux.IdealistaModeloAmpliado.ipynb   # Modelado predictivo (avanzado/final)
│   ├── Aux.ModeloImport.ipynb              # Carga y prueba del modelo exportado
│   └── Graficaciones.R                     # (Opcional) Script R para visualizaciones
├── .vscode/                             # (Opcional) Configuración específica del editor VS Code
│   └── settings.json
├── .gitattributes                       # (Opcional) Para la gestión de finales de línea en Git
├── .gitignore                           # Archivos y directorios a ignorar por Git
├── BarcelonaHousingForecastBI.pbix      # (Opcional) Archivo del dashboard de Power BI
├── memoria.md                           # Este documento (la memoria del proyecto)
├── readme.md                            # Instrucciones generales, resumen del proyecto, cómo ejecutarlo
└── workflow.md                          # Descripción detallada del flujo de trabajo del proyecto
```
**Descripción de los directorios principales:**

* **`backend/`**: Contiene todo el código fuente del servidor FastAPI, incluyendo el endpoint de predicción que carga el modelo `.joblib` y el endpoint del chat que interactúa con el agente LLM y la base de datos.
* **`frontend/`**: Alberga el código fuente de la aplicación React, estructurado en componentes, utilidades y el punto de entrada principal.
* **`Modelos/`**: Es el directorio centralizado para la versión "maestra" del modelo de Machine Learning serializado (`.joblib`). El backend puede copiar este archivo a su propio directorio para su uso.
* **`Orange/`**: Si se utilizó Orange para alguna etapa de análisis visual o preprocesamiento, los flujos de trabajo (`.ows`) se guardarían aquí.
* **`PostgreSQL/`**: Contiene todos los scripts SQL necesarios para crear la estructura de la base de datos, cargar datos, realizar ajustes y crear índices.
* **`Scripts/`**: Es el corazón del trabajo de análisis de datos y modelado, conteniendo los Jupyter Notebooks para cada etapa (adquisición, preprocesamiento, EDA, modelado, exportación) y scripts auxiliares.
* **Archivos Raíz**: Incluyen la documentación principal del proyecto (`memoria.md`, `readme.md`, `workflow.md`), archivos de configuración de Git, y opcionalmente el dashboard de Power BI si se utiliza esa herramienta.

El archivo `readme.md` es crucial, ya que debe proporcionar una visión general concisa del proyecto, las instrucciones de instalación de dependencias (tanto para el backend como para el frontend), cómo ejecutar los diferentes componentes (base de datos, backend, frontend) y una breve descripción de los contenidos del repositorio. El `workflow.md` detalla la secuencia lógica de ejecución de los scripts y las dependencias entre ellos para la parte de análisis y modelado.

### SECCIÓN: 4. Despliegue Detallado de la Aplicación con Docker y Docker Compose

La arquitectura de la aplicación se define y gestiona a través de Docker Compose, una herramienta para definir y ejecutar aplicaciones Docker multi-contenedor. El archivo `docker-compose.yml` es el corazón de esta configuración, describiendo los servicios, redes y volúmenes que componen el sistema. A continuación, se detalla cada componente del despliegue:

#### Visión General del Entorno Orquestado

El sistema está compuesto por varios servicios interdependientes que colaboran para ofrecer la funcionalidad completa de la aplicación. Estos servicios incluyen una base de datos, un motor de Modelos de Lenguaje Grandes (LLM), el backend de la aplicación y una herramienta de automatización. Todos los servicios están configurados para reiniciarse automáticamente (`restart: unless-stopped`) a menos que se detengan explícitamente, garantizando una alta disponibilidad. La comunicación entre ellos se facilita a través de una red Docker personalizada, y la persistencia de los datos se logra mediante volúmenes nombrados.

#### Servicios Definidos

1.  **Servicio de Base de Datos PostgreSQL (`postgres_db`)**
    * **Imagen Docker:** Se utiliza `postgres:15`, una versión específica y robusta del popular sistema de gestión de bases de datos relacionales PostgreSQL.
    * **Nombre del Contenedor:** `housing_postgres_db` para una fácil identificación.
    * **Configuración de Entorno:**
        * `POSTGRES_DB: housing_db`: Define el nombre de la base de datos principal.
        * `POSTGRES_USER: user_test`: Establece el usuario por defecto. **Es crucial cambiar este valor y la contraseña en un entorno de producción.**
        * `POSTGRES_PASSWORD: password_test`: Establece la contraseña para el usuario. **Es crucial cambiar este valor en un entorno de producción.**
    * **Volúmenes:**
        * `postgres_data:/var/lib/postgresql/data`: Se monta un volumen nombrado (`postgres_data`) en el directorio donde PostgreSQL almacena sus datos. Esto asegura que los datos de la base de datos persistan incluso si el contenedor se detiene o se elimina.
        * Las líneas comentadas para `init.sql` y un archivo CSV (`./data/init.sql:/docker-entrypoint-initdb.d/init.sql` y `./data/tu_dataset_completo.csv:/docker-entrypoint-initdb.d/tu_dataset_completo.csv`) indican la posibilidad de ejecutar scripts de inicialización y cargar datos automáticamente al crear la base de datos por primera vez.
    * **Mapeo de Puertos:** `5432:5432` expone el puerto estándar de PostgreSQL del contenedor al mismo puerto en la máquina anfitriona, permitiendo la conexión desde herramientas externas o el propio anfitrión.
    * **Red:** Conectado a `housing_net`.

2.  **Servicio de Modelo de Lenguaje Grande (`ollama`)**
    * **Imagen Docker:** Se emplea `ollama/ollama:latest`, que proporciona una plataforma para ejecutar y gestionar modelos de lenguaje grandes localmente.
    * **Nombre del Contenedor:** `housing_ollama`.
    * **Volúmenes:** `ollama_data:/root/.ollama` utiliza un volumen nombrado para almacenar los modelos descargados y otros datos de configuración de Ollama, evitando la necesidad de redescargar modelos grandes tras reinicios.
    * **Mapeo de Puertos:** `11434:11434` expone el puerto estándar de Ollama para la interacción con la API del LLM.
    * **Red:** Conectado a `housing_net`.

3.  **Servicio de Backend (`backend`)**
    * **Nombre del Contenedor:** `housing_backend_api`.
    * **Construcción (Build):** Se construye a partir de un `Dockerfile` ubicado en el directorio `./backend` (`context: ./backend`). Esto indica que es una aplicación personalizada, probablemente una API REST desarrollada con un framework como FastAPI en Python.
    * **Configuración de Entorno:**
        * `DATABASE_URL: postgresql+psycopg2://user_test:password_test@postgres_db:5432/housing_db`: Define la cadena de conexión a la base de datos PostgreSQL. Utiliza el nombre del servicio (`postgres_db`) para la resolución de DNS dentro de la red Docker.
        * `GOOGLE_API_KEY: ${GOOGLE_API_KEY_FROM_ENV}`: Se espera que la clave API de Google se proporcione a través de una variable de entorno en el anfitrión (leída desde un archivo `.env` no versionado, por seguridad). Esto es crucial para acceder a servicios de Google como Gemini.
        * Las variables comentadas (`OLLAMA_BASE_URL` y `OLLAMA_MODEL`) sugieren una integración opcional o en desarrollo con el servicio `ollama`, permitiendo al backend interactuar con los LLMs.
    * **Mapeo de Puertos:** `8000:8000` expone el puerto de la API del backend, un puerto común para aplicaciones web.
    * **Dependencias (`depends_on`):**
        * `postgres_db: { condition: service_started }`: Asegura que el servicio `backend` solo se inicie una vez que el servicio `postgres_db` esté completamente iniciado y listo para aceptar conexiones. Esto previene errores de conexión al arrancar.
        * La dependencia comentada de `ollama` sugiere que, si se activa, el backend también esperaría a que el servicio Ollama esté disponible.
    * **Volúmenes:** `- ./backend:/app`: Monta el directorio local `./backend` en el directorio `/app` dentro del contenedor. Esto es muy útil para el desarrollo, ya que permite que los cambios en el código fuente se reflejen inmediatamente en la aplicación en ejecución sin necesidad de reconstruir la imagen (si se usa con herramientas de recarga en caliente como Uvicorn con `--reload`).
    * **Red:** Conectado a `housing_net`.

4.  **Servicio de Automatización (`n8n`)**
    * **Imagen Docker:** `n8nio/n8n` es una herramienta de automatización de flujos de trabajo de código abierto.
    * **Nombre del Contenedor:** `housing_n8n`.
    * **Mapeo de Puertos:** `5678:5678` expone la interfaz web y la API de n8n.
    * **Configuración de Entorno:**
        * `GENERIC_TIMEZONE=Europe/Madrid`: Configura la zona horaria para la correcta ejecución de flujos de trabajo basados en tiempo.
        * `N8N_WEBHOOK_CORS_ALLOWED_ORIGINS=http://localhost:5173,http://localhost:3000`: Configura los orígenes permitidos para las solicitudes CORS a los webhooks de n8n, esencial si se interactúa con frontends que se ejecutan en esos puertos.
    * **Volúmenes:** `n8n_data:/home/node/.n8n` utiliza un volumen nombrado para almacenar los flujos de trabajo, credenciales y otros datos de configuración de n8n.
    * **Red:** Conectado a `housing_net`.
    * **Dependencias (`depends_on`):** Depende del servicio `backend`, lo que podría implicar que n8n necesita que la API del backend esté operativa para algunos de sus flujos de trabajo o configuraciones iniciales.

#### Gestión de Datos Persistentes (Volúmenes)

Se definen tres volúmenes nombrados gestionados por Docker:
* `postgres_data`: Almacena los datos de la base de datos PostgreSQL.
* `ollama_data`: Almacena los modelos de lenguaje y la configuración de Ollama.
* `n8n_data`: Almacena los datos y la configuración de n8n.

El uso de volúmenes nombrados es una buena práctica ya que desacopla el ciclo de vida de los datos del ciclo de vida de los contenedores. Los datos persisten incluso si los contenedores se eliminan y se vuelven a crear, lo que es fundamental para bases de datos, modelos descargados y configuraciones de usuario.

#### Configuración de Red

Se define una red personalizada de tipo `bridge` llamada `housing_net`:
* `housing_net: { driver: bridge }`

Utilizar una red de puente personalizada ofrece varias ventajas sobre la red `bridge` por defecto:
* **Aislamiento Mejorado:** Los contenedores en una red personalizada están aislados de otras redes (incluida la predeterminada) a menos que se conecten explícitamente.
* **Resolución de DNS por Nombre de Servicio:** Dentro de esta red, los contenedores pueden descubrirse y comunicarse entre sí utilizando sus nombres de servicio definidos en `docker-compose.yml` (por ejemplo, el backend puede acceder a la base de datos en `postgres_db:5432`). Esto simplifica la configuración de la comunicación entre servicios.

En resumen, este `docker-compose.yml` describe una aplicación robusta y modular, aprovechando las características de Docker para el aislamiento, la persistencia de datos, la comunicación entre servicios y la facilidad de despliegue y desarrollo.

## 5. Resultados y Discusión

Esta sección presenta los principales resultados obtenidos a lo largo del proyecto, abarcando desde el análisis inicial de los datos hasta la evaluación del modelo predictivo final y la funcionalidad de la aplicación web desarrollada.

### 5.1. Principales Hallazgos del Análisis Exploratorio

El Análisis Exploratorio de Datos (EDA), realizado principalmente mediante `Scripts/Aux.EDA.ipynb` y complementado opcionalmente con `Orange/OrangeWorkflow.ows`, reveló varios insights clave sobre el mercado inmobiliario de Barcelona:

* **Distribución de Precios:** Se observó una marcada asimetría positiva en la distribución de los precios de las viviendas, con una concentración de propiedades en rangos de precios más bajos y una cola larga hacia precios más altos. Esto sugirió la posible utilidad de transformaciones (e.g., logarítmica) de la variable objetivo para el modelado.
* **Correlaciones Significativas:**
    * Variables como la **superficie (`size`)**, el **número de habitaciones (`rooms`)** y el **número de baños (`bathrooms`)** mostraron correlaciones positivas esperadas con el precio.
    * La **ubicación geográfica** (representada por `latitude`, `longitude`, y más directamente por `district` y `neighborhood`) demostró ser un factor determinante fundamental, con variaciones sustanciales de precios entre diferentes zonas de la ciudad.
* **Características Relevantes:** La presencia de ascensor (`hasLift`) y si la vivienda es exterior (`exterior`) también mostraron influencia en los precios. El tipo de propiedad (`propertyType`) y su estado (`status`, `conservation`) son igualmente importantes.
* **Comparativas Geográficas:** Se identificaron distritos como Sarrià-Sant Gervasi y Eixample con precios medianos consistentemente más altos, mientras que otros como Nou Barris presentaban precios más accesibles. Dentro de los distritos, también existía una notable variabilidad entre barrios.
* **Valores Atípicos (Outliers):** Se detectaron outliers tanto en el precio como en la superficie. Se tomó la decisión de [**Explicar brevemente cómo se trataron: e.g., "conservarlos si eran válidos y el modelo era robusto, o aplicar truncamiento/transformación para los más extremos para evitar una influencia desmedida"**].
* **Valores Faltantes:** Se analizaron los patrones de datos ausentes. Variables como `parkingSpace_info` o `conservation` tenían un porcentaje considerable de nulos, lo que guio las estrategias de imputación (e.g., imputar con la moda para categóricas, o crear una categoría específica "Desconocido").

### 5.2. Rendimiento del Modelo Predictivo

El modelo final, un `XGBOOST` encapsulado en el pipeline `pipeline_idealista_completo.joblib` (entrenado y evaluado en `Scripts/4ModeloExport.ipynb`), demostró el siguiente rendimiento en el conjunto de prueba (datos no vistos durante el entrenamiento):

MAE  (Mean Absolute Error) : 68,804.19 €
RMSE (Root Mean Squared Error): 137,169.68 €
R²   (R-squared)           : 0.8706

**Análisis de Residuos:**
La distribución de los residuos (diferencia entre precios reales y predichos) se analizó para detectar posibles sesgos. Idealmente, los residuos deberían estar centrados en cero y distribuidos normalmente. 

<img width="702" alt="image" src="https://github.com/user-attachments/assets/f225bd99-bec4-40b6-b5d4-e96136843e8c" />

<img width="686" alt="image" src="https://github.com/user-attachments/assets/68f81e03-2ed2-400c-b7c8-45f478012130" />


**Importancia de Características:**
Las características más influyentes en las predicciones del modelo `RandomForestRegressor` fueron:
1.  `longitude` / `latitude` (Ubicación geográfica)
2.  `size` (Superficie)
3.  `district` / `neighborhood` (codificados mediante Target Encoding)
4.  `rooms` (Número de habitaciones)
5.  `bathrooms` (Número de baños)


Esto confirma la intuición de que la superficie y la ubicación son los principales determinantes del precio, seguidos por la distribución interna de la vivienda.

### 5.3. Uso del modelo Análisis de Pronósticos

Los pronósticos generados por el modelo se utilizan principalmente a través de la **aplicación web desarrollada**:
* Los usuarios pueden introducir las características de una vivienda en el `ValuationForm.jsx` y obtener una estimación de precio instantánea. Esto proporciona una herramienta práctica para compradores, vendedores o curiosos del mercado.
* La precisión del modelo puede variar ligeramente entre diferentes segmentos del mercado.

Además de las predicciones de precio, la aplicación web, mediante su **asistente IA (`ChatDialog.jsx`)**, permite a los usuarios realizar consultas en lenguaje natural sobre la base de datos de viviendas. Por ejemplo:
* _"¿Cuál es el precio medio por metro cuadrado en el barrio de Gràcia?"_
* _"¿Cuántos pisos de 3 habitaciones con ascensor hay en venta en Eixample?"_
* _"Muéstrame las características de la propiedad con código XXXXX."_

Esta funcionalidad, impulsada por el agente Langchain/LLM en el backend, añade una capa significativa de utilidad al sistema, permitiendo una exploración de datos más intuitiva y accesible que no se limita solo a la predicción de precios.

### 5.4. Limitaciones del Estudio

Es crucial reconocer las limitaciones inherentes a este proyecto y al modelo desarrollado:

* **Calidad y Alcance de los Datos:**
    * Los datos provienen de un portal inmobiliario (Idealista) y pueden no representar la totalidad de las transacciones del mercado (omitiendo ventas privadas o de otros portales).
    * Los precios listados son precios de oferta, no necesariamente los precios finales de transacción.
    * La información proporcionada en los listados puede tener errores, omisiones o estar desactualizada. Algunas características subjetivas (calidad de las reformas, vistas, nivel de ruido) son difíciles de cuantificar y no suelen estar disponibles.
* **Variables No Consideradas:** El modelo se basa en las características disponibles. Factores externos como condiciones macroeconómicas específicas no reflejadas en los datos, cambios urbanísticos muy recientes, o detalles muy específicos de la calidad de construcción no se pudieron incluir directamente.
* **Generalización y Dinamismo del Modelo:**
    * El modelo está entrenado para el mercado de Barcelona durante el periodo de recolección de datos. Su aplicabilidad directa a otras ciudades o incluso a Barcelona en un futuro distante (sin reentrenamiento) es limitada.
    * El mercado inmobiliario es dinámico. El modelo necesitará reentrenamiento periódico con datos frescos para mantener su precisión y relevancia.
* **Suposiciones del Modelo:** Todo modelo de Machine Learning se basa en ciertas suposiciones. Aunque se ha buscado el mejor rendimiento, estas suposiciones pueden no cumplirse perfectamente en la realidad.
* **Interpretabilidad vs. Complejidad:** Mientras que modelos como RandomForest ofrecen métricas de importancia de características, la forma exacta en que se combinan para llegar a una predicción individual puede ser compleja (efecto "caja negra").
* **Dependencias Externas:** La funcionalidad del asistente IA depende de la disponibilidad y políticas de la API de Google Gemini. La adquisición de datos depende de la API de Idealista. Cambios en estas APIs podrían requerir adaptaciones.
* **Prototipo de Aplicación:** La aplicación web desarrollada es un prototipo para demostrar la funcionalidad. Un despliegue en producción requeriría consideraciones adicionales de seguridad, escalabilidad, pruebas exhaustivas y experiencia de usuario.

## 6. Conclusiones

El proyecto "Análisis y Pronóstico de Viviendas en Barcelona" ha logrado desarrollar un sistema integral que abarca la recopilación, procesamiento, análisis y modelado de datos del mercado inmobiliario, culminando en una aplicación web funcional para la valoración de propiedades y la consulta inteligente de datos. [cite: 29, 30, 31, 32, 33, 34, 35, 36, 37, 174, 175]

Los principales hitos y conclusiones del proyecto son:

* **Recopilación y Procesamiento de Datos Robusto:** Se implementó un pipeline eficiente para la extracción de datos desde la API de Idealista, su almacenamiento en una base de datos PostgreSQL con PostGIS para el manejo de información geoespacial, y un exhaustivo proceso de limpieza y preprocesamiento para preparar los datos para el modelado. [cite: 67, 68, 69, 70, 71, 72]
   
* **Modelo Predictivo de Alto Rendimiento:** Se desarrolló y entrenó un modelo de Machine Learning (XGBoost Regressor) que demostró una capacidad predictiva significativa, con un MAE de \MAE  (Mean Absolute Error) : 68,804.19 € y un R² de \R²   (R-squared)           : 0.8706 €. [cite: 151, 152, 153, 154, 155, 156, 157, 312, 313]
   
* **Aplicación Web Funcional e Interactiva:** Se construyó un prototipo de aplicación web con un frontend en React y un backend en FastAPI, que permite a los usuarios obtener valoraciones de viviendas, realizar consultas en lenguaje natural sobre el mercado inmobiliario y solicitar informes detallados. [cite: 174, 175, 190, 191]
   
* **Integración de Tecnologías Avanzadas:** El proyecto integró diversas tecnologías de vanguardia, incluyendo Langchain con Google Gemini para el procesamiento del lenguaje natural, lo que añade un valor diferencial a la aplicación al facilitar la interacción intuitiva con los datos. [cite: 196, 197, 198, 199, 200, 201]

Si bien el modelo predictivo muestra un buen rendimiento, es crucial reconocer las limitaciones inherentes a los datos utilizados y la naturaleza dinámica del mercado inmobiliario. [cite: 323, 324, 325, 326, 327, 328, 329, 330, 331]

Las futuras líneas de trabajo se centrarán en la expansión de las fuentes de datos, la incorporación de técnicas de modelado más avanzadas, y la mejora de la aplicación web para convertirla en una herramienta aún más completa y útil para los usuarios. [cite: 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374]


## 7. Lecciones Aprendidas y Retos Superados

Durante el desarrollo del proyecto "Análisis y Pronóstico de Viviendas en Barcelona", se enfrentaron diversos retos y se extrajeron valiosas lecciones que enriquecen la experiencia y pueden guiar futuros trabajos:

* **Retos Técnicos y Metodológicos:**
    * **Gestión de APIs y Datos Externos:** La dependencia de la API de Idealista implicó adaptarse a sus límites de tasa, la estructura de sus respuestas y manejar posibles inconsistencias o cambios. La calidad y completitud de los datos provenientes de portales públicos siempre presenta desafíos (e.g., datos faltantes, errores de entrada).
    * **Preprocesamiento de Datos Complejo y Artesanal:** La limpieza de datos fue una tarea intensiva, requiriendo un tratamiento específico para columnas como `floor` (con múltiples formatos de entrada), la correcta conversión de tipos, y el manejo de un volumen considerable de características. La ingeniería de características, especialmente para datos geográficos (latitud, longitud) y categóricos de alta cardinalidad (como `neighborhood`), fue crucial pero compleja.
    * **Optimización de Modelos y Evitar Sobreajuste:** Encontrar el equilibrio adecuado entre la complejidad del modelo (`XGBOOST`), su rendimiento predictivo y su capacidad de generalización fue un proceso iterativo. La selección cuidadosa de hiperparámetros y una estrategia de validación robusta (división entrenamiento/prueba, y opcionalmente validación cruzada) fueron esenciales para mitigar el sobreajuste.
    * **Integración de Múltiples Tecnologías (Full-Stack):** Orquestar el flujo de trabajo entre Python para el backend y el modelado, React para el frontend, FastAPI para la API, Langchain con un LLM (Gemini), y PostgreSQL, requirió un entendimiento de cada componente y asegurar una comunicación eficiente y sin errores entre ellos.
    * **Desarrollo Frontend-Backend:** Definir contratos de API claros (Pydantic en FastAPI fue de gran ayuda), manejar el estado de la aplicación en el frontend (especialmente con formularios multi-paso y llamadas asíncronas a la API), y depurar la comunicación de extremo a extremo fueron tareas que consumieron tiempo y esfuerzo significativos.
    * **Configuración del Entorno de Desarrollo y Despliegue:** Asegurar que todos los componentes (base de datos, backend, LLM) tuvieran las variables de entorno correctas (API keys, URLs de base de datos, credenciales) y que las dependencias estuvieran correctamente gestionadas fue fundamental, especialmente al considerar un futuro despliegue.

* **Lecciones Aprendidas:**
    * **Importancia Crítica del EDA:** Un Análisis Exploratorio de Datos exhaustivo y visual no solo es el primer paso, sino una guía constante durante todo el proyecto. Ayuda a comprender los datos en profundidad, a tomar decisiones informadas sobre el preprocesamiento y la ingeniería de características, y a formular hipótesis relevantes para el modelado.
    * **Valor Incalculable de los Pipelines Reproducibles:** El uso de `Pipeline` y `ColumnTransformer` de Scikit-learn es absolutamente esencial. Permite encapsular todos los pasos de preprocesamiento y el modelo en un único objeto, garantizando que las transformaciones se apliquen de manera consistente durante el entrenamiento, la evaluación y, crucialmente, en producción al hacer predicciones con nuevos datos. Serializar este pipeline completo con `joblib` es la clave para un despliegue fiable.
    * **La Validación Rigurosa No es Opcional:** Una estrategia de validación bien pensada (train-test split como mínimo, idealmente con validación cruzada para la selección de hiperparámetros) es vital para obtener una estimación realista del rendimiento del modelo en datos no vistos y para protegerse contra el sobreajuste.
    * **Iteración y Prototipado Rápido:** El desarrollo de un proyecto de ciencia de datos, y más aún uno full-stack, es inherentemente iterativo. Es preferible comenzar con modelos más simples y funcionalidades básicas, y añadir complejidad gradualmente. Prototipar rápidamente la aplicación (frontend/backend) ayuda a identificar problemas de integración y usabilidad en etapas tempranas.
    * **La Comunicación de Resultados es Clave:** Un modelo, por preciso que sea, tiene un valor limitado si sus resultados no pueden ser comunicados y entendidos de manera efectiva. La creación de herramientas interactivas (como la aplicación web) o dashboards visuales es crucial para traducir los hallazgos técnicos en insights accionables para los usuarios finales.
    * **Modularidad y Desacoplamiento en el Diseño de Software:** Diseñar la aplicación con componentes modulares y una clara separación de responsabilidades (e.g., frontend para la presentación, backend para la lógica de negocio y el acceso a datos) facilita enormemente el desarrollo, las pruebas, el mantenimiento y la colaboración en equipo.
    * **El Potencial Transformador de los LLMs para la Interacción con Datos:** La integración de un agente LLM (como el SQL Agent con Gemini) demostró cómo se puede transformar radicalmente la manera en que los usuarios interactúan con bases de datos complejas. Permitir consultas en lenguaje natural democratiza el acceso a la información y abre nuevas posibilidades de exploración de datos que van más allá de los formularios predefinidos.
    * **La Documentación es una Inversión, no un Gasto:** Mantener una documentación clara y actualizada (como esta memoria, `readme.md`, comentarios en el código) es fundamental para la comprensión del proyecto, su reproducibilidad y su mantenimiento a largo plazo.

## 8. Trabajos Futuros y Líneas de Mejora

El proyecto actual "Análisis y Pronóstico de Viviendas en Barcelona" ha sentado una base robusta y funcional. Sin embargo, existen numerosas oportunidades para futuras expansiones y mejoras que podrían aumentar aún más su precisión, utilidad y alcance:

* **Enriquecimiento de Fuentes y Tipos de Datos:**
    * **Datos Catastrales Oficiales:** Incorporar información detallada y verificada del catastro (e.g., año exacto de construcción, calidad constructiva oficial, usos permitidos, superficie catastral) podría mejorar significativamente la precisión y fiabilidad del modelo.
    * **Datos Socioeconómicos y Demográficos:** Integrar datos a nivel de barrio o sección censal (renta media disponible, nivel de estudios, densidad de población, tasa de desempleo, edad media de la población) para capturar el contexto socioeconómico de las ubicaciones.
    * **Puntos de Interés (POIs) y Servicios:** Añadir características basadas en la proximidad a servicios clave como estaciones de transporte público (metro, autobús), escuelas, hospitales, parques, zonas comerciales, y la densidad de estos servicios en el entorno.
    * **Datos de Transacciones Reales:** Si se pudiera acceder a datos de precios de cierre reales de ventas (no solo precios de oferta de portales), el modelo reflejaría de manera más fidedigna la dinámica real del mercado y los precios efectivos de transacción.
    * **Datos de Calidad Ambiental:** Variables como la calidad del aire, niveles de ruido, o la presencia de zonas verdes cercanas podrían ser factores influyentes.
    * **Descripciones Textuales e Imágenes:** Aplicar técnicas de Procesamiento de Lenguaje Natural (NLP) a las descripciones de las viviendas y de Visión por Computador a las imágenes para extraer características adicionales (e.g., "reformado recientemente", "vistas al mar", "luminoso", calidad de los acabados).

* **Modelado Predictivo Avanzado y Refinamiento:**
    * **Modelos de Series Temporales:** Si se dispone de un historial suficientemente largo y granular de transacciones o listados, explorar modelos como ARIMA, SARIMA, Prophet o modelos basados en LSTMs para analizar y predecir la evolución temporal de los precios y las tendencias del mercado.
    * **Modelos Geoespacialmente Ponderados (GWR):** Para capturar de forma más explícita la heterogeneidad espacial, permitiendo que las relaciones entre las variables y el precio varíen geográficamente dentro de Barcelona.
    * **Técnicas de Deep Learning:** Explorar arquitecturas de Redes Neuronales más complejas para datos tabulares (e.g., TabNet, NODE) o para la integración multimodal de datos (tabulares, textuales, imágenes).
    * **Modelos de Ensemble más Avanzados:** Experimentar con técnicas de stacking o blending de diferentes tipos de modelos para potencialmente mejorar la robustez y precisión.
    * **Análisis de Causalidad:** Ir más allá de las correlaciones e intentar aplicar técnicas de inferencia causal (e.g., variables instrumentales, difference-in-differences si los datos lo permiten) para entender mejor qué factores *causan* las variaciones en los precios.

* **Mejoras y Expansión de la Aplicación Web (Frontend/Backend):**
    * **Autenticación y Perfiles de Usuario:** Permitir a los usuarios registrarse, iniciar sesión, guardar sus valoraciones, configurar preferencias y recibir alertas personalizadas.
    * **Historial de Valoraciones y Búsquedas:** Que los usuarios puedan acceder a un historial de las propiedades que han valorado o buscado.
    * **Funcionalidades Avanzadas del Asistente IA (Chat):**
        * Mayor capacidad de contexto y seguimiento de la conversación a lo largo de varias interacciones.
        * Posibilidad de realizar acciones más complejas (e.g., "muéstrame pisos similares al que valoré con un precio un 10% inferior").
        * Integración con otras fuentes de datos o APIs externas a través del LLM para enriquecer las respuestas (e.g., información turística, servicios cercanos).
    * **Despliegue en Producción Robusto y Escalable:** Contenerizar la aplicación completa (frontend, backend, base de datos si es necesario) utilizando Docker y orquestarla con Kubernetes para asegurar escalabilidad, alta disponibilidad y gestión eficiente de recursos.
    * **Monitorización Continua del Modelo:** Implementar un sistema para monitorizar el rendimiento del modelo en producción, detectando posibles derivas en los datos (data drift) o en los conceptos (concept drift) que puedan degradar su precisión.
    * **Mecanismos de Reentrenamiento Automático o Semiautomático:** Desarrollar un pipeline MLOps que permita reentrenar el modelo periódicamente con nuevos datos, evaluarlo y desplegar la nueva versión de forma controlada.
    * **Optimización del Rendimiento del Backend:** Para manejar un mayor número de solicitudes concurrentes, optimizando consultas a la base de datos y la eficiencia del código.
    * **Interfaz de Usuario Más Rica y Personalizada:** Mejorar la visualización de datos dentro de la propia aplicación (e.g., mapas de calor de precios interactivos, gráficos comparativos de barrios, informes personalizados descargables).
    * **Internacionalización (i18n) y Localización (l10n):** Adaptar la aplicación para múltiples idiomas y regiones.

* **Expansión Funcional y Geográfica del Sistema:**
    * **Análisis Comparativo de Mercado (CMA):** Extender la herramienta para ayudar a generar informes de CMA para agentes inmobiliarios o particulares, comparando una propiedad con otras similares vendidas recientemente.
    * **Sistema de Recomendación de Propiedades:** Desarrollar un motor de recomendación que sugiera propiedades a los usuarios basándose en sus preferencias, búsquedas anteriores y características de las viviendas.
    * **Adaptación a Otros Mercados Geográficos:** Replicar y adaptar el sistema completo (adquisición de datos, entrenamiento de modelos específicos, configuración geográfica) para analizar y predecir precios en otras ciudades o regiones.

## 9. Referencias

A continuación, se listan algunas de las fuentes, documentaciones y recursos clave consultados o relevantes para el desarrollo de este proyecto. Esta lista no es exhaustiva pero representa las tecnologías y conceptos fundamentales empleados.

* **Librerías Python y Ecosistema de Ciencia de Datos:**
    * **Pandas:** Wes McKinney. (2010). Data structures for statistical computing in python. *Proceedings of the 9th Python in Science Conference, 445*, 51-56.
        * Documentación: [https://pandas.pydata.org/pandas-docs/stable/](https://pandas.pydata.org/pandas-docs/stable/)
    * **NumPy:** Harris, C. R., Millman, K. J., van der Walt, S. J., et al. (2020). Array programming with NumPy. *Nature, 585*(7825), 357-362.
        * Documentación: [https://numpy.org/doc/](https://numpy.org/doc/)
    * **Scikit-learn:** Pedregosa, F., Varoquaux, G., Gramfort, A., Michel, V., Thirion, B., Grisel, O., ... & Duchesnay, É. (2011). Scikit-learn: Machine learning in Python. *Journal of Machine Learning Research, 12*(Oct), 2825-2830.
        * Documentación: [https://scikit-learn.org/stable/documentation.html](https://scikit-learn.org/stable/documentation.html)
    * **Joblib:**
        * Documentación: [https://joblib.readthedocs.io/](https://joblib.readthedocs.io/)
    * **Category Encoders:** Librería para diversas estrategias de codificación de variables categóricas.
        * Repositorio: [https://github.com/scikit-learn-contrib/category_encoders](https://github.com/scikit-learn-contrib/category_encoders)
    * **Matplotlib:** Hunter, J. D. (2007). Matplotlib: A 2D graphics environment. *Computing in Science & Engineering, 9*(3), 90-95.
        * Documentación: [https://matplotlib.org/stable/contents.html](https://matplotlib.org/stable/contents.html)
    * **Seaborn:** Waskom, M. L. (2021). Seaborn: statistical data visualization. *Journal of Open Source Software, 6*(60), 3021.
        * Documentación: [https://seaborn.pydata.org/](https://seaborn.pydata.org/)
    * **Requests:** Librería HTTP para Python.
        * Documentación: [https://requests.readthedocs.io/](https://requests.readthedocs.io/)

* **Backend y API:**
    * **FastAPI:** Framework web moderno para construir APIs con Python 3.7+.
        * Documentación: [https://fastapi.tiangolo.com/](https://fastapi.tiangolo.com/)
    * **Pydantic:** Validación de datos y gestión de configuraciones usando anotaciones de tipo Python.
        * Documentación: [https://docs.pydantic.dev/](https://docs.pydantic.dev/)
    * **SQLAlchemy:** SQL Toolkit y Object Relational Mapper (ORM) para Python.
        * Documentación: [https://www.sqlalchemy.org/](https://www.sqlalchemy.org/)
    * **Psycopg2:** Adaptador de base de datos PostgreSQL para Python.
        * Documentación: [https://www.psycopg.org/](https://www.psycopg.org/)
    * **Uvicorn:** Servidor ASGI para FastAPI.
        * Documentación: [https://www.uvicorn.org/](https://www.uvicorn.org/)

* **Frontend:**
    * **React:** Librería JavaScript para construir interfaces de usuario.
        * Documentación: [https://react.dev/](https://react.dev/)
    * **Material-UI (MUI):** Biblioteca de componentes React para un desarrollo de UI más rápido y sencillo.
        * Documentación: [https://mui.com/](https://mui.com/)
    * **Leaflet:** Librería JavaScript de código abierto para mapas interactivos optimizados para móviles.
        * Documentación: [https://leafletjs.com/](https://leafletjs.com/)
    * **React Leaflet:** Enlaces React para Leaflet.
        * Documentación: [https://react-leaflet.js.org/](https://react-leaflet.js.org/)
    * **Vite:** Herramienta de frontend de próxima generación para un desarrollo web más rápido y ágil.
        * Documentación: [https://vitejs.dev/](https://vitejs.dev/)

* **Modelos de Lenguaje Grande (LLM) y Agentes:**
    * **Langchain:** Framework para desarrollar aplicaciones impulsadas por modelos de lenguaje.
        * Documentación: [https://python.langchain.com/](https://python.langchain.com/)
    * **Google Gemini API:** Modelos de IA generativa de Google.
        * Documentación: [https://ai.google.dev/docs](https://ai.google.dev/docs)

* **Base de Datos y Otras Herramientas:**
    * **PostgreSQL:** Potente sistema de gestión de bases de datos relacional de código abierto.
        * Documentación: [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)
    * **PostGIS:** Extensión espacial para la base de datos PostgreSQL.
        * Documentación: [https://postgis.net/documentation/](https://postgis.net/documentation/)
    * **R Project for Statistical Computing:**
        * Web: [https://www.r-project.org/](https://www.r-project.org/)
    * **Orange Data Mining:**
        * Web: [https://orangedatamining.com/](https://orangedatamining.com/)
    * **Microsoft Power BI:**
        * Documentación: [https://docs.microsoft.com/en-us/power-bi/](https://docs.microsoft.com/en-us/power-bi/)

* **Fuentes de Datos y APIs Externas Específicas:**
    * **Idealista API:**
        * (Se referenciaría la URL de la documentación oficial de la API si estuviera disponible públicamente. De lo contrario, se mencionaría como documentación interna o acceso proporcionado por Idealista).

* **Libros y Conceptos Fundamentales (Ejemplos):**
    * Hastie, T., Tibshirani, R., & Friedman, J. (2009). *The Elements of Statistical Learning: Data Mining, Inference, and Prediction*. Springer.
    * Goodfellow, I., Bengio, Y., & Courville, A. (2016). *Deep Learning*. MIT Press.
    * Grus, J. (2019). *Data Science from Scratch: First Principles with Python*. O'Reilly Media.

*(Nota: Es recomendable que, al referenciar, se incluyan las versiones específicas de las librerías y herramientas utilizadas si son cruciales para la reproducibilidad del proyecto).*

## 10. Apéndices

### 10.1. Apéndice A: Esquema Detallado de la Base de Datos

A continuación, se presenta un ejemplo del Data Definition Language (DDL) para la tabla principal utilizada en la base de datos PostgreSQL, `pisos_barcelona`. Este esquema refleja las columnas relevantes después de la limpieza inicial y la consideración de los tipos de datos apropiados para el análisis y las consultas espaciales con PostGIS. Es importante notar que el esquema final puede haber evolucionado ligeramente durante el desarrollo del proyecto.

```sql
-- DDL para la tabla principal 'pisos_barcelona'
-- Se recomienda ejecutar `CREATE EXTENSION IF NOT EXISTS postgis;` antes si no está habilitada.

CREATE TABLE IF NOT EXISTS pisos_barcelona (
    -- Identificadores
    id_interno SERIAL PRIMARY KEY,                      -- Clave primaria interna autoincremental de la BD
    propertyCode VARCHAR(50) UNIQUE NOT NULL,         -- Código único de la propiedad de Idealista

    -- Características principales de la vivienda
    price NUMERIC(12, 2),                             -- Precio de la vivienda en Euros
    size NUMERIC(8, 2),                               -- Superficie en metros cuadrados (e.g., construida)
    rooms INTEGER,                                    -- Número de habitaciones
    bathrooms INTEGER,                                -- Número de baños
    floor_numeric REAL,                               -- Planta (convertida a numérico, ej: 0 para bajo, -1 sótano, 0.5 entresuelo)
    propertyType VARCHAR(100),                        -- Tipo de propiedad (piso, casa, ático, dúplex, etc.)
    status VARCHAR(100),                              -- Estado general (buen estado, a reformar, obra nueva)
    conservation VARCHAR(100),                        -- Estado de conservación específico (si disponible)
    
    -- Características adicionales (booleanas o categóricas simples)
    exterior BOOLEAN,                                 -- Si la vivienda es exterior
    hasLift BOOLEAN,                                  -- Si el edificio tiene ascensor
    hasParking BOOLEAN,                               -- Indicador general si tiene parking (puede requerir más detalle)
    isParkingIncludedInPrice BOOLEAN,                 -- Si el parking (si existe) está incluido en el precio
    newDevelopment BOOLEAN,                           -- Si es una promoción de obra nueva
    
    -- Ubicación
    address TEXT,                                     -- Dirección textual completa o parcial de la propiedad
    district VARCHAR(100),                            -- Distrito de Barcelona (e.g., Eixample, Gràcia)
    neighborhood VARCHAR(100),                        -- Barrio dentro del distrito (e.g., La Sagrada Família)
    latitude NUMERIC(10, 7),                          -- Latitud geográfica (coordenadas WGS84)
    longitude NUMERIC(10, 7),                         -- Longitud geográfica (coordenadas WGS84)
    geometry GEOMETRY(Point, 4326),                   -- Coordenadas geométricas para PostGIS (SRID 4326 para WGS84)
    
    -- Datos de la API y metadatos del listado
    operation VARCHAR(50),                            -- Tipo de operación (e.g., 'sale', 'rent')
    priceByArea NUMERIC(10, 2),                       -- Precio por metro cuadrado (calculado o de API)
    
    -- Columnas para datos estructurados complejos (convertidas a JSONB desde strings de API)
    priceInfo JSONB,                                  -- Información detallada del precio (e.g., impuestos, comunidad)
    detailedType JSONB,                               -- Tipo detallado de propiedad según Idealista (e.g., {typology, subTypology})
    suggestedTexts JSONB,                             -- Textos sugeridos por Idealista (e.g., {title, subtitle})
    parkingSpace_info JSONB,                          -- Información detallada del parking (si se procesó a JSONB)
    -- Se podrían añadir otras columnas JSONB si fueran relevantes: 'change', 'highlight', 'savedAd'
    
    -- Timestamps y control
    fecha_extraccion_api TIMESTAMP,                   -- Fecha de extracción original de la API Idealista
    fecha_carga_bd TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha de carga/actualización del registro en la BD
);

-- Creación de índices para optimizar consultas (ejemplos)
-- Estos índices mejoran el rendimiento de búsquedas y ordenaciones frecuentes.
CREATE INDEX IF NOT EXISTS idx_pisos_barcelona_price ON pisos_barcelona (price);
CREATE INDEX IF NOT EXISTS idx_pisos_barcelona_size ON pisos_barcelona (size);
CREATE INDEX IF NOT EXISTS idx_pisos_barcelona_district ON pisos_barcelona (district);
CREATE INDEX IF NOT EXISTS idx_pisos_barcelona_neighborhood ON pisos_barcelona (neighborhood);
CREATE INDEX IF NOT EXISTS idx_pisos_barcelona_propertytype ON pisos_barcelona (propertyType);

-- El índice espacial GIST sobre la columna 'geometry' es crucial para consultas geoespaciales
-- y se crea mediante el script `CrearIndiceEspacial.sql`.
-- CREATE INDEX IF NOT EXISTS idx_pisos_barcelona_geom ON pisos_barcelona USING GIST (geometry);

-- Comentarios sobre las columnas para mayor claridad (se pueden añadir en PostgreSQL)
COMMENT ON COLUMN pisos_barcelona.floor_numeric IS 'Planta numérica: 0 para bajo, -1 para sótano, 0.5 para entresuelo, números enteros para otras plantas.';
COMMENT ON COLUMN pisos_barcelona.geometry IS 'Coordenadas geográficas de la propiedad en formato WGS84 (SRID 4326) para uso con PostGIS.';

```

## 10.2. Apéndice B: Scripts SQL Clave

En esta sección se detallan los scripts SQL fundamentales utilizados para la creación, gestión y optimización de la base de datos del proyecto. A continuación, se presenta el contenido y la descripción de cada uno de ellos:

### `CrearTabla.sql`

Este script se encarga de la definición y creación de la tabla principal `pisos_barcelona` donde se almacenan todos los datos relativos a las propiedades. Define la estructura de la tabla, los tipos de datos de cada columna y la clave primaria.

```sql
CREATE TABLE pisos_barcelona (
    propertyCode BIGINT PRIMARY KEY,
    thumbnail TEXT,
    externalReference VARCHAR(100),
    numPhotos SMALLINT,
    floor VARCHAR(50),
    price NUMERIC(12, 2),
    priceInfo TEXT, -- CAMBIADO A TEXT
    propertyType VARCHAR(50),
    operation VARCHAR(20),
    size NUMERIC(8, 2),
    exterior TEXT, -- Mantenido TEXT
    rooms SMALLINT,
    bathrooms SMALLINT,
    address TEXT,
    province VARCHAR(100),
    municipality VARCHAR(100),
    district VARCHAR(100),
    country VARCHAR(10),
    neighborhood VARCHAR(100),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    showAddress BOOLEAN,
    url TEXT,
    distance INTEGER,
    description TEXT,
    hasVideo BOOLEAN,
    status VARCHAR(50),
    newDevelopment BOOLEAN,
    hasLift TEXT, -- Mantenido TEXT
    priceByArea NUMERIC(10, 2),
    change TEXT, -- Ya era TEXT o ahora es TEXT
    detailedType TEXT, -- CAMBIADO A TEXT
    suggestedTexts TEXT, -- CAMBIADO A TEXT
    hasPlan BOOLEAN,
    has3DTour BOOLEAN,
    has360 BOOLEAN,
    hasStaging BOOLEAN,
    highlight TEXT, -- Ya era TEXT o ahora es TEXT
    savedAd TEXT, -- Ya era TEXT o ahora es TEXT
    notes TEXT,
    topNewDevelopment BOOLEAN,
    topPlus BOOLEAN,
    parkingSpace TEXT, -- CAMBIADO A TEXT
    newDevelopmentFinished TEXT, -- Ya era TEXT
    geometry GEOMETRY(Point, 4326)
);
```
## PasarDatosCSV.sql

Este script facilita la carga masiva de datos desde un archivo CSV (`housing_data_current.csv`) a la tabla `pisos_barcelona`. Especifica el formato del archivo CSV, el delimitador, y cómo manejar los valores nulos durante la importación.

```sql
COPY pisos_barcelona (
    propertyCode, thumbnail, externalReference, numPhotos, floor, price, priceInfo,
    propertyType, operation, size, exterior, rooms, bathrooms, address, province,
    municipality, district, country, neighborhood, latitude, longitude, showAddress,
    url, distance, description, hasVideo, status, newDevelopment, hasLift, priceByArea,
    change, detailedType, suggestedTexts, hasPlan, has3DTour, has360, hasStaging,
    highlight, savedAd, notes, topNewDevelopment, topPlus, parkingSpace,
    newDevelopmentFinished
)
FROM '/tmp/housing_data_current.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    QUOTE '"',
    NULL ''
);
```

## AjustarValores.sql

El propósito de este script es realizar ajustes en los tipos de datos de ciertas columnas de la tabla `pisos_barcelona` después de la carga inicial. Específicamente, convierte columnas que almacenan cadenas con formato JSON (utilizando comillas simples) al tipo de dato `JSONB` nativo de PostgreSQL (que utiliza comillas dobles), permitiendo así consultas y manipulaciones más eficientes de estos datos. Se manejan explícitamente los casos de valores `NULL` o vacíos en la columna `parkingSpace` para evitar errores durante la conversión.

```sql
-- Para priceInfo
ALTER TABLE pisos_barcelona
ALTER COLUMN priceInfo TYPE JSONB
USING replace(priceInfo, '''', '"')::jsonb;

-- Para detailedType
ALTER TABLE pisos_barcelona
ALTER COLUMN detailedType TYPE JSONB
USING replace(detailedType, '''', '"')::jsonb;

-- Para suggestedTexts
ALTER TABLE pisos_barcelona
ALTER COLUMN suggestedTexts TYPE JSONB
USING replace(suggestedTexts, '''', '"')::jsonb;

-- Para parkingSpace (¡Ojo! Puede tener NULLs, la conversión fallará en NULLs si no se maneja)
ALTER TABLE pisos_barcelona
ALTER COLUMN parkingSpace TYPE JSONB
USING CASE
        WHEN parkingSpace IS NULL OR parkingSpace = '{}' OR parkingSpace = '' THEN NULL -- Maneja NULLs y vacíos explícitamente
        ELSE replace(parkingSpace, '''', '"')::jsonb
      END;
```

## CrearIndiceEspacial.sql

Este script es crucial para optimizar las consultas espaciales. Crea un índice GIST (Generalized Search Tree) sobre la columna `geometry` de la tabla `pisos_barcelona`. Esta columna almacena la información geoespacial de las propiedades (puntos geográficos), y el índice GIST permite realizar búsquedas y análisis espaciales de manera mucho más eficiente.

```sql
CREATE INDEX idx_pisos_barcelona_geom ON pisos_barcelona USING GIST (geometry);
```

**Explicación:**

  * **`CREATE INDEX idx_pisos_barcelona_geom ON pisos_barcelona`**: Esta instrucción SQL crea un nuevo índice llamado `idx_pisos_barcelona_geom` en la tabla `pisos_barcelona`.
  * **`USING GIST (geometry)`**: Especifica el tipo de índice que se va a crear. En este caso, se utiliza un índice GIST. Los índices GIST son especialmente eficientes para indexar datos espaciales, así como otros tipos de datos complejos como rangos y arrays. La parte `(geometry)` indica que el índice se creará sobre la columna `geometry`, que contiene los datos de ubicación geográfica de las propiedades.

Al crear este índice GIST en la columna `geometry`, las consultas que involucren operaciones espaciales (por ejemplo, buscar propiedades dentro de un radio determinado, encontrar la propiedad más cercana a un punto, etc.) se ejecutarán significativamente más rápido, ya que el sistema podrá utilizar el índice para localizar los datos relevantes de manera eficiente en lugar de tener que escanear toda la tabla.

## 10.3. Apéndice C: Métricas Detalladas de Evaluación del Modelo

Esta sección presenta una visión profunda del rendimiento del modelo predictivo final (XGBOOST) y, opcionalmente, de otros modelos considerados durante la fase de experimentación.

### Métricas Detalladas del Modelo Final (XGBOOST):

La evaluación de un modelo de regresión se basa en varias métricas que cuantifican su precisión y capacidad de generalización.

--- Evaluación Final del Modelo en Conjunto de Prueba (Escala Original) ---

* **MAE (Mean Absolute Error / Error Absoluto Medio):** 68,804.19 €
    * **Justificación Matemática Breve:** El MAE mide el promedio de las diferencias absolutas entre los valores predichos y los valores reales. Es menos sensible a outliers que el RMSE. Se calcula como:
        $$MAE = \frac{1}{N} \sum_{i=1}^{N} |y_i - \hat{y}_i|$$
        Donde:
        * $N$ es el número total de observaciones.
        * $y_i$ es el valor real de la i-ésima observación.
        * $\hat{y}_i$ es el valor predicho para la i-ésima observación.
        [Fuente: TJ Gokken - Mean Absolute Error (MAE)](https://tjgokken.com/mean-absolute-error-mae-the-no-drama-loss-function)

* **RMSE (Root Mean Squared Error / Raíz del Error Cuadrático Medio):** 137,169.68 €
    * **Justificación Matemática Breve:** El RMSE es la raíz cuadrada del promedio de los errores al cuadrado. Penaliza más los errores grandes debido al término cuadrático. Se calcula como:
        $$RMSE = \sqrt{\frac{\sum_{i=1}^{N} (y_i - \hat{y}_i)^2}{N}}$$
        Donde:
        * $N$ es el número total de observaciones.
        * $y_i$ es el valor real de la i-ésima observación.
        * $\hat{y}_i$ es el valor predicho para la i-ésima observación.
        [Fuente: Deepchecks - What is Root Mean Square Error?](https://www.deepchecks.com/glossary/root-mean-square-error/)

* **R² (R-squared / Coeficiente de Determinación):** 0.8706
    * **Justificación Matemática Breve:** R² representa la proporción de la varianza de la variable dependiente que es predecible a partir de las variables independientes. Un valor cercano a 1 indica un buen ajuste del modelo. Se calcula como:
        $$R^2 = 1 - \frac{\sum_{i=1}^{N} (y_i - \hat{y}_i)^2}{\sum_{i=1}^{N} (y_i - \bar{y})^2}$$
        Donde:
        * $y_i$ es el valor real.
        * $\hat{y}_i$ es el valor predicho.
        * $\bar{y}$ es la media de los valores reales.
        * $\sum (y_i - \hat{y}_i)^2$ es la suma de los cuadrados de los residuos (SSR).
        * $\sum (y_i - \bar{y})^2$ es la suma total de los cuadrados (SST).
        [Fuente: Numeracy, Maths and Statistics - Academic Skills Kit - Coefficient of Determination, R-squared](https://www.ncl.ac.uk/webtemplate/ask-assets/external/maths-resources/statistics/regression-and-correlation/coefficient-of-determination-r-squared.html)

*(Nota: Los valores del conjunto de entrenamiento ayudan a identificar el sobreajuste si son significativamente mejores que los del conjunto de prueba).*

### Curvas de Aprendizaje (Learning Curves):

Una curva de aprendizaje muestra el rendimiento del modelo (por ejemplo, el error) en los conjuntos de entrenamiento y validación (o prueba) a medida que aumenta el número de ejemplos de entrenamiento. Son una herramienta diagnóstica crucial para entender si el modelo sufre de alto sesgo (subajuste, el modelo es demasiado simple), alta varianza (sobreajuste, el modelo memoriza los datos de entrenamiento y no generaliza bien), o si se beneficiaría de más datos. [Fuente: SKY ENGINE AI - Using Learning Curves to Analyse Machine Learning Model Performance](https://www.skyengine.ai/blog/using-learning-curves-to-analyse-machine-learning-model-performance).

**Interpretación de la imagen:**
La siguiente curva de aprendizaje muestra el MAE (Mean Absolute Error) en la escala logarítmica del precio, tanto para el conjunto de entrenamiento (rojo) como para el de validación cruzada (verde).
* La curva de entrenamiento muestra un error que disminuye y se estabiliza a medida que se utilizan más datos.
* La curva de validación cruzada también muestra un error decreciente que tiende a converger con la curva de entrenamiento.
* Si ambas curvas convergen a un error bajo y están cerca, el modelo generaliza bien. Si la curva de validación sigue bajando y se acerca a la de entrenamiento a medida que aumenta el tamaño del conjunto de entrenamiento, como parece ser el caso aquí, indica que el aumento de los datos podría mejorar aún más las predicciones del modelo, reduciendo la varianza y potencialmente el sesgo si el error convergente aún es alto.

<img width="816" alt="Curva de Aprendizaje del Modelo XGBoost" src="https://github.com/user-attachments/assets/fdd6df33-161f-4938-8ee0-6c3881dc962f" />

### Resultados de la Optimización de Hiperparámetros (con RandomizedSearchCV):

La optimización de hiperparámetros es el proceso de encontrar la combinación de parámetros para un algoritmo de aprendizaje que maximiza el rendimiento del modelo. `RandomizedSearchCV` explora un número fijo de combinaciones de parámetros a partir de distribuciones especificadas.

**Mejores Hiperparámetros Encontrados:**
{'subsample': 0.8, 'reg_lambda': 0.5, 'reg_alpha': 0, 'n_estimators': 300, 'max_depth': 9, 'learning_rate': 0.05, 'colsample_bytree': 0.7}

### Curvas de Validación de Hiperparámetros y Validación Cruzada:

Las curvas de validación son una herramienta para evaluar la sensibilidad de un modelo a un hiperparámetro específico. Se entrena el modelo con diferentes valores del hiperparámetro y se grafica el error de entrenamiento y el error de validación (obtenido mediante validación cruzada) para cada valor. Esto ayuda a identificar si el modelo está subajustando o sobreajustando para ciertos rangos del hiperparámetro. [Fuente: Kili Technology - Types of Cross Validation Techniques](https://kili-technology.com/data-labeling/machine-learning/cross-validation-in-machine-learning).

**Interpretación de la imagen:**
La imagen muestra la curva de validación para el hiperparámetro `max_depth` del modelo XGBoost, utilizando el MAE en la escala logarítmica del precio.
* La línea roja representa el error (MAE) en el conjunto de entrenamiento, y la línea verde el error en la validación cruzada.
* Se observa cómo varía el rendimiento al cambiar `max_depth`. Idealmente, se busca un valor que minimice el error de validación sin que haya una brecha demasiado grande con el error de entrenamiento (lo que indicaría sobreajuste). En este caso, parece que profundidades mayores (alrededor de 9-10) ofrecen un buen rendimiento en validación antes de que el error empiece a aumentar o la brecha con el error de entrenamiento se amplíe significativamente.

<img width="826" alt="Curva de Validación para max_depth en XGBoost" src="https://github.com/user-attachments/assets/b9cc2dab-7079-40b7-94c2-bf8f10b9dfac" />

### Graficación Detallada de Importancia de Características:

La importancia de características indica cuánto contribuye cada característica a las predicciones del modelo. Es fundamental para entender qué factores son más influyentes, para simplificar modelos (eliminando características no importantes) y para explicar el comportamiento del modelo. [Fuente: Built In - Understanding Feature Importance](https://builtin.com/data-science/feature-importance).

**Interpretación de las imágenes (SHAP Values):**
Las siguientes imágenes utilizan valores SHAP (SHapley Additive exPlanations) para explicar la importancia de las características. SHAP es un enfoque basado en la teoría de juegos que asigna a cada característica la contribución de esa característica a la predicción de una instancia específica. [Fuente: Christoph Molnar - Interpretable Machine Learning - SHAP](https://christophm.github.io/interpretable-ml-book/shap.html).

1.  **SHAP Summary Plot (Beeswarm Plot):**
    Esta gráfica muestra el impacto de cada característica en la predicción del logaritmo del precio.
    * Cada punto representa una instancia (una vivienda en este caso) y una característica.
    * El eje X indica el valor SHAP: valores positivos aumentan la predicción del precio, valores negativos la disminuyen.
    * El color de cada punto representa el valor de la característica para esa instancia (rojo para valores altos, azul para bajos).
    * Las características se ordenan por su importancia global (impacto medio absoluto). `cluster_avg_logprice` y `size` parecen ser las más influyentes. Para `size`, valores altos (puntos rojos) tienden a tener valores SHAP positivos altos, aumentando la predicción del precio, lo cual es intuitivo.

    ![SHAP Summary Plot (Beeswarm)](https://github.com/user-attachments/assets/54b36c78-ccac-4a77-8c80-12662e08794a)

2.  **SHAP Feature Importance (Bar Plot):**
    Esta gráfica muestra la importancia media absoluta de los valores SHAP para cada característica. Es una medida de la magnitud del impacto de cada característica en las predicciones, promediada sobre todas las instancias. Confirma que `cluster_avg_logprice` y `size` son las características con mayor impacto promedio.

    <img width="762" alt="SHAP Feature Importance (Bar Plot)" src="https://github.com/user-attachments/assets/3ef4c73c-e83c-4cce-91e4-d06313fa001a" />


---
**Fin de la Memoria**
