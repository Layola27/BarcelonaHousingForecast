# 🏠 Pronóstico de Precios de Vivienda en Barcelona: Análisis y Predicción con Datos de Idealista

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Jupyter Notebook](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)](https://jupyter.org/)
[![Pandas](https://img.shields.io/badge/pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Scikit-Learn](https://img.shields.io/badge/scikit--learn-%23F7931E.svg?style=for-the-badge&logo=scikit-learn&logoColor=white)](https://scikit-learn.org/)
[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/tu_usuario/tu_repositorio/graphs/commit-activity) ## 🎯 Descripción del Proyecto

Este repositorio contiene un proyecto integral para el **análisis y pronóstico de datos de vivienda en Barcelona**, con un enfoque particular en los datos obtenidos de Idealista. El proyecto abarca todo el ciclo de vida de un proyecto de ciencia de datos:

* **Adquisición de datos**: Obtención de datos directamente de la API de Idealista.
* **Preprocesamiento de datos**: Limpieza, transformación y preparación de los datos para el modelado.
* **Modelado predictivo**: Construcción y evaluación de modelos de machine learning para predecir los precios de la vivienda.
* **Visualización de resultados**: Creación de visualizaciones interactivas para comunicar los hallazgos y los resultados del modelo.

Se utilizan diversas herramientas y tecnologías, destacando el uso extensivo de **Jupyter Notebooks** para la manipulación, análisis y modelado de datos.

## 📂 Estructura del Repositorio

A continuación, se describe la estructura del repositorio y el propósito de cada componente:

    ├── Documentación/
    │   ├── memoria.md
    │   ├── readme.md
    │   └── workflow.md
    ├── Datos_y_Modelos/
    │   ├── BarcelonaHousingForecastBI.pbix
    │   └── Modelos/
    │       └── pipeline_idealista_completo.joblib
    ├── PostgreSQL/
    │   ├── CrearTabla.sql
    │   ├── PasarDatosCSV.sql
    │   ├── CrearIndiceEspacial.sql
    │   └── AjustarValores.sql
    └── Scripts/
        ├── 1.IdealistaAPI.ipynb
        ├── 2.AgregarNuevasViviendas.ipynb
        ├── 3.PreProcesamiento.ipynb
        ├── 4.ModeloExport.ipynb
        ├── Aux.EDA.ipynb
        ├── Aux.IdealistaModelo.ipynb
        ├── Aux.IdealistaModeloAmpliado.ipynb
        ├── Aux.ModeloImport.ipynb
        └── Graficaciones.R
    ├── .vscode/
    │   └── settings.json
    └── Orange/
        └── OrangeWorkflow.ows
    └── LICENSE
    └── README.md

## 🗂️ Componentes Clave

### 1. Documentación

* **`memoria.md`**: Documento que contiene la memoria del proyecto, incluyendo la justificación, metodología, resultados y conclusiones.
* **`readme.md`**: El archivo README principal del repositorio (este archivo).
* **`workflow.md`**: Descripción del flujo de trabajo del proyecto, incluyendo los pasos secuenciales y las dependencias entre las diferentes etapas.

### 2. Datos y Modelos

* **`BarcelonaHousingForecastBI.pbix`**: Archivo de Power BI que contiene cuadros de mando (dashboards) e informes interactivos para visualizar los resultados del análisis y pronóstico.
* **`Modelos/pipeline_idealista_completo.joblib`**: Archivo que guarda un pipeline completo de machine learning, serializado con la librería `joblib`. Este pipeline incluye pasos de preprocesamiento y el modelo predictivo entrenado.

### 3. Base de Datos (PostgreSQL)

* **`PostgreSQL/CrearTabla.sql`**: Script SQL para definir la estructura de las tablas en la base de datos PostgreSQL.
* **`PostgreSQL/PasarDatosCSV.sql`**: Script SQL para cargar datos desde archivos CSV a las tablas de la base de datos.
* **`PostgreSQL/CrearIndiceEspacial.sql`**: Script SQL para crear índices espaciales en la base de datos, optimizando las consultas basadas en la ubicación.
* **`PostgreSQL/AjustarValores.sql`**: Script SQL para realizar ajustes o transformaciones en los valores de la base de datos.

### 4. Scripts

#### 4.1 Scripts de Python (Jupyter Notebooks)

* **`Scripts/1.IdealistaAPI.ipynb`**: Notebook para la adquisición de datos directamente desde la API de Idealista.

    * **Funcionalidad**: Obtención de datos de anuncios de vivienda desde la API de Idealista.
    * **Detalles**:
        * Llamadas a la API de Idealista para obtener datos de viviendas.
        * Manejo de autenticación, respuestas JSON y paginación.
        * Posible manejo de errores de la API.
        * Ejemplo de uso de la API:

            ```python
            import requests

            url = "[https://api.idealista.com/3.5/es/search](https://api.idealista.com/3.5/es/search)"
            params = {
                "operation": "sale",
                "locationId": "0-1",  # Ejemplo: Barcelona
                "maxItems": 50,
                "numPage": 1
            }
            headers = {
                "Authorization": "Bearer TU_TOKEN_DE_AUTORIZACION" # Reemplazar
            }

            response = requests.get(url, params=params, headers=headers)

            if response.status_code == 200:
                data = response.json()
                print(data)
            else:
                print(f"Error al obtener datos: {response.status_code}")
            ```

* **`Scripts/2.AgregarNuevasViviendas.ipynb`**: Notebook para incorporar nuevas entradas de vivienda a un conjunto de datos existente.

    * **Funcionalidad**: Incorporación de nuevos datos de viviendas a un conjunto de datos maestro.
    * **Detalles**:
        * Integración de nuevos datos (de la API o de otra fuente) en un conjunto de datos existente.
        * Manejo de duplicados e inconsistencias.
        * Posible uso de `pandas`:

            ```python
            import pandas as pd

            # Cargar datos existentes
            df_existente = pd.read_csv("datos_existentes.csv")

            # Crear un DataFrame con los nuevos datos
            nuevos_datos = {
                "id": [101, 102],
                "precio": [250000, 300000],
                "ubicacion": ["Centro", "Gracia"]
            }
            df_nuevos = pd.DataFrame(nuevos_datos)

            # Concatenar los DataFrames
            df_combinado = pd.concat([df_existente, df_nuevos], ignore_index=True)

            # Eliminar duplicados
            df_combinado = df_combinado.drop_duplicates()

            print(df_combinado)
            df_combinado.to_csv("datos_actualizados.csv", index=False)
            ```

* **`Scripts/3.PreProcesamiento.ipynb`**: Notebook para la limpieza y transformación de los datos.

    * **Funcionalidad**: Limpieza y preparación de los datos para el modelado.
    * **Detalles**:
        * Manejo de valores faltantes (imputación, eliminación).
        * Detección y tratamiento de valores atípicos (outliers).
        * Codificación de variables categóricas (one-hot encoding, label encoding).
        * Escalado de variables numéricas (normalización, estandarización).
        * Ingeniería de características (creación de nuevas características).
        * Ejemplo de preprocesamiento con `scikit-learn`:

            ```python
            import pandas as pd
            from sklearn.model_selection import train_test_split
            from sklearn.preprocessing import StandardScaler, OneHotEncoder
            from sklearn.impute import SimpleImputer
            from sklearn.compose import ColumnTransformer
            from sklearn.pipeline import Pipeline

            # Cargar datos
            df = pd.read_csv("datos_vivienda.csv")

            # Separar variable objetivo
            X = df.drop("precio", axis=1)
            y = df["precio"]

            # Identificar columnas numéricas y categóricas
            numeric_features = X.select_dtypes(include=['number']).columns
            categorical_features = X.select_dtypes(include=['object']).columns

            # Crear pipeline de preprocesamiento para variables numéricas
            numeric_transformer = Pipeline(steps=[
                ('imputer', SimpleImputer(strategy='median')),
                ('scaler', StandardScaler())
            ])

            # Crear pipeline de preprocesamiento para variables categóricas
            categorical_transformer = Pipeline(steps=[
                ('imputer', SimpleImputer(strategy='most_frequent')),
                ('onehot', OneHotEncoder(handle_unknown='ignore'))
            ])

            # Combinar ambos pipelines usando ColumnTransformer
            preprocessor = ColumnTransformer(
                transformers=[
                    ('num', numeric_transformer, numeric_features),
                    ('cat', categorical_transformer, categorical_features)
                ])
            # Dividir los datos en entrenamiento y prueba
            X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

            # Aplicar el preprocesamiento a los datos de entrenamiento y prueba
            X_train_transformed = preprocessor.fit_transform(X_train)
            X_test_transformed = preprocessor.transform(X_test)

            print("X_train_transformed shape:", X_train_transformed.shape)
            print("X_test_transformed shape:", X_test_transformed.shape)
            ```

* **`Scripts/4.ModeloExport.ipynb`**: Notebook para exportar y guardar el modelo predictivo entrenado.

    * **Funcionalidad**: Guardar el modelo entrenado para su uso posterior.
    * **Detalles**:
        * Serialización del modelo y del pipeline de preprocesamiento usando `joblib`.
        * Ejemplo de exportación:

            ```python
            from joblib import dump

            # Asumiendo que 'modelo' es tu modelo entrenado
            # y 'preprocessor' es el ColumnTransformer del paso anterior
            pipeline = Pipeline(steps=[('preprocessor', preprocessor), ('model', modelo)]) # Crear pipeline

            dump(pipeline, 'Modelos/pipeline_idealista_completo.joblib')
            print("Modelo exportado a Modelos/pipeline_idealista_completo.joblib")
            ```

* **`Scripts/Aux.EDA.ipynb`**: Notebook auxiliar para realizar Análisis Exploratorio de Datos (EDA).

    * **Funcionalidad**: Análisis exploratorio de los datos para comprender sus características.
    * **Detalles**:
        * Visualización de la distribución de los datos.
        * Identificación de relaciones entre variables.
        * Detección de patrones y anomalías.
        * Uso de librerías como `pandas`, `numpy`, `matplotlib`, `seaborn` y `plotly`.
        * Ejemplo de EDA:

            ```python
            import pandas as pd
            import matplotlib.pyplot as plt
            import seaborn as sns

            # Cargar datos
            df = pd.read_csv("datos_vivienda.csv")

            # Mostrar las primeras filas del DataFrame
            print(df.head())

            # Obtener información sobre los tipos de datos y valores no nulos
            print(df.info())

            # Resumen estadístico de las variables numéricas
            print(df.describe())

            # Histograma de la variable 'precio'
            plt.figure(figsize=(8, 6))
            sns.histplot(df['precio'], kde=True)
            plt.title('Distribución del Precio de la Vivienda')
            plt.xlabel('Precio')
            plt.ylabel('Frecuencia')
            plt.show()

            # Gráfico de dispersión entre 'tamaño' y 'precio'
            plt.figure(figsize=(8, 6))
            sns.scatterplot(x='tamaño', y='precio', data=df)
            plt.title('Relación entre Tamaño y Precio')
            plt.xlabel('Tamaño (m2)')
            plt.ylabel('Precio')
            plt.show()

            # Boxplot de 'precio' por 'ubicacion'
            plt.figure(figsize=(10, 6))
            sns.boxplot(x='ubicacion', y='precio', data=df)
            plt.title('Distribución del Precio por Ubicación')
            plt.xlabel('Ubicacion')
            plt.ylabel('Precio')
            plt.show()
            ```

* **`Scripts/Aux.IdealistaModelo.ipynb`**: Notebook auxiliar para la construcción y entrenamiento de un modelo predictivo utilizando los datos de Idealista.

    * **Funcionalidad**: Construcción de un modelo de machine learning para predecir los precios de la vivienda.
    * **Detalles**:
        * Selección de características.
        * División de datos en conjuntos de entrenamiento y prueba.
        * Selección y configuración de un modelo de regresión.
        * Entrenamiento del modelo.
        * Evaluación del rendimiento del modelo (RMSE, MAE, R-squared).
        * Ejemplo de modelado con `scikit-learn`:

            ```python
            from sklearn.model_selection import train_test_split
            from sklearn.linear_model import LinearRegression
            from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score

            # Dividir los datos en entrenamiento y prueba
            X_train, X_test, y_train, y_test = train_test_split(X_transformed, y, test_size=0.2, random_state=42)

            # Crear el modelo de regresión lineal
            modelo = LinearRegression()

            # Entrenar el modelo
            modelo.fit(X_train, y_train)

            # Hacer predicciones en el conjunto de prueba
            y_pred = modelo.predict(X_test)

            # Evaluar el rendimiento del modelo
            rmse = mean_squared_error(y_test, y_pred, squared=False)
            mae = mean_absolute_error(y_test, y_pred)
            r2 = r2_score(y_test, y_pred)

            print(f"RMSE: {rmse}")
            print(f"MAE: {mae}")
            print(f"R-squared: {r2}")
            ```

* **`Scripts/Aux.IdealistaModeloAmpliado.ipynb`**: Notebook auxiliar para explorar modelos más complejos o enfoques alternativos.

    * **Funcionalidad**: Experimentación con diferentes modelos y técnicas para mejorar la precisión del pronóstico.
    * **Detalles**:
        * Exploración de otros algoritmos de machine learning (e.g., Random Forest, Gradient Boosting).
        * Optimización de hiperparámetros (e.g., Grid Search, Random Search).
        * Uso de técnicas de ensemble.
        * Incorporación de características adicionales.
        * Ejemplo de Grid Search para optimización de hiperparámetros:

            ```python
            from sklearn.model_selection import GridSearchCV
            from sklearn.ensemble import RandomForestRegressor

            # Definir la cuadrícula de hiperparámetros a explorar
            param_grid = {
                'n_estimators': [100, 200, 300],
                'max_depth': [5, 10, 15],
                'min_samples_split': [2, 5, 10],
                'min_samples_leaf': [1, 2, 4]
            }

            # Crear el modelo de Random Forest
            rf_model = RandomForestRegressor(random_state=42)

            # Crear el objeto GridSearchCV
            grid_search = GridSearchCV(estimator=rf_model,
                                            param_grid=param_grid,
                                            cv=5,  # Validación cruzada de 5 pliegues
                                            scoring='neg_mean_squared_error',  # Métrica a optimizar
                                            verbose=1,
                                            n_jobs=-1)  # Usar todos los procesadores disponibles

            # Realizar la búsqueda de la mejor combinación de hiperparámetros
            grid_search.fit(X_train, y_train)

            # Imprimir los mejores hiperparámetros encontrados
            print("Mejores hiperparámetros:", grid_search.best_params_)

            # Obtener el mejor modelo
            best_model = grid_search.best_estimator_

            # Evaluar el rendimiento del mejor modelo en el conjunto de prueba
            y_pred_best = best_model.predict(X_test)
            rmse_best = mean_squared_error(y_test, y_pred_best, squared=False)
            print(f"RMSE del mejor modelo: {rmse_best}")
            ```

* **`Scripts/Aux.ModeloImport.ipynb`**: Notebook auxiliar para cargar un modelo previamente entrenado y guardado.

    * **Funcionalidad**: Cargar un modelo previamente entrenado para realizar predicciones.
    * **Detalles**:
        * Carga del archivo `.joblib` que contiene el modelo y el pipeline.
        * Ejemplo de importación y uso del modelo:

            ```python
            from joblib import load

            # Cargar el modelo desde el archivo
            pipeline_cargado = load('Modelos/pipeline_idealista_completo.joblib')

            # Asumiendo que tienes nuevos datos de entrada para hacer predicciones
            nuevos_datos = pd.DataFrame({
                'tamaño': [100, 120, 80],
                'habitaciones': [3, 4, 2],
                'ubicacion': ['Centro', 'Gracia', 'Eixample']
            })  # Crear un DataFrame con los nuevos datos

            # Realizar predicciones con los nuevos datos
            predicciones = pipeline_cargado.predict(nuevos_datos)

            print("Predicciones:", predicciones)
            ```

#### 4.2 Script de R

* **`Scripts/Graficaciones.R`**: Script en lenguaje R para la generación de visualizaciones.

    * **Funcionalidad**: Creación de visualizaciones para comunicar los hallazgos del proyecto.
    * **Detalles**:
        * Generación de gráficos complejos y mapas temáticos.
        * Uso de librerías de R como `ggplot2`.
        * Ejemplo de visualización con `ggplot2`:

            ```R
            library(ggplot2)

            # Crear un data frame de ejemplo
            datos <- data.frame(
                ubicacion = c("Centro", "Gracia", "Eixample", "Sarrià-Sant Gervasi"),
                precio_promedio = c(350000, 300000, 400000, 450000),
                error_estandar = c(20000, 15000, 25000, 30000)
            )

            # Crear un gráfico de barras con barras de error
            ggplot(datos, aes(x = ubicacion, y = precio_promedio)) +
                geom_bar(stat = "identity", fill = "steelblue") +
                geom_errorbar(aes(ymin = precio_promedio - error_estandar,
                                  ymax = precio_promedio + error_estandar),
                              width = 0.2) +
                labs(title = "Precio Promedio de la Vivienda por Ubicación",
                     x = "Ubicación",
                     y = "Precio Promedio") +
                theme_minimal()
            ```

### 5. Otros Archivos

* **.vscode/settings.json**: Archivo de configuración para el editor Visual Studio Code.
* **Orange/OrangeWorkflow.ows**: Replicación del modelo generado para las predicciones.

## 📈 Flujo de Trabajo del Proyecto

El flujo de trabajo general del proyecto se puede resumir en los siguientes pasos:

1.  **Adquisición de Datos**: Obtención de datos de vivienda de la API de Idealista utilizando `Scripts/1.IdealistaAPI.ipynb`.
2.  **Incorporación de Datos**: Integración de nuevos datos con los datos existentes utilizando `Scripts/2.AgregarNuevasViviendas.ipynb`.
3.  **Carga a la Base de Datos**: Carga de datos en una base de datos PostgreSQL, incluyendo la creación de la estructura de la base de datos y la carga de datos desde archivos CSV.
4.  **Análisis Exploratorio de Datos (EDA)**: Realización de un EDA para comprender las características de los datos utilizando `Scripts/Aux.EDA.ipynb`.
5.  **Preprocesamiento de Datos**: Limpieza y transformación de los datos utilizando `Scripts/3.PreProcesamiento.ipynb`.
6.  **Modelado**: Construcción y entrenamiento de modelos predictivos utilizando `Scripts/Aux.IdealistaModelo.ipynb` y `Scripts/Aux.IdealistaModeloAmpliado.ipynb`.
7.  **Exportación del Modelo**: Guardado del modelo entrenado utilizando `Scripts/4.ModeloExport.ipynb`.
8.  **Importación del Modelo**: Carga del modelo guardado para realizar predicciones utilizando `Scripts/Aux.ModeloImport.ipynb`.
9.  **Visualización**: Creación de visualizaciones para comunicar los resultados del proyecto utilizando `Scripts/Graficaciones.R` y Power BI.
10. **Documentación**: Documentación del proyecto en `memoria.md` y `workflow.md`.

## 🤝 Contribución

¡Las contribuciones son bienvenidas! Si deseas contribuir a este proyecto, por favor, sigue estos pasos:

1.  Haz un fork del repositorio.
2.  Crea una rama para tu contribución (`git checkout -b mi-contribucion`).
3.  Realiza tus cambios.
4.  Haz commit de tus cambios (`git commit -m "Añade una nueva característica"`).
5.  Sube tus cambios a tu fork (`git push origin mi-contribucion`).
6.  Crea un pull request.

## 📄 Licencia

Este proyecto está licenciado bajo la licencia [MIT](LICENSE).

## 📧 Contacto

Si tienes alguna pregunta o sugerencia, no dudes en ponerte en contacto conmigo a través de [tu_correo@example.com](glayolacvs@gmail.com).
