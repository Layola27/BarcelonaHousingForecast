# BarcelonaHousingForecast

## Descripción del Proyecto

Este proyecto tiene como objetivo principal la construcción de un modelo de machine learning capaz de predecir los precios de las viviendas en la ciudad de Barcelona. Para lograrlo, se abarcan diversas etapas clave, desde la **obtención de datos** actualizados hasta el **preprocesamiento** exhaustivo de los mismos, el entrenamiento de un modelo **XGBoost** y la creación de un **pipeline serializado** listo para su puesta en producción.

## Objetivos

Los objetivos específicos del proyecto son:

* Obtención de datos actualizados de la API de Idealista.
* Unificación y limpieza de datasets, incluyendo la eliminación de duplicados.
* Limpieza y preprocesamiento detallado de los datos.
* Ingeniería de características avanzada para mejorar el rendimiento del modelo.
* Entrenamiento de un modelo preciso de machine learning para la predicción de precios.
* Guardado del pipeline completo (preprocesamiento y modelo) para facilitar su uso en entornos de producción.

## Características del Proyecto

Las principales características implementadas en este proyecto incluyen:

* **Obtención automatizada de datos**: Conexión con la API de Idealista para la extracción de información reciente sobre viviendas.
* **Unificación de datasets**: Consolidación de datos históricos y nuevos, con un proceso robusto para la eliminación de duplicados.
* **Preprocesamiento integral**: Abarca limpieza de datos, formateo, imputación de valores faltantes y transformaciones necesarias.
* **Ingeniería de características avanzada**: Creación de nuevas variables predictivas, incluyendo características espaciales (distancias a puntos de interés), no lineales y de interacción entre variables existentes.
* **Modelado predictivo**: Implementación de un modelo XGBoost Regressor, conocido por su alto rendimiento en problemas de regresión.
* **Pipeline serializado**: El flujo completo de preprocesamiento y el modelo entrenado se guardan en un archivo `.joblib` para su fácil reutilización y despliegue.

## Tecnologías y Herramientas Utilizadas 🚀

Este proyecto aprovecha un conjunto de potentes bibliotecas y herramientas de Python para cubrir todo el ciclo de vida del desarrollo de un modelo de Machine Learning, desde la adquisición de datos hasta la serialización del modelo para producción. A continuación, se detalla cada componente, su propósito y cómo contribuye a los aspectos más avanzados del proyecto:

| Tecnología / Herramienta | Logo (Sugerencia)        | Propósito Principal                                   | Contribución Específica / Técnicas Avanzadas Aplicadas                                                                                                                                                                                                                                                                                         |
| :----------------------- | :-----------------------: | :--------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Python** |       ![Python]()         | Lenguaje de programación principal                     | Orquestación de todo el flujo de trabajo, scripting para automatización, y la base sobre la cual todas las demás librerías operan. Su sintaxis clara y el vasto ecosistema de librerías lo hacen ideal para Data Science.                                                                                                       |
| **Pandas** |       ![Pandas]()         | Manipulación y análisis de datos tabulares             | **Ingesta de datos** (desde CSVs, resultados de API), **limpieza exhaustiva** (manejo de nulos con estrategias específicas, corrección de tipos de datos, detección de outliers), **transformación de datos** (pivoting, merging, reshaping), y **análisis exploratorio de datos (EDA)** fundamental para entender las relaciones. |
| **NumPy** |        ![NumPy]()         | Computación numérica eficiente                       | Base para Pandas y Scikit-learn. Utilizado para operaciones vectorizadas de alta velocidad, manipulación de arrays multidimensionales, y funciones matemáticas esenciales para el preprocesamiento y la ingeniería de características.                                                                                   |
| **Requests** |      ![Requests]()       | Peticiones HTTP a la API                             | Interacción con la API de Idealista para la **extracción automatizada y programática de datos**. Gestión de sesiones, manejo de errores HTTP y timeouts para robustecer la adquisición de datos.                                                                                                                            |
| **Base64** |       ![Base64]()         | Codificación de credenciales                         | Utilizado para **codificar de forma segura las credenciales (API\_KEY, API\_SECRET)** antes de enviarlas en las cabeceras de autorización de las peticiones a la API de Idealista, añadiendo una capa básica de seguridad.                                                                                               |
| **Geopy** |        ![Geopy]()         | Cálculo de distancias geodésicas                     | **Ingeniería de características espaciales avanzadas**: cálculo de distancias exactas entre las propiedades y puntos de interés clave en Barcelona (e.g., centro de la ciudad, playas, parques, estaciones de transporte), lo cual puede ser un predictor muy potente del precio.                                           |
| **Scikit-learn** |     ![Scikit-learn]()     | Ecosistema de Machine Learning                       | Utilizado extensivamente para: <br> - **Preprocesamiento**: `SimpleImputer` (imputación de nulos), `StandardScaler`/`MinMaxScaler` (escalado de características), `PowerTransformer` (transformaciones no lineales). <br> - **Ingeniería de Características**: `PCA` (Análisis de Componentes Principales) para reducción de dimensionalidad o creación de features latentes, `KBinsDiscretizer` (discretización de variables continuas). <br> - **Clustering**: `KMeans` podría usarse para segmentar propiedades o barrios como una característica adicional. <br> - **Selección de Modelos**: `train_test_split`, `cross_val_score` para validación cruzada robusta. <br> - **Métricas de Evaluación**: `mean_squared_error`, `r2_score` para evaluar el rendimiento del modelo de regresión. <br> - **Pipelines**: Creación de `Pipeline` y `ColumnTransformer` para organizar y aplicar secuencialmente transformaciones complejas y específicas por tipo de columna, asegurando la reproducibilidad y evitando fugas de datos. |
| **XGBoost** |      ![XGBoost]()        | Modelo de Gradient Boosting de alto rendimiento        | Implementación del `XGBRegressor`. **Técnicas avanzadas**: <br> - Manejo nativo de valores faltantes. <br> - Regularización (L1/L2) para prevenir el sobreajuste. <br> - Optimización mediante validación cruzada y búsqueda de hiperparámetros (e.g., con `GridSearchCV` o `RandomizedSearchCV` de Scikit-learn). <br> - `Early Stopping` para encontrar el número óptimo de estimadores. <br> - Análisis de **importancia de características** (`feature_importances_`) para interpretar el modelo. |
| **Category Encoders** |      ![CatEnc]()        | Codificación de variables categóricas                | Proporciona una variedad de **estrategias de codificación para variables categóricas** más allá del One-Hot Encoding, como `TargetEncoder`, `LeaveOneOutEncoder`, o `HashingEncoder`, especialmente útiles para características con alta cardinalidad o cuando se busca capturar la relación entre la variable categórica y la variable objetivo. |
| **Joblib** |       ![Joblib]()         | Serialización eficiente de objetos Python            | Utilizado para **guardar (serializar) el pipeline de Scikit-learn completo** (que incluye todos los pasos de preprocesamiento y el modelo XGBoost entrenado) en un único archivo `.joblib`. Esto permite una fácil carga y reutilización del modelo en entornos de producción o para inferencias futuras sin necesidad de reentrenar. Es eficiente con objetos que contienen grandes arrays de NumPy. |
| **Google Colab** |   ![Google Colab]()     | Entorno de desarrollo basado en la nube (Jupyter)    | Proporciona un **entorno interactivo** con acceso gratuito a GPUs/TPUs (útil para acelerar el entrenamiento de modelos como XGBoost), preinstalación de librerías comunes, y fácil colaboración e integración con Google Drive para el almacenamiento de datos y modelos.                                               |

*Nota: Los placeholders `![Logo X]()` indican dónde podrías insertar los logos de las tecnologías si deseas añadirlos directamente a tu README.md en GitHub (por ejemplo, subiéndolos a una carpeta `.github/images` en tu repositorio y enlazándolos, o usando URLs de servicios de badges/iconos).*

### Diagrama del Flujo de Trabajo Tecnológico

```mermaid
graph TD
    A[Idealista API] -- Peticiones HTTP con<br/>Requests, Base64 (Credenciales) --> B(Datos Crudos en CSV);
    B -- Carga y Limpieza Inicial con<br/>Pandas & NumPy --> C{Análisis Exploratorio de Datos (EDA)};
    C -- Preparación para Modelado --> D_Pipeline["Pipeline de Preprocesamiento y Modelado (Scikit-learn)"];

    subgraph D_Pipeline
        direction LR
        D1[Entrada: Datos Limpios] --> D2{Imputación de Nulos<br/>(SimpleImputer)};
        D2 --> D3{Escalado de Características<br/>(StandardScaler/MinMaxScaler)};
        D3 --> D4{Codificación de Categóricas<br/>(Category Encoders: TargetEncoder, etc.)};
        D4 --> D5{Ingeniería de Características Avanzada<br/>(Geopy para distancias,<br/>PCA si aplica, Transformaciones)};
        D5 --> D6[Modelo Predictivo<br/>(XGBoost: XGBRegressor)];
    end

    D_Pipeline -- Entrenamiento y Optimización --> E{Validación Cruzada y<br/>Ajuste de Hiperparámetros};
    E -- Pipeline Entrenado --> F[Serialización del Pipeline Completo<br/>(Joblib -> .joblib)];

    G((Entorno de Desarrollo<br/>Google Colab<br/>Lenguaje: Python));

    classDef apiNode fill:#87CEEB,stroke:#333,stroke-width:2px,color:#000;
    classDef dataNode fill:#90EE90,stroke:#333,stroke-width:2px,color:#000;
    classDef processNode fill:#FFD700,stroke:#333,stroke-width:2px,color:#000;
    classDef modelNode fill:#FFA07A,stroke:#333,stroke-width:2px,color:#000;
    classDef outputNode fill:#DDA0DD,stroke:#333,stroke-width:2px,color:#000;
    classDef envNode fill:#E6E6FA,stroke:#333,stroke-width:2px,color:#000;

    class A apiNode;
    class B,C dataNode;
    class D2,D3,D4,D5,E processNode;
    class D6 modelNode;
    class F outputNode;
    class G envNode;
