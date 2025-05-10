# Layola27/BarcelonaHousingForecast | DeepWiki

**Este documento proporciona una introducción completa al proyecto Barcelona Housing Forecast, un sistema diseñado para analizar y predecir los precios de la vivienda en Barcelona, España. El proyecto combina adquisición de datos, preprocesamiento, aprendizaje automático y una interfaz web para servir a diversos interesados en el mercado inmobiliario.**

## Visión General (Overview)

Este documento proporciona una introducción completa al proyecto Barcelona Housing Forecast, un sistema diseñado para analizar y predecir los precios de la vivienda en Barcelona, España. El proyecto combina la adquisición de datos, el preprocesamiento, el aprendizaje automático y una interfaz web para servir a diversos actores del mercado inmobiliario.

### Propósito y Alcance

El proyecto Barcelona Housing Forecast es una plataforma completa que:

* Recopila y procesa datos inmobiliarios de la API de Idealista.
* Entrena y mantiene un modelo de aprendizaje automático XGBoost para la predicción de precios.
* Proporciona una interfaz web interactiva para que los usuarios puedan:
    * Estimar precios de propiedades basándose en diversas características.
    * Consultar el conjunto de datos utilizando lenguaje natural.
    * Generar informes resumidos sobre el mercado inmobiliario.

Para obtener información detallada sobre componentes específicos, consulte:

* **Data Pipeline**: para detalles sobre la adquisición y procesamiento de datos.
* **Web Platform Architecture**: para la interfaz de usuario y los servicios backend.
* **Machine Learning Model**: para detalles sobre el algoritmo de predicción.
* **Deployment**: para estrategias de contenerización e implementación.

### Arquitectura del Sistema

El sistema Barcelona Housing Forecast consta de varios componentes interconectados que forman un flujo de trabajo de extremo a extremo, desde la adquisición de datos hasta las aplicaciones orientadas al usuario.

**(Nota: El HTML proporcionado incluye diagramas de Mermaid que describen la arquitectura de alto nivel, el pipeline de datos, la arquitectura de la plataforma web y el modelo de aprendizaje automático. Estos diagramas no se pueden replicar directamente en este formato de texto, pero la información clave se ha extraído).**

### Componentes Clave

* **Data Pipeline**: Maneja la adquisición, unificación, preprocesamiento y modelado de los datos de vivienda a través de una secuencia de notebooks de Jupyter.
* **Web Platform Architecture**: Proporciona la interfaz de usuario (React) y los servicios backend (FastAPI) para interactuar con el sistema, incluyendo estimación de precios, consulta con IA y generación de informes.
* **Machine Learning Model**: Utiliza un modelo XGBoost para predecir los precios de la vivienda, con un detallado proceso de ingeniería de características y entrenamiento.

### Pila Tecnológica (Technology Stack)

| Componente                    | Tecnologías                                           | Descripción                                                                 |
| :---------------------------- | :---------------------------------------------------- | :-------------------------------------------------------------------------- |
| **Ingeniería de Datos** | Python, Pandas, NumPy, Requests                       | Procesamiento de datos desde la adquisición hasta el modelado final.        |
| **Aprendizaje Automático** | Scikit-learn, XGBoost, CategoryEncoders, Geopy        | Ingeniería de características, entrenamiento y evaluación del modelo.       |
| **Backend Web** | FastAPI, Uvicorn, PostgreSQL, PostGIS                 | Endpoints de API REST, almacenamiento en base de datos con capacidades geoespaciales. |
| **Procesamiento de Leng. Nat.** | LangChain, Ollama, SQL Agent                          | Procesamiento de consultas en lenguaje natural a interacciones con la BBDD. |
| **Frontend Web** | React, Vite, Material UI, React Leaflet             | Interfaz de usuario con capacidades de mapeo interactivo.                   |
| **Automatización** | n8n, APIs LLM Externas (Gemini/OpenAI)                | Automatización de flujos de trabajo para generación de informes y envío de emails. |
| **Despliegue** | Docker, Docker Compose                                | Contenerización y orquestación de todos los servicios.                      |

### Flujo de Trabajo del Sistema

El sistema sigue un flujo general:

1.  Adquisición de datos (`1.IdealistaAPI.ipynb`).
2.  Procesamiento de datos (`2.AgregarNuevasViviendas.ipynb`, `3.PreProcesamiento.ipynb`).
3.  Entrenamiento del modelo (`4.ModeloExport.ipynb`).
4.  Despliegue del modelo (`pipeline_idealista_completo.joblib`).
5.  Servicios Backend (FastAPI + PostgreSQL + Ollama + n8n).
6.  Interfaz Web (Aplicación React) que interactúa con los servicios backend para:
    * Estimación de precios (API `/predict/`).
    * Consulta en lenguaje natural (API `/query_database/`).
    * Solicitud de informes (API `/generate_simple_report/`).

### Características Clave

1.  **Estimación de Precios**: Predice los precios de la vivienda en Barcelona basándose en las características de la propiedad y la ubicación utilizando un modelo XGBoost.
2.  **Consulta con IA**: Permite a los usuarios consultar el conjunto de datos de viviendas utilizando lenguaje natural a través de una interfaz de chat.
3.  **Generación de Informes**: Permite a los usuarios solicitar informes automatizados sobre el mercado inmobiliario, generados mediante LLMs externos y entregados por correo electrónico.

### Arquitectura de Despliegue

El sistema se despliega utilizando contenedores Docker orquestados con Docker Compose, incluyendo servicios para FastAPI, PostgreSQL/PostGIS, Ollama y n8n.

---

*Este resumen se ha generado a partir del contenido HTML proporcionado de la página de DeepWiki para el repositorio Layola27/BarcelonaHousingForecast.*
