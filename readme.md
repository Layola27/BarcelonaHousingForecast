# BarcelonaHousingForecast

[![Estado del Repositorio](https://img.shields.io/badge/estado-activo-green.svg)](https://github.com/Layola27/BarcelonaHousingForecast/)
[![GitHub issues](https://img.shields.io/github/issues/Layola27/BarcelonaHousingForecast.svg)](https://github.com/Layola27/BarcelonaHousingForecast/issues)
[![GitHub forks](https://img.shields.io/github/forks/Layola27/BarcelonaHousingForecast.svg)](https://github.com/Layola27/BarcelonaHousingForecast/network)
[![GitHub stars](https://img.shields.io/github/stars/Layola27/BarcelonaHousingForecast.svg)](https://github.com/Layola27/BarcelonaHousingForecast/stargazers)

## Descripción del Proyecto

**BarcelonaHousingForecast** es un proyecto dedicado a la previsión y pronóstico de la vivienda en la ciudad de Barcelona. Utilizando técnicas de análisis de datos y modelado predictivo, este repositorio busca explorar tendencias, identificar factores influyentes y generar modelos que puedan estimar la evolución futura del mercado inmobiliario barcelonés. El objetivo principal es proporcionar una herramienta analítica para comprender mejor las dinámicas de precios y disponibilidad de vivienda en esta área metropolitana.

## Tecnologías Utilizadas

Este proyecto se basa en un conjunto de tecnologías para el análisis de datos, modelado y visualización:

* **Lenguajes de Programación:**
    * **Jupyter Notebook (Python):** Utilizado predominantemente para el procesamiento de datos, análisis exploratorio y desarrollo de modelos predictivos (representa el 99.7% del código).
    * **R:** Empleado para tareas específicas de análisis estadístico o modelado (representa el 0.3% del código).
* **Herramientas de Análisis y Modelado:**
    * **Orange Data Mining:** Potencialmente utilizado para el análisis visual de datos y la creación de flujos de trabajo de machine learning, como sugiere la carpeta `Orange/`.
* **Base de Datos:**
    * **PostgreSQL:** Posiblemente implementado para el almacenamiento, gestión y consulta eficiente de los conjuntos de datos relacionados con la vivienda, indicado por la carpeta `PostgreSQL/`.
* **Visualización de Datos:**
    * **Power BI:** Utilizado para la creación de informes interactivos y dashboards que presentan los resultados del análisis y las predicciones, evidenciado por el archivo `BarcelonaHousingForecast.pbix`.

## Estructura del Repositorio

El repositorio está organizado de la siguiente manera para facilitar la navegación y el acceso a los diferentes componentes del proyecto. A continuación, se detalla el contenido esperado o ejemplos de archivos dentro de cada directorio principal:

* 📁 **`Modelos/`**: Esta carpeta contiene los scripts, notebooks de Jupyter o archivos de modelos entrenados relacionados con las diferentes técnicas de pronóstico implementadas.
    * 📄 `nombre_del_modelo_1.ipynb`: Notebook de Jupyter para [descripción de la funcionalidad, ej: modelo de regresión lineal para predecir precios].
    * 📄 `nombre_del_modelo_2.py`: Script de Python para [descripción de la funcionalidad, ej: entrenamiento de un modelo de series temporales ARIMA para la demanda].
    * 📄 `modelo_entrenado_xgboost.pkl`: Archivo de un modelo XGBoost preentrenado y serializado.
    * *(**Nota para el propietario del repositorio:** Por favor, actualiza esta sección con los nombres y descripciones reales de los archivos específicos que se encuentran en esta carpeta. Especifica el propósito de cada modelo o script.)*

* 📁 **`Orange/`**: Contiene archivos y flujos de trabajo (generalmente con extensión `.ows`) creados con Orange Data Mining. Estos podrían incluir pipelines de preprocesamiento de datos, modelado visual o análisis exploratorio.
    * 📄 `flujo_preprocesamiento_datos_brutos.ows`: Flujo de trabajo de Orange para la limpieza inicial y transformación de los datos de vivienda.
    * 📄 `analisis_exploratorio_variables.ows`: Flujo de trabajo para la visualización y exploración de las relaciones entre variables.
    * 📄 `comparativa_modelos_clasificacion.ows`: Flujo de trabajo para comparar diferentes algoritmos de clasificación en Orange.
    * *(**Nota para el propietario del repositorio:** Por favor, actualiza esta sección con los nombres y descripciones reales de los archivos de Orange Data Mining. Describe qué análisis o proceso realiza cada flujo de trabajo.)*

* 📁 **`PostgreSQL/`**: Incluye scripts SQL para la creación de esquemas de base de datos, inserción de datos, consultas o archivos de exportación/importación de datos (como `.csv` o volcados de base de datos) utilizados con PostgreSQL.
    * 📄 `crear_tablas_vivienda.sql`: Script SQL para definir la estructura de las tablas de la base de datos (ej: `tabla_propiedades`, `tabla_transacciones`).
    * 📄 `insertar_datos_iniciales.sql`: Script SQL para poblar las tablas con datos de ejemplo o iniciales.
    * 📄 `consultas_analiticas.sql`: Contiene ejemplos de consultas SQL para extraer información relevante para el análisis (ej: precios medios por distrito, evolución de ventas).
    * 📄 `backup_datos_vivienda_YYYYMMDD.sql`: Archivo de volcado (dump) de la base de datos en una fecha específica.
    * *(**Nota para el propietario del repositorio:** Por favor, actualiza esta sección con los nombres y descripciones reales de los scripts SQL y otros archivos relacionados con la base de datos. Detalla la función de cada script.)*

* 📁 **`Scripts/`**: Alberga scripts auxiliares en Python, R u otros lenguajes. Estos pueden ser utilizados para tareas como la recolección de datos (web scraping), limpieza y preprocesamiento avanzado, funciones de utilidad para los modelos o automatización de tareas.
    * 📄 `web_scraper_portales_inmobiliarios.py`: Script de Python para la recolección de datos de precios y características de viviendas de portales web.
    * 📄 `limpieza_avanzada_datos.R`: Script de R con funciones específicas para el preprocesamiento y la imputación de datos faltantes.
    * 📄 `funciones_metricas_evaluacion.py`: Módulo de Python con funciones para calcular métricas de evaluación de los modelos de pronóstico.
    * 📄 `generar_informe_automatico.py`: Script para automatizar la generación de partes del informe o la actualización de datos.
    * *(**Nota para el propietario del repositorio:** Por favor, actualiza esta sección con los nombres y descripciones reales de los scripts auxiliares. Explica la tarea que realiza cada uno.)*

* 📄 **`BarcelonaHousingForecast.pbix`**: Es el archivo fuente del informe o dashboard desarrollado en Power BI. Contiene las visualizaciones de datos, los análisis clave y los resultados de los pronósticos de forma interactiva. Su funcionalidad es presentar de manera gráfica y amigable los resultados del proyecto, permitiendo explorar las tendencias y predicciones del mercado de vivienda en Barcelona.

* 📄 **`memoria.md`**: Un documento en formato Markdown que sirve como memoria o informe detallado del proyecto. Debería incluir la justificación del proyecto, la metodología seguida, la descripción detallada de las fuentes de datos, los pasos del preprocesamiento, la arquitectura de los modelos desarrollados, la discusión de los resultados obtenidos, las limitaciones del estudio y las conclusiones finales.

## Instalación y Configuración

Para poner en marcha este proyecto en tu entorno local, sigue estos pasos generales:

1.  **Clonar el Repositorio:**
    ```bash
    git clone [https://github.com/Layola27/BarcelonaHousingForecast.git](https://github.com/Layola27/BarcelonaHousingForecast.git)
    cd BarcelonaHousingForecast
    ```

2.  **Configurar el Entorno de Python (Jupyter Notebook):**
    * Asegúrate de tener Python instalado (se recomienda la versión 3.7 o superior).
    * Se recomienda crear un entorno virtual:
        ```bash
        python -m venv venv
        source venv/bin/activate  # En Windows: venv\Scripts\activate
        ```
    * Instalar las dependencias listadas en un archivo `requirements.txt` (si existe):
        ```bash
        pip install -r requirements.txt
        ```
    * Si no hay `requirements.txt`, instala las bibliotecas comunes para análisis de datos:
        ```bash
        pip install jupyter notebook pandas numpy scikit-learn matplotlib seaborn
        ```

3.  **Configurar el Entorno de R:**
    * Asegúrate de tener R y RStudio (opcional, pero recomendado) instalados.
    * Instala los paquetes de R necesarios que se utilicen en los scripts `.R`. Puedes hacerlo desde la consola de R:
        ```R
        # Ejemplo: install.packages(c("dplyr", "ggplot2", "forecast", "readr"))
        ```

4.  **Configurar PostgreSQL (si aplica):**
    * Instala PostgreSQL si aún no lo tienes.
    * Crea una base de datos para el proyecto (ej: `barcelona_housing_db`).
    * Ejecuta los scripts SQL que se encuentren en la carpeta `PostgreSQL/` (ej: `crear_tablas_vivienda.sql`, `insertar_datos_iniciales.sql`) para configurar las tablas y cargar los datos si es necesario. Es posible que necesites configurar las credenciales de conexión (usuario, contraseña, host, puerto, nombre de la base de datos) en los scripts o notebooks correspondientes.

5.  **Instalar Power BI Desktop (para visualizar el archivo `.pbix`):**
    * Descarga e instala Power BI Desktop desde el sitio oficial de Microsoft. Es gratuito.

6.  **Instalar Orange Data Mining (si deseas trabajar con los archivos de la carpeta `Orange/`):**
    * Descarga e instala Orange desde su sitio web oficial.

## Uso

La forma de utilizar este repositorio dependerá de los componentes específicos que desees ejecutar:

1.  **Notebooks de Jupyter:**
    * Navega hasta la carpeta donde se encuentren los notebooks (principalmente en `Modelos/`).
    * Inicia Jupyter Notebook o Jupyter Lab:
        ```bash
        jupyter notebook
        # o
        jupyter lab
        ```
    * Abre los archivos `.ipynb` en tu navegador y ejecuta las celdas para replicar el análisis, preprocesamiento o entrenamiento de modelos. Asegúrate de que los paths a los datos sean correctos y de que la base de datos (si se usa) esté configurada y accesible.

2.  **Scripts de R:**
    * Abre los scripts `.R` (ubicados en `Scripts/` o `Modelos/`) con RStudio o ejecútalos desde la terminal:
        ```bash
        Rscript nombre_del_script.R
        ```
    * Verifica las dependencias de paquetes y las rutas a los archivos de datos.

3.  **Flujos de Trabajo de Orange:**
    * Abre Orange Data Mining.
    * Desde el menú "Archivo", selecciona "Abrir..." y navega hasta la carpeta `Orange/` para cargar los archivos de flujo de trabajo (generalmente con extensión `.ows`).
    * Ejecuta los flujos de trabajo y explora los resultados dentro de la herramienta.

4.  **Base de Datos PostgreSQL:**
    * Conéctate a tu instancia de PostgreSQL usando una herramienta como `psql` (línea de comandos) o pgAdmin (GUI).
    * Puedes ejecutar los scripts SQL de la carpeta `PostgreSQL/` para crear la estructura, cargar datos o realizar consultas.

5.  **Informe de Power BI:**
    * Abre el archivo `BarcelonaHousingForecast.pbix` con Power BI Desktop.
    * Es posible que necesites configurar las fuentes de datos si el informe se conecta a bases de datos locales o servicios externos. Podrás interactuar con los gráficos, tablas y segmentaciones para explorar los resultados.

## Resultados y Visualizaciones

Los principales resultados y visualizaciones del proyecto se encuentran consolidados en el archivo de Power BI:

* **`BarcelonaHousingForecast.pbix`**: Este archivo contiene un dashboard interactivo que muestra los hallazgos clave, tendencias del mercado inmobiliario de Barcelona (evolución de precios, oferta, demanda por zonas, etc.), y las predicciones generadas por los modelos. Para visualizarlo, necesitarás Power BI Desktop.

Los notebooks de Jupyter (`.ipynb`) y los scripts de R (`.R`) también pueden generar visualizaciones intermedias (gráficos, tablas) o específicas que complementan el informe principal. La carpeta `memoria.md` debe contener una descripción detallada de los resultados, su interpretación y las limitaciones del análisis.

## Contribuciones

Las contribuciones son bienvenidas para mejorar este proyecto. Si deseas contribuir, por favor sigue estos pasos:

1.  Haz un "Fork" de este repositorio.
2.  Crea una nueva rama para tu mejora o corrección de error:
    ```bash
    git checkout -b nombre-descriptivo-de-la-rama
    ```
3.  Realiza tus cambios y haz "commit" de ellos con mensajes claros y descriptivos:
    ```bash
    git commit -am 'Añade [descripción de la nueva funcionalidad o corrección]'
    ```
4.  Empuja tus cambios a tu "Fork":
    ```bash
    git push origin nombre-descriptivo-de-la-rama
    ```
5.  Abre un "Pull Request" (PR) hacia la rama `main` (o la rama de desarrollo principal) de este repositorio. En la descripción del PR, detalla los cambios realizados y por qué son necesarios.

Por favor, asegúrate de que tu código siga las convenciones del proyecto y de que incluyas una descripción clara de los cambios realizados. Si añades nuevas funcionalidades, considera también actualizar la documentación (este README o la `memoria.md`).

## Licencia

Este proyecto se distribuye bajo la **Licencia MIT**. Consulta el archivo `LICENSE` (si no existe en el repositorio, se recomienda añadir uno con el texto estándar de la licencia MIT) para más detalles. La Licencia MIT es permisiva y permite la reutilización, modificación y distribución del software, tanto para fines comerciales como no comerciales, siempre que se incluya la nota de copyright y la declaración de la licencia.

---

*Este README fue generado para el repositorio BarcelonaHousingForecast. Se recomienda encarecidamente al propietario del repositorio actualizar las secciones de la "Estructura del Repositorio" con los nombres y descripciones específicas de los archivos contenidos en cada carpeta para una mayor claridad y utilidad para los usuarios y colaboradores. Si tienes alguna pregunta o sugerencia, por favor abre un "issue" en el repositorio.*
