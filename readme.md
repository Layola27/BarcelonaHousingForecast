# 🏘️ Proyecto de Predicción de Precios de Viviendas en Barcelona

## 📌 Descripción del Proyecto

Este proyecto se centra en la construcción de un modelo de machine learning para predecir los precios de las viviendas en Barcelona. Se implementa un flujo de trabajo completo que abarca la obtención de datos desde la API de Idealista, la unificación de datasets, el preprocesamiento exhaustivo y el entrenamiento de un modelo XGBoost. El artefacto principal generado es un pipeline serializado que encapsula todas las transformaciones de datos y el modelo, listo para ser utilizado en una aplicación para realizar predicciones.

## 🎯 Objetivos

* Obtener datos actualizados de viviendas en Barcelona desde la API de Idealista.
* Unificar los datos nuevos con los existentes, eliminando duplicados.
* Limpiar y preprocesar los datos para prepararlos para el modelado.
* Realizar una ingeniería de características avanzada para extraer información relevante y crear nuevas variables.
* Entrenar un modelo de machine learning preciso para predecir los precios de las viviendas.
* Guardar el pipeline completo para facilitar su uso en producción.

---

## 🚀 Características del Proyecto

* **Obtención de Datos de la API:** Extracción automatizada de datos de viviendas desde la API de Idealista.
* **Unificación de Datasets:** Combinación de nuevos datos con los existentes y eliminación de duplicados.
* **Preprocesamiento Integral:** Limpieza, formateo, imputación de nulos y transformación de datos.
* **Ingeniería de Características Avanzada:** Creación de características espaciales, no lineales y de interacción.
* **Modelado Predictivo:** Entrenamiento y optimización de un modelo XGBoost Regressor.
* **Pipeline Serializado:** Guardado de todo el flujo de preprocesamiento y el modelo en un único archivo.

---

## 🛠️ Tecnologías y Herramientas Utilizadas

| Herramienta / Lenguaje | Descripción |
|------------------------|-------------|
| **Python** | Lenguaje principal para la manipulación de datos, llamadas a la API y modelado. |
| **Pandas** | Librería para la manipulación y análisis de datos tabulares. |
| **NumPy** | Librería para la computación numérica. |
| **Requests** | Librería para realizar peticiones HTTP a la API de Idealista. |
| **Base64** | Librería para la codificación de credenciales de la API. |
| **Geopy** | Librería para calcular distancias geodésicas. |
| **Scikit-learn** | Librería para el preprocesamiento de datos, clustering, PCA y modelado. |
| **XGBoost** | Librería para el modelo de Gradient Boosting. |
| **Category Encoders** | Librería para la codificación de variables categóricas. |
| **Joblib** | Librería para serializar y guardar el pipeline completo. |
| **Google Colab** | Entorno de desarrollo en la nube utilizado para ejecutar el código. |

---

## 🧠 Metodología General

1.  **Obtención de Datos:** El notebook `1.IdealistaAPI.ipynb` se encarga de obtener datos de viviendas desde la API de Idealista. Se autentica, define los parámetros de búsqueda y guarda los resultados en archivos CSV.
2.  **Unificación de Datasets:** El notebook `2.AgregarNuevasViviendas.ipynb` combina los nuevos datos obtenidos de la API con los datos existentes, eliminando los registros duplicados.
3.  **Preprocesamiento Inicial:** El notebook `3.PreProcesamiento.ipynb` realiza una limpieza y transformación inicial de los datos, eliminando columnas innecesarias y extrayendo información de columnas JSON.
4.  **Preprocesamiento Avanzado y Modelado:** El notebook `4.ModeloExport.ipynb` realiza el preprocesamiento avanzado, la ingeniería de características y el entrenamiento del modelo XGBoost. El pipeline completo se guarda en un archivo `.joblib`.

---

## 📁 Descripción de los Notebooks

* **`1.IdealistaAPI.ipynb`:**
    * Obtiene datos de la API de Idealista.
    * Realiza la autenticación y las peticiones a la API.
    * Guarda los datos en archivos CSV.
* **`2.AgregarNuevasViviendas.ipynb`:**
    * Unifica los nuevos datos con los existentes.
    * Elimina los duplicados.
    * Guarda el dataset unificado.
* **`3.PreProcesamiento.ipynb`:**
    * Realiza el preprocesamiento inicial de los datos.
    * Elimina columnas innecesarias.
    * Extrae información de columnas JSON.
* **`4.ModeloExport.ipynb`:**
    * Realiza el preprocesamiento avanzado.
    * Implementa la ingeniería de características.
    * Entrena el modelo XGBoost.
    * Guarda el pipeline completo.

---

Este README proporciona una visión general del proyecto, su propósito, la metodología seguida y las herramientas utilizadas. Los notebooks detallan cada etapa del proceso, desde la obtención de los datos hasta la generación del modelo predictivo.
