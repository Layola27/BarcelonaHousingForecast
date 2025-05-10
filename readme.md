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

El repositorio está organizado de la siguiente manera para facilitar la navegación y el acceso a los diferentes componentes del proyecto:

* 📁 **`Modelos/`**: Esta carpeta probablemente contiene los scripts, notebooks de Jupyter o archivos de modelos entrenados relacionados con las diferentes técnicas de pronóstico implementadas (por ejemplo, regresión, series temporales, machine learning).
* 📁 **`Orange/`**: Contiene archivos y flujos de trabajo (`.ows` u otros formatos) creados con Orange Data Mining. Estos podrían incluir pipelines de preprocesamiento de datos, modelado visual o análisis exploratorio.
* 📁 **`PostgreSQL/`**: Puede incluir scripts SQL para la creación de esquemas de base de datos, inserción de datos, consultas o archivos de exportación/importación de datos (como `.csv` o volcados de base de datos) utilizados con PostgreSQL.
* 📁 **`Scripts/`**: Alberga scripts auxiliares en Python, R u otros lenguajes. Estos pueden ser utilizados para tareas como la recolección de datos (web scraping), limpieza y preprocesamiento de datos, funciones de utilidad para los modelos o automatización de tareas.
* 📄 **`BarcelonaHousingForecast.pbix`**: Es el archivo fuente del informe o dashboard desarrollado en Power BI. Contiene las visualizaciones de datos, los análisis clave y los resultados de los pronósticos de forma interactiva.
* 📄 **`memoria.md`**: Un documento en formato Markdown que sirve como memoria o informe detallado del proyecto. Podría incluir la justificación del proyecto, la metodología seguida, la descripción de los datos, los análisis realizados, los modelos desarrollados, los resultados obtenidos y las conclusiones.

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
        # Ejemplo: install.packages(c("dplyr", "ggplot2", "forecast"))
        ```

4.  **Configurar PostgreSQL (si aplica):**
    * Instala PostgreSQL si aún no lo tienes.
    * Crea una base de datos para el proyecto.
    * Ejecuta los scripts SQL que se encuentren en la carpeta `PostgreSQL/` para configurar las tablas y cargar los datos si es necesario. Es posible que necesites configurar las credenciales de conexión en los scripts o notebooks correspondientes.

5.  **Instalar Power BI Desktop (para visualizar el archivo `.pbix`):**
    * Descarga e instala Power BI Desktop desde el sitio oficial de Microsoft.

6.  **Instalar Orange Data Mining (si deseas trabajar con los archivos de la carpeta `Orange/`):**
    * Descarga e instala Orange desde su sitio web oficial.

## Uso

La forma de utilizar este repositorio dependerá de los componentes específicos que desees ejecutar:

1.  **Notebooks de Jupyter:**
    * Navega hasta la carpeta donde se encuentren los notebooks (probablemente en `Modelos/` o la raíz).
    * Inicia Jupyter Notebook o Jupyter Lab:
        ```bash
        jupyter notebook
        # o
        jupyter lab
        ```
    * Abre los archivos `.ipynb` en tu navegador y ejecuta las celdas para replicar el análisis, preprocesamiento o entrenamiento de modelos.

2.  **Scripts de R:**
    * Abre los scripts `.R` (ubicados en `Scripts/` o `Modelos/`) con RStudio o ejecútalos desde la terminal:
        ```bash
        Rscript nombre_del_script.R
        ```

3.  **Flujos de Trabajo de Orange:**
    * Abre Orange Data Mining.
    * Carga los archivos de flujo de trabajo (generalmente con extensión `.ows`) desde la carpeta `Orange/`.

4.  **Base de Datos PostgreSQL:**
    * Conéctate a tu instancia de PostgreSQL usando una herramienta como `psql` o pgAdmin.
    * Ejecuta los scripts SQL de la carpeta `PostgreSQL/` o interactúa con la base de datos según sea necesario para el proyecto.

5.  **Informe de Power BI:**
    * Abre el archivo `BarcelonaHousingForecast.pbix` con Power BI Desktop para explorar las visualizaciones y el informe interactivo.

## Resultados y Visualizaciones

Los principales resultados y visualizaciones del proyecto se encuentran consolidados en el archivo de Power BI:

* **`BarcelonaHousingForecast.pbix`**: Este archivo contiene un dashboard interactivo que muestra los hallazgos clave, tendencias del mercado inmobiliario de Barcelona, y las predicciones generadas por los modelos. Para visualizarlo, necesitarás Power BI Desktop.

Los notebooks de Jupyter y los scripts de R también pueden generar visualizaciones intermedias o específicas que complementan el informe principal. La carpeta `memoria.md` puede contener una descripción detallada de los resultados y su interpretación.

## Contribuciones

Las contribuciones son bienvenidas para mejorar este proyecto. Si deseas contribuir, por favor sigue estos pasos:

1.  Haz un "Fork" de este repositorio.
2.  Crea una nueva rama para tu mejora o corrección de error:
    ```bash
    git checkout -b feature/nueva-funcionalidad
    ```
3.  Realiza tus cambios y haz "commit" de ellos:
    ```bash
    git commit -am 'Añade nueva funcionalidad'
    ```
4.  Empuja tus cambios a tu "Fork":
    ```bash
    git push origin feature/nueva-funcionalidad
    ```
5.  Abre un "Pull Request" hacia la rama `main` de este repositorio.

Por favor, asegúrate de que tu código siga las convenciones del proyecto y de que incluyas una descripción clara de los cambios realizados.

## Licencia

Este proyecto se distribuye bajo la **Licencia MIT**. Consulta el archivo `LICENSE` (si no existe, puedes añadir uno con el texto estándar de la licencia MIT) para más detalles.

---

*Este README fue generado para el repositorio BarcelonaHousingForecast. Si tienes alguna pregunta o sugerencia, por favor abre un "issue" en el repositorio.*
