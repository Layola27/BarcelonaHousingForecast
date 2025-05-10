# Diagrama de Flujo de Trabajo de la Aplicación

Este diagrama ilustra los principales flujos de trabajo y la arquitectura de la aplicación.

```mermaid
graph TD
    %% === Subgraph Definiciones ===
    subgraph "Usuario (Navegador)"
        direction LR
        User["<img src='[https://img.icons8.com/ios-glyphs/30/user-male-circle.png](https://img.icons8.com/ios-glyphs/30/user-male-circle.png)' width='20'/> Usuario"]
        ReactApp["<img src='[https://img.icons8.com/color/48/react-native.png](https://img.icons8.com/color/48/react-native.png)' width='25'/> Frontend React (localhost:5173)<br/>(App.jsx)"]
    end

    subgraph "Infraestructura Dockerizada (Docker Compose)"
        direction LR
        subgraph "Servicio API Backend"
            direction TB
            FastAPI["<img src='[https://img.icons8.com/officel/40/python.png](https://img.icons8.com/officel/40/python.png)' width='25'/> API Backend (FastAPI)<br/>localhost:8000<br/>(main.py)"]
            PredictorModel["<img src='[https://img.icons8.com/fluency/48/data-configuration.png](https://img.icons8.com/fluency/48/data-configuration.png)' width='20'/> Pipeline Predictor<br/>(.joblib)"]
            SQLAgent["<img src='[https://img.icons8.com/fluency/48/artificial-intelligence.png](https://img.icons8.com/fluency/48/artificial-intelligence.png)' width='20'/> Agente SQL (LangChain)"]
        end

        subgraph "Servicios de Datos y LLM Local"
            direction TB
            PostgresDB["<img src='[https://img.icons8.com/color/48/postgreesql.png](https://img.icons8.com/color/48/postgreesql.png)' width='25'/> PostgreSQL DB<br/>localhost:5432<br/>(tabla: pisos_barcelona)"]
            Ollama["<img src='[https://ollama.com/public/ollama.png](https://ollama.com/public/ollama.png)' width='25' style='background-color:white; padding:2px; border-radius:3px;'/> Ollama LLM Service<br/>localhost:11434<br/>(ej. Mixtral/Llama3)"]
        end

        subgraph "Servicio de Automatización"
            direction TB
            N8N["<img src='[https://raw.githubusercontent.com/n8n-io/n8n-docs/master/static/icon.png](https://raw.githubusercontent.com/n8n-io/n8n-docs/master/static/icon.png)' width='25'/> n8n Workflows<br/>localhost:5678"]
            N8NWebhook["Webhook Trigger"]
            N8N_PGNode["PostgreSQL Node<br/>(DB Query)"]
            N8N_FormatNode["Function Node<br/>(Formatear Datos)"]
            N8N_LLMNode["LLM Node<br/>(Llamada a Gemini)"]
            N8N_EmailNode["Email Node<br/>(ej. Gmail/SMTP)"]
        end
    end

    subgraph "Servicios Cloud Externos"
        direction TB
        GeminiAPI["<img src='[https://img.icons8.com/color/48/google-bard.png](https://img.icons8.com/color/48/google-bard.png)' width='25'/> Google Gemini API"]
        EmailServiceProvider["<img src='[https://img.icons8.com/color/48/gmail-new.png](https://img.icons8.com/color/48/gmail-new.png)' width='25'/> Servicio de Email<br/>(ej. Gmail)"]
        UserMailbox["<img src='[https://img.icons8.com/fluency/48/mailbox-opened-flag-up.png](https://img.icons8.com/fluency/48/mailbox-opened-flag-up.png)' width='20'/> Bandeja Email Usuario"]
    end

    %% === Flujos de Interacción ===

    %% Flujo 1: Predicción de Precio
    User -- "1. Introduce datos de vivienda" --> ReactApp
    ReactApp -- "1a. POST /predict (JSON con características)" --> FastAPI
    FastAPI -- "1b. Carga y usa pipeline" --> PredictorModel
    FastAPI -- "1c. Predicción (precio)" --> ReactApp
    ReactApp -- "1d. Muestra precio estimado" --> User

    %% Flujo 2: Consulta a Base de Datos con LLM local (Ollama)
    User -- "2. Escribe pregunta en lenguaje natural (chat)" --> ReactApp
    ReactApp -- "2a. POST /query_database (pregunta JSON)" --> FastAPI
    FastAPI -- "2b. Pasa pregunta al Agente SQL" --> SQLAgent
    SQLAgent -- "2c. Genera prompt con schema y pregunta<br/>(para generar SQL)" --> Ollama
    Ollama -- "2d. Devuelve consulta SQL sugerida" --> SQLAgent
    SQLAgent -- "2e. Ejecuta consulta SQL" --> PostgresDB
    PostgresDB -- "2f. Devuelve resultado de la consulta" --> SQLAgent
    SQLAgent -- "2g. Genera prompt con resultado SQL y pregunta<br/>(para respuesta final)" --> Ollama
    Ollama -- "2h. Devuelve respuesta final en lenguaje natural" --> SQLAgent
    SQLAgent -- "2i. Respuesta final" --> FastAPI
    FastAPI -- "2j. Devuelve respuesta al frontend" --> ReactApp
    ReactApp -- "2k. Muestra respuesta en chat" --> User

    %% Flujo 3: Solicitud de Informe por Email vía n8n
    User -- "3. Introduce email y solicita informe" --> ReactApp
    ReactApp -- "3a. POST a Webhook n8n (email destinatario)" --> N8NWebhook
    N8NWebhook --> N8N_PGNode
    N8N_PGNode -- "3b. Query a PostgreSQL" --> PostgresDB
    PostgresDB -- "3c. Datos para informe" --> N8N_PGNode
    N8N_PGNode -- "3d. Datos crudos" --> N8N_FormatNode
    N8N_FormatNode -- "3e. Datos formateados para LLM" --> N8N_LLMNode
    N8N_LLMNode -- "3f. Prompt con datos a Gemini" --> GeminiAPI
    GeminiAPI -- "3g. Resumen del informe generado" --> N8N_LLMNode
    N8N_LLMNode -- "3h. Resumen" --> N8N_EmailNode
    N8N_EmailNode -- "3i. Envía email" --> EmailServiceProvider
    EmailServiceProvider -- "3j. Email entregado" --> UserMailbox
    N8NWebhook -.-> ReactApp
    %% Respuesta inmediata opcional

    %% Estilos (opcional, ajusta colores y formas)
    style User fill:#f9f,stroke:#333,stroke-width:2px,shape:circle
    style ReactApp fill:#add8e6,stroke:#333,stroke-width:2px
    style FastAPI fill:#90ee90,stroke:#333,stroke-width:2px
    style PredictorModel fill:#lightgrey,stroke:#333,stroke-width:1px,shape:cylinder
    style SQLAgent fill:#90ee90,stroke:#333,stroke-width:1px,shape:hexagon
    style PostgresDB fill:#ffcc99,stroke:#333,stroke-width:2px,shape:cylinder
    style Ollama fill:#ffb3ba,stroke:#333,stroke-width:2px,shape:hexagon
    style N8N fill:#decbe4,stroke:#333,stroke-width:2px
    style N8NWebhook fill:#decbe4,stroke:#333,stroke-width:1px,shape:cds
    style N8N_PGNode fill:#decbe4,stroke:#333,stroke-width:1px
    style N8N_FormatNode fill:#decbe4,stroke:#333,stroke-width:1px
    style N8N_LLMNode fill:#decbe4,stroke:#333,stroke-width:1px
    style N8N_EmailNode fill:#decbe4,stroke:#333,stroke-width:1px
    style GeminiAPI fill:#ccebc5,stroke:#333,stroke-width:2px,shape:hexagon
    style EmailServiceProvider fill:#ccebc5,stroke:#333,stroke-width:2px
    style UserMailbox fill:#f9f,stroke:#333,stroke-width:1px,shape:folder
