# 🏘️ Plataforma Web de Análisis y Predicción de Precios de Viviendas en Barcelona con IA y Big Data

## 📌 Descripción del Proyecto

Este proyecto ha evolucionado hacia una plataforma web interactiva y completa, centrada en el análisis y la predicción de precios de viviendas en Barcelona y sus alrededores. El objetivo principal es proporcionar a usuarios, compradores, vendedores, agencias inmobiliarias y entidades financieras herramientas inteligentes para la **toma de decisiones informadas**.

La plataforma integra **tres funcionalidades clave**:

1.  **Estimación de Precios:** Permite predecir el precio de una vivienda específica introduciendo sus características y ubicación mediante un modelo de inteligencia artificial avanzado.
2.  **Consulta Interactiva con IA:** Facilita la exploración del dataset completo de viviendas utilizando lenguaje natural a través de una interfaz de chat impulsada por un modelo de lenguaje grande (LLM).
3.  **Generación de Informes Resumidos:** Ofrece la posibilidad de solicitar informes resumidos sobre los datos, generados por IA y enviados por correo electrónico.

La solución combina técnicas de **procesamiento y análisis de datos**, **machine learning supervisado**, **procesamiento del lenguaje natural**, **visualización interactiva** y herramientas de automatización para construir un flujo de trabajo integral, desde la gestión de datos hasta la entrega de información valiosa a los usuarios.

## 🎯 Objetivos

- Analizar las características más influyentes en los precios de viviendas en Barcelona.
- Implementar y mantener un modelo predictivo de precios de alta precisión utilizando algoritmos de IA.
- Facilitar la exploración interactiva del conjunto de datos mediante consultas en lenguaje natural.
- Automatizar la generación y el envío de informes resumidos basados en los datos.
- Visualizar espacialmente los datos y las predicciones a través de un mapa interactivo.
- Proporcionar una interfaz web intuitiva y fácil de usar para todas las funcionalidades.
- Gestionar el desarrollo del proyecto de forma colaborativa y ágil.

---

## 🚀 Características del Proyecto

- **Ingeniería de Datos Avanzada:** Limpieza, preprocesamiento y transformación exhaustiva de datos de viviendas.
- **Modelado Predictivo Robusto:** Implementación y reentrenamiento de un modelo XGBoost para la predicción de precios.
- **Consulta en Lenguaje Natural:** Interfaz de chat con IA para explorar el dataset mediante preguntas directas.
- **Generación Automática de Informes:** Creación y envío de resúmenes informativos por correo electrónico utilizando IA.
- **Visualización Espacial Interactiva:** Mapa con la capacidad de seleccionar ubicaciones y visualizar el área de influencia del modelo.
- **Interfaz Web Full-Stack:** Aplicación web completa desarrollada con React en el frontend y FastAPI en el backend.
- **Despliegue Contenerizado:** Uso de Docker y Docker Compose para la gestión y el despliegue de todos los servicios.
- **Persistencia de Datos:** Almacenamiento eficiente y escalable de los datos en una base de datos PostgreSQL.

---

## 🛠️ Tecnologías y Herramientas Utilizadas

| Herramienta / Lenguaje | Descripción |
|------------------------|-------------|
| **Python** | Procesamiento de datos, modelado de machine learning, desarrollo del backend con FastAPI y scripts de automatización. |
| **R** | Análisis estadístico y validación de modelos (utilizado en etapas iniciales). |
| **Orange Data Mining** | Prototipado visual de flujos de datos y modelos (utilizado en etapas iniciales). |
| **FastAPI** | Desarrollo de la API REST del backend. |
| **Uvicorn** | Servidor ASGI para ejecutar la aplicación FastAPI. |
| **PostgreSQL** | Almacenamiento y gestión eficiente de datos estructurados del dataset de viviendas. |
| **Ollama** | Ejecución local de modelos de lenguaje grande (LLMs) para la consulta en lenguaje natural. |
| **LangChain** | Framework para la orquestación de LLMs y la interacción con la base de datos. |
| **n8n** | Plataforma de automatización para la generación y el envío de informes por correo electrónico. |
| **Google Gemini / OpenAI** | Modelos de lenguaje externos utilizados por n8n para la generación de informes (alternativamente). |
| **React** | Desarrollo de la interfaz de usuario interactiva del frontend. |
| **Vite** | Bundler para la aplicación React. |
| **Material UI (MUI)** | Librería de componentes de interfaz de usuario para React. |
| **React Leaflet** | Librería de componentes de mapa interactivo para React. |
| **Docker** | Plataforma de contenerización para empaquetar y ejecutar los diferentes servicios. |
| **Docker Compose** | Herramienta para la definición y gestión de aplicaciones multi-contenedor Docker. |
| **GitHub** | Control de versiones y colaboración en equipo. |
| **Jira** | Gestión ágil de tareas, sprints y documentación (utilizado para la gestión del proyecto). |

---

## 🧠 Metodología General

1.  **Obtención de Datos**: Extracción de información inicial de un archivo CSV (`pisosBarcelona-21-04-2025-clean.csv`).
2.  **Almacenamiento de Datos**: Carga del dataset completo en una base de datos PostgreSQL.
3.  **Limpieza y Transformación Avanzada**: Preprocesamiento exhaustivo de los datos, incluyendo manejo de valores faltantes, codificación de variables categóricas, ingeniería de características (espaciales, no lineales, interacciones) y escalado.
4.  **Modelado Predictivo**: Entrenamiento, evaluación y selección de un modelo de regresión (XGBoost) para la predicción de precios. Persistencia del pipeline completo (preprocesamiento + modelo).
5.  **Desarrollo del Backend**: Creación de una API REST con FastAPI para exponer las funcionalidades de predicción, consulta de datos y generación de informes.
6.  **Implementación de Consulta con IA**: Integración de Ollama y LangChain para permitir la interacción con la base de datos mediante lenguaje natural.
7.  **Automatización de Informes**: Configuración de un workflow en n8n para generar resúmenes de datos con LLMs externos y enviarlos por correo electrónico.
8.  **Desarrollo del Frontend**: Creación de una interfaz de usuario interactiva con React, incluyendo un formulario de predicción, una interfaz de chat con IA y una sección para solicitar informes. Integración de un mapa interactivo con React Leaflet.
9.  **Despliegue**: Contenerización de todos los servicios backend con Docker y orquestación con Docker Compose.

---

## 🤖 FLUJO DEL PROYECTO

![Diagrama del flujo del proyecto](https://github.com/user-attachments/assets/2de13236-7fee-48e4-88db-0700255b4de4)

## 🗂️ Descripción del Dataset

El proyecto se basa en un conjunto de datos detallado sobre anuncios de viviendas ubicadas en la ciudad de **Barcelona**. Cada registro contiene información estructural y contextual crucial para el análisis y la predicción de precios.

### 🔍 Principales Categorías de Información

- **Características físicas del inmueble**: Superficie, número de habitaciones y baños, planta, tipo de propiedad.
- **Ubicación geográfica**: Distrito, barrio, coordenadas (latitud, longitud), dirección.
- **Datos económicos**: Precio total, precio por metro cuadrado, información sobre la oferta y variaciones de precio.
- **Estado del anuncio**: Tipo de operación, si es obra nueva, si es destacado.
- **Atributos adicionales**: Ascensor, parking, disponibilidad de planos, tour virtual.
- **Multimedia**: Número de fotos, miniatura, descripción, disponibilidad de video.
- **Identificadores y metadatos**: Código de propiedad, referencia externa, URL del anuncio.

El dataset inicial (`pisosBarcelona-21-04-2025-clean.csv`) fue sometido a un proceso de limpieza y estandarización antes de ser cargado en la base de datos PostgreSQL.

> ⚠️ Nota: Durante el preprocesamiento avanzado, se gestionaron los valores nulos y se aplicaron transformaciones para preparar los datos para el modelado.

## 🧠 Modelado Predictivo

En esta etapa crucial del proyecto, se construyó un modelo de aprendizaje automático para predecir el precio de las viviendas en Barcelona. Se seleccionó el algoritmo XGBoost Regressor debido a su alto rendimiento y capacidad para manejar relaciones complejas en los datos.

### ⚙️ Ingeniería de Características (Feature Engineering)

Se aplicó un extenso proceso de ingeniería de características detallado en el notebook `ModeloExport.ipynb`. Este incluyó:

- Limpieza de datos y manejo de valores inconsistentes.
- Imputación de valores nulos y creación de indicadores de valores faltantes.
- Combinación de características existentes.
- Ingeniería de características espaciales (distancia a POIs, clustering y PCA sobre coordenadas).
- Codificación de variables categóricas (TargetEncoder).
- Creación de características no lineales (Splines) e interacciones polinómicas.
- Transformación logarítmica de la variable objetivo (`price`).
- Filtrado de outliers.
- Escalado de características numéricas (`StandardScaler`).

### 🧪 Entrenamiento y Persistencia

El modelo XGBoost se entrenó utilizando los datos preprocesados. El pipeline completo de preprocesamiento y el modelo entrenado se guardaron en un archivo (`pipeline_idealista_completo.joblib`) utilizando la librería `joblib` para su posterior uso en la API.

## 🗣️ Consulta con Lenguaje Natural (LLM + LangChain + Ollama)

Se implementó la capacidad de consultar la base de datos PostgreSQL utilizando lenguaje natural mediante la integración de:

- **Ollama:** Para ejecutar localmente modelos de lenguaje como `llama3:8b` y `mixtral:8x7b-instruct-v0.1-q4_K_M`.
- **LangChain:** Para orquestar la interacción con el LLM, conectar con la base de datos (a través de `SQLDatabase` y `SQLDatabaseToolkit`) y crear un agente SQL (`create_sql_agent` con `agent_type="openai-tools"`) capaz de traducir preguntas en lenguaje natural a consultas SQL y formular respuestas concisas en español.

## 📧 Automatización de Informes (n8n + Gemini/OpenAI)

Se configuró un workflow en n8n para automatizar la generación y el envío de informes resumidos por correo electrónico. El workflow se activa mediante un webhook desde el backend y realiza los siguientes pasos:

1.  Consulta datos relevantes de PostgreSQL.
2.  Formatea los datos para el LLM.
3.  Llama a la API de un LLM externo (Google Gemini o OpenAI) para generar un informe en Markdown.
4.  Envía el informe por correo electrónico utilizando el nodo "Send Email" de n8n.

## 💻 Frontend (React)

La interfaz de usuario se desarrolló con React y la librería de componentes Material UI (MUI) para proporcionar una experiencia interactiva y responsiva. Se incluyen las siguientes secciones principales:

- **Estimador de Precios:** Formulario para introducir características de la vivienda, integrado con un mapa interactivo (React Leaflet) que permite seleccionar la ubicación y visualizar el área de validez del modelo. Realiza peticiones al endpoint `/predict/` del backend.
- **Consulta con IA:** Interfaz de chat modal (abierta con un botón) que permite a los usuarios hacer preguntas sobre los datos en lenguaje natural, las cuales se envían al endpoint `/query_database/`.
- **Solicitud de Informe:** Sección con un campo para el correo electrónico y un botón para solicitar un informe, que activa el endpoint `/generate_simple_report/` del backend (o directamente el webhook de n8n).

## 🐳 Despliegue (Docker)

La aplicación backend y sus dependencias (PostgreSQL, Ollama, n8n) se empaquetaron y orquestaron utilizando Docker y Docker Compose. Esto facilita el despliegue y la gestión de los diferentes servicios, asegurando la portabilidad y la consistencia del entorno. Se definieron volúmenes para la persistencia de datos y modelos, y se configuró una red interna (`housing_net`) para la comunicación entre los contenedores. La configuración se gestiona mediante variables de entorno en `docker-compose.yml`.

---

Este documento proporciona una visión detallada de la arquitectura y las funcionalidades de la plataforma web de análisis y predicción de precios de viviendas en Barcelona. La combinación de inteligencia artificial, procesamiento del lenguaje natural y tecnologías web modernas ofrece una herramienta poderosa para la exploración y la toma de decisiones en el mercado inmobiliario.
