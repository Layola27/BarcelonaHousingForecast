# 🏘️ Memoria Técnica: Plataforma Web de Análisis y Predicción de Precios de Viviendas en Barcelona

## 1. Introducción

Este documento presenta la memoria técnica detallada de una plataforma web full-stack desarrollada para el análisis y la predicción de precios de viviendas en Barcelona y sus alrededores. La aplicación ofrece tres funcionalidades principales: la estimación del precio de una vivienda a partir de sus características, la consulta interactiva del conjunto de datos mediante lenguaje natural y la solicitud de un informe resumido generado por inteligencia artificial enviado por correo electrónico. El objetivo de esta memoria es documentar exhaustivamente la arquitectura, los componentes técnicos, las funcionalidades implementadas y las tecnologías utilizadas en el desarrollo de esta plataforma.

## 2. Arquitectura General

La arquitectura de la plataforma se basa en un diseño modular y distribuido, facilitado por la contenerización con Docker. Los principales componentes que interactúan para ofrecer la funcionalidad completa son:

* **Frontend (React):** Interfaz de usuario interactiva que permite a los usuarios interactuar con las diferentes funcionalidades de la plataforma.
* **Backend API (FastAPI):** API RESTful que actúa como intermediario entre el frontend y los demás servicios, gestionando las peticiones de predicción, consulta de datos y generación de informes.
* **Base de Datos (PostgreSQL):** Almacenamiento persistente del dataset de viviendas de Barcelona.
* **Servicio LLM (Ollama):** Ejecución local de modelos de lenguaje para la consulta en lenguaje natural de la base de datos.
* **Automatización de Informes (n8n):** Plataforma de automatización para la generación y envío de informes resumidos por correo electrónico.

La comunicación entre estos componentes se realiza principalmente a través de peticiones HTTP, facilitando la escalabilidad y el mantenimiento del sistema.

## 3. Base de Datos (PostgreSQL)

### 3.1. Descripción

Se utiliza una base de datos PostgreSQL para almacenar y gestionar el dataset de viviendas de Barcelona. Esta elección se basa en su robustez, fiabilidad y capacidad para manejar grandes volúmenes de datos estructurados.

### 3.2. Esquema de la Base de Datos

* **Motor:** PostgreSQL
* **Contenedor:** Docker
* **Nombre de la Base de Datos:** `housing_db`
* **Schema:** `public`
* **Tabla Principal:** `pisos_barcelona` (o `viviendas`)

### 3.3. Datos

El dataset inicial se cargó desde un archivo CSV (`pisosBarcelona-21-04-2025-clean.csv`) que contenía aproximadamente 8400 registros y 15MB de información. Cada registro representa una vivienda y contiene campos detallados sobre su precio, tamaño, número de habitaciones y baños, ubicación (latitud, longitud), características adicionales (ascensor, parking, etc.) y otros metadatos relevantes.

## 4. Modelo Predictivo de Precios

### 4.1. Descripción

Se implementó un modelo de Machine Learning para estimar el precio de las viviendas basándose en sus características. El objetivo es proporcionar una herramienta precisa para la valoración inmobiliaria.

### 4.2. Modelo Utilizado

* **Algoritmo:** XGBoost Regressor

### 4.3. Ingeniería de Características (Feature Engineering)

Se aplicó un extenso proceso de ingeniería de características para optimizar el rendimiento del modelo. Los pasos clave incluyeron:

* **Limpieza de Datos:** Manejo de valores inconsistentes (ej., pisos 'bj'/'en' como plantas bajas), tratamiento de valores 'Unknown'.
* **Imputación de Valores Nulos:** Reemplazo de valores faltantes utilizando la mediana de la columna correspondiente. Se crearon flags (`isna_`) para indicar la presencia original de valores nulos.
* **Combinación de Features:** Creación de nuevas características a partir de las existentes (ej., `parking_status`).
* **Ingeniería de Características Espaciales:**
    * Cálculo de la distancia a Puntos de Interés (POIs).
    * Aplicación de clustering KMeans sobre las coordenadas geográficas para identificar zonas.
    * Aplicación de Análisis de Componentes Principales (PCA) sobre las coordenadas para reducir la dimensionalidad y capturar la variabilidad espacial.
* **Codificación de Variables Categóricas:** Utilización de TargetEncoder para las columnas `propertyType`, `status` y `parking_status`.
* **Creación de Features No Lineales:**
    * Generación de Splines sobre las variables numéricas `size` y las distancias a POIs para capturar relaciones no lineales.
    * Creación de términos de interacción polinómica de grado 2 entre las características.
* **Transformación del Target:** Aplicación de la transformación logarítmica (`log1p`) a la variable objetivo (`price`) para normalizar su distribución.
* **Filtrado de Outliers:** Eliminación de valores atípicos basados en los percentiles 1 y 99 de la variable objetivo.
* **Escalado:** Aplicación de `StandardScaler` a las características numéricas para asegurar que tengan una escala similar antes de alimentar el modelo.

### 4.4. Persistencia del Modelo

Todo el pipeline de preprocesamiento y el modelo XGBoost entrenado se serializaron y guardaron en un único archivo utilizando la librería `joblib`:

* **Archivo:** `pipeline_idealista_completo.joblib`

Este archivo permite cargar el modelo y el pipeline completo de transformación de datos de manera eficiente para realizar predicciones en tiempo real.

## 5. Backend API (FastAPI)

### 5.1. Descripción

Se desarrolló una API RESTful utilizando el framework FastAPI (basado en Python) para exponer las funcionalidades del modelo predictivo, la consulta de la base de datos y la generación de informes. Uvicorn se utiliza como servidor ASGI para ejecutar la aplicación FastAPI.

### 5.2. Endpoints

* **`/predict/` (POST):**
    * **Propósito:** Recibe las características de una vivienda en formato JSON según el modelo Pydantic `HouseFeaturesPredict`.
    * **Proceso:** Carga el pipeline serializado desde `pipeline_idealista_completo.joblib`, aplica las transformaciones necesarias a los datos de entrada y utiliza el modelo XGBoost para predecir el precio. La predicción se devuelve deshaciendo la transformación logarítmica aplicada durante el entrenamiento.
    * **Respuesta:** Un JSON con la predicción del precio.
* **`/query_database/` (POST):**
    * **Propósito:** Recibe una pregunta en lenguaje natural del usuario en formato JSON según el modelo Pydantic `QueryRequest`.
    * **Proceso:** Utiliza el agente LangChain SQL configurado (ver sección 6) para procesar la pregunta, generar una consulta SQL, ejecutarla en la base de datos PostgreSQL y obtener una respuesta textual del modelo LLM.
    * **Respuesta:** Un JSON con la respuesta del modelo de lenguaje.
* **`/generate_simple_report/` (POST):**
    * **Propósito:** Actúa como un intermediario para iniciar el workflow de generación de informes en n8n.
    * **Proceso:** Realiza una petición HTTP (webhook) al endpoint configurado en el servicio n8n. Puede recibir opcionalmente un correo electrónico como parámetro.
    * **Respuesta:** Un JSON indicando el estado de la solicitud.

### 5.3. Configuración Adicional

* **CORS (Cross-Origin Resource Sharing):** Se configuró el middleware de CORS para permitir las peticiones provenientes del frontend React, que se ejecuta en un dominio diferente.

## 6. Consulta con Lenguaje Natural (LLM + LangChain + Ollama)

### 6.1. Descripción

Se implementó una funcionalidad para permitir a los usuarios consultar la base de datos de viviendas utilizando lenguaje natural. Esto se logra mediante la integración de un modelo de lenguaje grande (LLM) ejecutado localmente con Ollama y la librería LangChain para la orquestación.

### 6.2. Tecnologías Utilizadas

* **Ollama:** Un servicio en Docker que permite ejecutar modelos LLM de forma local. Se probaron los modelos `llama3:8b` y `mixtral:8x7b-instruct-v0.1-q4_K_M`.
* **LangChain:** Una librería para construir aplicaciones basadas en LLMs. Se utilizaron los siguientes módulos:
    * `ChatOllama`: Para la comunicación con el modelo LLM ejecutado por Ollama.
    * `SQLDatabase`: Para establecer la conexión con la base de datos PostgreSQL y obtener el esquema de la tabla `pisos_barcelona`.
    * `SQLDatabaseToolkit`: Un conjunto de herramientas para interactuar con la base de datos SQL.
    * `create_sql_agent`: Una función para crear un agente que puede traducir preguntas en lenguaje natural a consultas SQL, ejecutarlas y formular una respuesta. Se configuró con `agent_type="openai-tools"`.

### 6.3. Flujo de la Consulta

1.  El usuario introduce una pregunta en lenguaje natural a través de la interfaz de chat en el frontend.
2.  El frontend envía esta pregunta al endpoint `/query_database/` del backend.
3.  El backend recibe la pregunta y la pasa al agente LangChain SQL.
4.  El agente utiliza el modelo LLM (a través de `ChatOllama`) y el esquema de la base de datos (a través de `SQLDatabaseToolkit`) para generar una consulta SQL relevante para la pregunta del usuario.
5.  La consulta SQL se ejecuta en la base de datos PostgreSQL (a través de la conexión definida en `SQLDatabase`).
6.  Los resultados de la consulta se devuelven al modelo LLM.
7.  El modelo LLM formula una respuesta en lenguaje natural basada en los resultados de la consulta. Se personalizó el `suffix` del prompt del agente para asegurar respuestas concisas y en español.
8.  La respuesta del LLM se envía de vuelta al frontend y se muestra al usuario en la interfaz de chat.

## 7. Automatización de Informes (n8n)

### 7.1. Descripción

Se implementó un workflow de automatización utilizando la plataforma n8n para generar informes resumidos sobre los datos de viviendas y enviarlos por correo electrónico a los usuarios que lo soliciten.

### 7.2. Configuración de n8n

* **Contenedor:** Docker
* **Trigger:** Nodo Webhook configurado para ser llamado por el endpoint `/generate_simple_report/` del backend (o directamente desde el frontend).

### 7.3. Pasos del Workflow

1.  **Webhook:** Recibe la petición del backend (o frontend), que puede incluir una dirección de correo electrónico.
2.  **Consulta a PostgreSQL:** Utiliza el nodo PostgreSQL de n8n para ejecutar consultas SQL predefinidas o dinámicas en la base de datos `pisos_barcelona`. Estas consultas se diseñan para obtener datos agregados o relevantes para el informe (ej., precio medio por distrito, distribución de tipos de vivienda, etc.).
3.  **Formateo de Datos (Function Node):** Un nodo Function de JavaScript se utiliza para procesar y formatear los datos obtenidos de la base de datos en una estructura adecuada para ser utilizada por el LLM.
4.  **Generación del Informe con LLM (HTTP Request / OpenAI Node):** Se realiza una llamada a una API LLM externa (Google Gemini o OpenAI) utilizando un nodo HTTP Request o el nodo específico de la plataforma LLM. Se pasa un prompt detallado junto con los datos formateados para instruir al LLM a generar un informe conciso en formato Markdown y en español, adecuado para ser incluido en un correo electrónico.
5.  **Envío de Correo Electrónico (Send Email Node):** Utiliza el nodo "Send Email" de n8n, configurado con una cuenta de Gmail (vía OAuth2) o mediante SMTP con una contraseña de aplicación, para enviar el informe generado a la dirección de correo electrónico proporcionada en la petición inicial (o a una dirección por defecto si no se proporciona).

## 8. Frontend (React)

### 8.1. Descripción

La interfaz de usuario de la plataforma se desarrolló como una Single Page Application (SPA) utilizando la librería React y el bundler Vite. Se priorizó la interactividad y una experiencia de usuario intuitiva.

### 8.2. Librerías UI

* **Material UI (MUI):** Se utilizó extensivamente para proporcionar componentes de interfaz de usuario estilizados y responsivos (Container, Paper, Grid, TextField, Button, Select, Checkbox, Accordion, Dialog, Alert, etc.).

### 8.3. Mapa Interactivo (React Leaflet)

* Se integró un mapa interactivo utilizando la librería React Leaflet, centrado en la ciudad de Barcelona.
* Se visualiza un círculo con un radio de 15 km alrededor del centro de Barcelona para indicar el área de validez del modelo predictivo.
* Los usuarios pueden hacer clic dentro de este círculo para colocar un marcador, lo que actualiza automáticamente los campos de latitud y longitud en el formulario del estimador de precios.
* Se implementó una restricción para evitar la selección de puntos fuera del círculo, mostrando una advertencia visual cuando se intenta.

### 8.4. Secciones de la Aplicación

* **Estimador de Precios:**
    * Un formulario organizado mediante componentes `Accordion` de MUI permite a los usuarios introducir las características de una vivienda (tamaño, habitaciones, baños, ubicación en el mapa, características adicionales como ascensor y parking, etc.).
    * Los campos de latitud y longitud se actualizan automáticamente al interactuar con el mapa.
    * Al enviar el formulario, se realiza una petición al endpoint `/predict/` del backend.
    * La interfaz muestra el precio estimado o mensajes de error en caso de problemas con la predicción.
* **Consulta con IA:**
    * Un botón con un icono de bot (`SmartToyIcon`) abre un componente `Dialog` modal.
    * Dentro del diálogo, se presenta una interfaz de chat donde los usuarios pueden escribir sus preguntas en lenguaje natural.
    * Las preguntas se envían al endpoint `/query_database/` del backend.
    * Las respuestas del agente LLM se muestran en la conversación dentro del diálogo.
* **Solicitud de Informe:**
    * Una sección dedicada permite a los usuarios introducir su dirección de correo electrónico.
    * Un botón de "Solicitar Informe" envía una petición al endpoint `/generate_simple_report/` del backend (o directamente al webhook de n8n).
    * Se muestra un mensaje de estado para informar al usuario sobre el éxito o el fallo de la solicitud.

## 9. Despliegue (Docker)

### 9.1. Descripción

Toda la infraestructura de backend (base de datos PostgreSQL, servicio Ollama, backend FastAPI y plataforma n8n) se contenerizó utilizando Docker para facilitar el despliegue, la gestión y la escalabilidad de la aplicación.

### 9.2. Docker Compose

Se utiliza Docker Compose (`docker-compose.yml`) para definir y orquestar los diferentes servicios:

* **`postgres_db`:** Contenedor para la base de datos PostgreSQL. Se configura un volumen (`postgres_data`) para la persistencia de los datos.
* **`ollama`:** Contenedor para el servicio Ollama, encargado de ejecutar los modelos LLM localmente. Se define un volumen (`ollama_data`) para la persistencia de los modelos descargados.
* **`backend`:** Contenedor para la aplicación FastAPI (backend). Se mapea el puerto necesario para la API y se configura para depender de los servicios `postgres_db` y `ollama`.
* **`n8n`:** Contenedor para la plataforma de automatización n8n. Se mapea el puerto de la interfaz de n8n y se define un volumen (`n8n_data`) para la persistencia de los workflows y la configuración.

### 9.3. Red Interna

Se define una red interna de Docker (`housing_net`) para permitir la comunicación entre los contenedores utilizando sus nombres de servicio como nombres de host (ej., `postgres_db`, `ollama`, `backend`, `n8n`).

### 9.4. Variables de Entorno

La configuración sensible y específica del entorno (URLs de la base de datos, URLs de Ollama, nombres de los modelos LLM a utilizar, claves de API para servicios externos si se usaran) se gestiona mediante variables de entorno definidas en el archivo `docker-compose.yml`. Esto permite una configuración flexible y evita la codificación de información sensible directamente en el código.

## 10. Conclusiones

La plataforma web desarrollada proporciona un conjunto robusto de herramientas para el análisis y la predicción de precios de viviendas en Barcelona. La integración de un modelo predictivo avanzado, la capacidad de realizar consultas en lenguaje natural sobre el dataset y la automatización de la generación de informes ofrecen un valor significativo para usuarios interesados en el mercado inmobiliario. La arquitectura modular y la contenerización con Docker facilitan el despliegue, el mantenimiento y la futura expansión de la plataforma. El uso de tecnologías modernas y eficientes en el frontend y el backend garantiza una experiencia de usuario fluida y un rendimiento adecuado.
