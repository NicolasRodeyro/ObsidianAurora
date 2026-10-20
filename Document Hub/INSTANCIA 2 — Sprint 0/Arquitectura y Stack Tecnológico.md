---
base: "[[Document Hub.base]]"
Created time: 2026-05-25T20:39:00
Last edited by: Octavio Escudero
Created by: Octavio Escudero
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Arquitectura y Stack Tecnológico Aurora

## 1. Introducción y Propósito

### 1.1 Objetivo del documento

Este documento registra las decisiones técnicas fundacionales del sistema Aurora, su arquitectura de solución y las pautas de desarrollo que guiarán la construcción del sistema. Su propósito es servir como referencia compartida para el equipo durante el desarrollo y para futuros mantenedores del sistema.

### 1.2 Audiencia

- Equipo de desarrollo (ingenieros de software e integradores de hardware).
- Director del proyecto.
- Futuros mantenedores y contribuyentes.

### 1.3 Sistema en alcance

Aurora es un ecosistema de acompañamiento y monitoreo para personas con Alzheimer u otros trastornos de memoria que residen en su hogar. Se compone de cuatro subsistemas principales:

| **Componente** | **Descripción** |
| --- | --- |
| **Aurora Home** | Asistente de voz que interactúa proactivamente con el paciente. |
| **Aurora Band** | Pulsera comercial para monitoreo biométrico. Fuera del MVP (decisión del 29/08/2026): se conserva como visión de futuras versiones. |
| **Aurora Care** | Aplicación móvil para cuidadores (monitoreo, alertas, configuración). |
| **Aurora Core** | Núcleo de orquestación, automatización, análisis e IA. |

El alcance de este documento es el del MVP definido en el Estudio Inicial. Aurora Band no forma parte del MVP: se documenta como visión de futuras versiones.

### 1.4 Convenciones del documento

- Los diagramas utilizan la notación **C4 Model** (Contexto, Contenedores, Despliegue) con sintaxis **Mermaid**.
- Las decisiones arquitectónicas significativas se registran como **Architecture Decisión Records (ADRs)** en la sección 3.
- Cada ADR incluye: contexto, alternativas consideradas, criterios de comparación, decisión tomada y consecuencias (incluyendo trade-offs negativos).

## 2. Arquitectura de Solución — Modelo C4

### 2.1 Contexto (Nivel 1)

El diagrama de contexto muestra a Aurora como un sistema que interactúa con el paciente (por voz), el cuidador (a través de Aurora Care) y diversos sistemas externos para brindar sus funcionalidades.

![C4 Nivel 1 - Contexto](images/C4%20Nivel%201%20-%20Contexto.png)

#### Actores del sistema

| Actor | Descripción |
| --- | --- |
| Paciente | Persona con Alzheimer o pérdida de memoria. Interactúa exclusivamente por voz con Aurora Home. No requiere habilidades técnicas. |
| Cuidador | Familiar o profesional que supervisa al paciente. Utiliza Aurora Care (app móvil) para monitorear, configurar rutinas y recibir alertas. |

#### Sistemas externos

| **Sistema** | **Propósito** |
| --- | --- |
| **Proveedor LLM** | Generación de respuestas conversacionales, inferencia emocional y adaptación de contenido. Se accede sólo a través del Worker IA; el proveedor es configurable (hoy Gemini de Google, modelo gemini-3.5-flash-lite, con OpenAI como alternativa). |
| **Servicios de voz (Azure Speech)** | Reconocimiento (STT) y síntesis (TTS) de voz en la nube, con respaldo local en Aurora Home (Whisper.cpp y Piper). |
| **WhatsApp / Telegram API** | Futuras versiones. Canales de notificación alternativos al cuidador. |
| **API de Telefonía** | Futuras versiones. Llamada automática de emergencia cuando la alerta escala. |
| **Email SMTP** | Futuras versiones. Notificaciones por correo electrónico (reportes diarios/semanales). |
| **Expo Push** | Notificaciones push a la app Aurora Care (único canal externo de notificación en el MVP). |
| **Proveedor de autenticación (Supabase Auth)** | Identidad de los cuidadores: Aurora Core valida el JWT emitido por Supabase Auth. |

### 2.2 Contenedores (Nivel 2)

El diagrama de contenedores descompone el sistema en sus unidades desplegables y muestra las relaciones entre ellas.

![C4 Nivel 2 - Contenedores](images/C4%20Nivel%202%20-%20Contenedores.png)

**Descripción de contenedores**

| **Contenedor** | **Tecnología vigente** | **Responsabilidad** |
| --- | --- | --- |
| **Aurora Home** | Raspberry Pi 5 + Debian 13 + Python (arquitectura hexagonal) + SQLite | Captura de audio, STT y TTS (nube con respaldo local), ejecución de recordatorios y actividades, cola de eventos offline y sincronización con Aurora Core. MVP. |
| **Aurora Core** | Python 3.12 + Django + DRF + Channels | API REST y WebSocket, lógica de dominio, validación de JWT, alertas y notificaciones push. MVP. |
| **Worker IA** | Python + FastAPI | Inferencia con LLM, memoria del paciente, insights y resúmenes. Es el único acceso al LLM. MVP. |
| **Base de Datos y Autenticación** | Supabase (PostgreSQL 16 + pgvector + Supabase Auth + Storage) | Datos relacionales, vectores de embeddings para la memoria del paciente, usuarios y archivos (fotos de recuerdos y audios). MVP. |
| **Redis** | Redis 7 (en el backend, en el VPS) | Caché y pub-sub entre servicios. Aurora Home no usa Redis. MVP. |
| **n8n** | n8n (self-hosted) | Disparo programado de interacciones diarias (alcance acotado en el MVP). |
| **Aurora Care** | React Native + Expo + TypeScript | App móvil del cuidador: configuración, estado, historial y alertas push. MVP. |
| **Aurora Band Gateway** | No desplegado | Ingesta de datos biométricos. Futuras versiones: fuera del MVP (decisión del 29/08/2026). |

### 2.3 Despliegue (Nivel 3)

El diagrama de despliegue muestra cómo se distribuyen físicamente los contenedores en la infraestructura.

![C4 Nivel 3 - Despliegue](images/C4%20Nivel%203%20-%20Despliegue.png)

#### Estrategia de despliegue

| **Ambiente** | **Infraestructura** | **Propósito** |
| --- | --- | --- |
| **Desarrollo** | Local (Docker Compose) | Desarrollo activo, testing interno, pruebas unitarias y de integración. |
| **Staging** | VPS Hostinger (entorno de staging) | Integración, pruebas E2E, validación con stakeholders. |
| **Producción** | VPS Hostinger (entorno de producción, en el mismo servidor) | Uso real con pacientes. |

**Nota sobre costos:** La configuración inicial combina un VPS de Hostinger y servicios gestionados con plan gratuito:

- **1 VPS Hostinger** — Aurora Core, n8n, Worker IA y Redis, con Docker Compose y Traefik (TLS con Let's Encrypt). Aloja los dos entornos: staging y producción. El costo figura en el Plan de Proyecto, sección 6.2.

- Supabase Free Project ($0) — Base de datos PostgreSQL + pgvector (500 MB).
- Distribución mediante Google Play y App Store, o builds internos durante el MVP — Aurora Care (frontend estático).
- **Redis 7 en el mismo VPS ($0)** — caché y pub-sub entre servicios.
- **Alternativas futuras (no vigentes):** AWS u on-premise (servidor local en el hogar del paciente), si el VPS dejara de ser suficiente.

## 3. Architecture Decision Records (ADRs)

**Gobierno de los ADR.** Cada ADR tiene un estado: Propuesto, Aceptado, Reemplazado por ADR-N o Rechazado. Solo los ADR aceptados describen la arquitectura vigente. Las tecnologías que aparecen en una tabla o en un diagrama deben corresponder a un ADR aceptado; las alternativas se anotan dentro del ADR, y nunca en las tablas de contenedores o de despliegue. Cuando un ADR cambia de estado, se actualizan en la misma tarea los diagramas C4 y las secciones que lo mencionan. En el repositorio, cada ADR vive en docs/adr/ junto al código que gobierna.

**Estado al 12/10/2026.** ADR-001 a ADR-004: aceptados. ADR-005: aceptado con enmienda (proveedor: Supabase Auth). ADR-006: reemplazado por ADR-011. ADR-007 y ADR-008: aceptados con enmienda. ADR-009: aceptado, sin implementar (fuera del MVP). ADR-010 y ADR-011: aceptados.

### ADR-001: Lenguaje y Framework Backend

| Campo | Valor |
| --- | --- |
| ID | ADR-001 |
| Fecha | Mayo 2026 |
| Estado | Aceptado |
| Decisores | Equipo Aurora |

**Contexto**

El backend de Aurora (Aurora Core) debe manejar múltiples responsabilidades: API REST para Aurora Care y Aurora Home, WebSocket para comunicación bidireccional en tiempo real, procesamiento de eventos, integración con n8n, y gestión de datos. El equipo no tiene una preferencia definida previamente.

**Drivers de decisión**

1. **Baja latencia** para interacciones conversacionales en tiempo real
2. **Ecosistema maduro** para integración con n8n (construido en Node.js)
3. **Facilidad de despliegue** en un VPS con Docker (solución vigente) o en la nube
4. **Curva de aprendizaje razonable** para el equipo
5. **Tipado estático** para reducir errores en un sistema crítico (alertas de emergencia)
6. **Rendimiento** para concurrencia moderada (~decenas de pacientes simultáneos)

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba (experiencia del equipo, ecosistema de IA, despliegue en un VPS con Docker, WebSocket, tipado y concurrencia):

- Node.js (NestJS o Express): tiene WebSocket nativo, tipado con TypeScript y afinidad con n8n; el equipo tiene menos experiencia con él en el backend y su ecosistema de IA es menor. Descartada.
- Python con FastAPI: es liviano, asíncrono y tipado con Pydantic; no incluye ORM, migraciones ni panel de administración, que habría que armar aparte. Se usa en el Worker IA, donde esas piezas no hacen falta.

**Decisión**

Se adopta **Python con Django** como lenguaje y framework backend para Aurora Core.

**Fundamento**:

- El equipo tiene experiencia sólida en Python, lo que acelera el desarrollo y reduce la curva de aprendizaje
- Django ofrece un ecosistema maduro con ORM, autenticación, admin panel y migraciones integradas
- La integración con IA/ML es nativa (Python es el lenguaje estándar del ecosistema)
- Django REST Framework (DRF) proporciona una base sólida para la API REST
- La concurrencia con Django Channels + ASGI cubre las necesidades de WebSocket
- Aunque n8n está construido en Node.js, la integración vía webhooks/REST no requiere mismo lenguaje

**Consecuencias**

**Positivas**:

- Mayor velocidad de desarrollo gracias a la familiaridad del equipo con Python/Django
- Ecosistema IA/ML directamente accesible (LangChain, transformers, spaCy, etc.)
- Django Admin proporciona una interfaz de gestión rápida para debugging interno
- ORM maduro con migraciones automáticas y soporte para PostgreSQL + pgvector
- Comunidad grande, documentación extensa y abundantes paquetes de terceros

**Negativas (trade-offs):**

- Django no es asíncrono por defecto; requiere configuración ASGI (Daphne/Uvicorn) para WebSocket
- Menor rendimiento bruto que Node.js o Java en operaciones CPU-bound ligeras
- n8n está construido en Node.js, lo que implica un stack heterogéneo (Python + Node.js)
- Tipado dinámico de Python requiere disciplina y herramientas externas (mypy, Pydantic) para compensar

### ADR-002: Framework Frontend para Aurora Care

| Campo | Valor |
| --- | --- |
| ID | ADR-002 |
| Fecha | Mayo 2026 |
| Estado | Aceptado |

**Contexto**

Aurora Care es la aplicación utilizada por los cuidadores para monitorear el estado del paciente, configurar rutinas y medicación, consultar historiales, administrar el entorno del hogar y recibir alertas ante eventos relevantes o críticos.

Debido a que estas alertas pueden requerir una respuesta inmediata, la aplicación debe estar disponible principalmente en dispositivos móviles y permitir el uso confiable de notificaciones push, acceso rápido desde el celular e integración con funcionalidades propias del dispositivo.

Aurora Care debe funcionar en Android e iOS, manteniendo una única base de código y permitiendo futuras integraciones con servicios del sistema operativo, dispositivos Bluetooth, ubicación, almacenamiento seguro y tareas ejecutadas en segundo plano.

**Drivers de decisión**

- Soporte para Android e iOS utilizando una única base de código.
- Recepción confiable de notificaciones push para alertas críticas.
- Acceso a funcionalidades nativas del dispositivo, como Bluetooth, ubicación, sensores y almacenamiento seguro.
- Posibilidad de ejecutar determinadas tareas en segundo plano.
- Integración futura con dispositivos wearables o biométricos.
- Implementación de deep links para abrir alertas, mapas o pantallas específicas desde una notificación.
- Modo offline parcial para consultar información reciente y almacenar temporalmente determinadas acciones.
- Compatibilidad con autenticación OAuth 2.0.
- Disponibilidad de herramientas para compilación, pruebas, distribución y actualización de la aplicación.
- Capacidad de incorporar módulos nativos cuando una funcionalidad lo requiera.

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba (una sola base de código, notificaciones push confiables, funciones nativas, tareas en segundo plano y herramientas de compilación y distribución):

- Next.js (aplicación web): fue la primera versión de Aurora Care; se abandonó rápidamente porque la app necesita funciones nativas de los dispositivos (notificaciones push confiables, tareas en segundo plano, almacenamiento seguro y, a futuro, Bluetooth). Descartada.
- React Native sin Expo: usa el mismo lenguaje y da más control; la configuración nativa y las compilaciones son más costosas de mantener. Descartada.

**Decisión**

Se adopta **React Native con Expo** como framework frontend para Aurora Care.

La aplicación será desarrollada para dispositivos móviles Android e iOS, utilizando una única base de código compartida entre ambas plataformas.

Se utilizará **TypeScript** como lenguaje principal para mejorar el tipado, reducir errores y facilitar el mantenimiento del código.

Se utilizará **Expo Router** para organizar la navegación, las rutas y la estructura de pantallas de la aplicación.

Se utilizarán **Expo Development Builds** cuando sea necesario integrar funcionalidades que requieran configuración nativa, como:

- Notificaciones push.
- Bluetooth.
- Ubicación.
- Tareas en segundo plano.
- Deep links.
- Almacenamiento seguro.
- Integraciones con sensores o dispositivos externos.

Expo Go podrá utilizarse para pruebas iniciales de funcionalidades compatibles, pero no será considerado el entorno definitivo de desarrollo o validación.

Durante el desarrollo, la aplicación podrá distribuirse mediante builds internos instalables. Para producción, podrá publicarse en Google Play Store y Apple App Store.

**Fundamento**

React Native permite desarrollar aplicaciones móviles utilizando componentes de React que se representan mediante componentes nativos de Android e iOS.

Esta tecnología permite compartir gran parte del código entre ambas plataformas, incluyendo:

- Componentes de interfaz.
- Navegación.
- Validaciones.
- Lógica de negocio.
- Gestión del estado.
- Acceso a APIs.
- Modelos y tipos de datos.
- Manejo de errores.

Expo proporciona un conjunto de herramientas y librerías que simplifican la configuración, compilación, distribución y mantenimiento de aplicaciones desarrolladas con React Native.

La utilización de Expo permite reducir la complejidad inicial del desarrollo sin impedir el acceso a funcionalidades nativas. Mediante Development Builds y Configuration Plugins, el equipo podrá integrar librerías y configuraciones específicas de Android e iOS cuando el proyecto lo requiera.

La elección resulta adecuada para Aurora Care debido a su enfoque principalmente móvil y a la necesidad de recibir alertas, utilizar capacidades del dispositivo e integrarse con servicios nativos.

**Consecuencias**

**Positivas**

- Una única base de código para Android e iOS.
- Reutilización de componentes, lógica de negocio y modelos de datos.
- Experiencia de usuario integrada con el sistema operativo.
- Acceso a notificaciones push nativas.
- Posibilidad de utilizar Bluetooth, ubicación, sensores y almacenamiento seguro.
- Compatibilidad con deep links desde notificaciones.
- Posibilidad de ejecutar determinadas tareas en segundo plano.
- Mayor preparación para futuras integraciones con wearables.
- Desarrollo inicial simplificado mediante Expo.
- Navegación estructurada mediante Expo Router.
- Posibilidad de incorporar módulos nativos mediante Development Builds.
- Distribución de builds internos antes de publicar la aplicación.
- Reutilización de conocimientos del equipo sobre React y TypeScript.
- Mayor coherencia con el enfoque móvil de Aurora Care.

**Negativas y trade-offs**

- Será necesario generar y mantener builds para Android e iOS.
- La publicación en producción requerirá cuentas de desarrollador, certificados y firmas digitales.
- Algunas funcionalidades deberán configurarse de manera diferente en cada sistema operativo.
- La aplicación deberá probarse en ambas plataformas y en diferentes versiones de Android e iOS.
- Determinadas librerías podrán requerir Configuration Plugins o modificaciones de código nativo.
- La integración con Bluetooth puede presentar diferencias según el sistema operativo y el fabricante del dispositivo.
- Las tareas en segundo plano estarán sujetas a restricciones propias de Android e iOS.
- Algunas funcionalidades no podrán probarse directamente mediante Expo Go.
- Las modificaciones que afecten código o configuración nativa requerirán generar una nueva compilación.
- La distribución mediante tiendas estará sujeta a sus procesos de revisión y aprobación.
- El equipo deberá incorporar conocimientos sobre permisos, builds, certificados y publicación de aplicaciones móviles.
- El modo offline requerirá una estrategia específica de almacenamiento local, sincronización y resolución de conflictos.

### ADR-003: Base de Datos (Relacional y Vectorial)

| Campo | Valor |
| --- | --- |
| ID | ADR-003 |
| Fecha | Mayo 2026 |
| Estado | Aceptado |

**Contexto**

Aurora requiere persistencia para datos relacionales (pacientes, cuidadores, eventos, rutinas, alertas, configuraciones) y datos vectoriales previstos a futuro (embeddings para RAG — Retrieval-Augmented Generation — en el motor de IA). En el MVP la memoria del paciente se consulta de forma contextual, sin búsqueda vectorial: el motor de IA toma las memorias aprobadas y neutrales y las envía como contexto. Se evaluaron opciones de base de datos única vs. especializadas.

**Drivers de decisión**

1. **Consistencia y confiabilidad** para datos de salud (eventos, alertas, medicación)
2. **Búsqueda vectorial** eficiente para el RAG previsto a futuro (memoria del paciente, contexto conversacional)
3. **Costo** en Free Tier / bajos recursos
4. **Simplicidad operativa** (preferible una sola base de datos)
5. **Respaldo y recuperación** ante fallas

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba (consistencia para datos de salud, búsqueda vectorial, costo bajo, simplicidad operativa y respaldo):

- PostgreSQL gestionado en AWS (RDS) con pgvector: da más control; cuesta más, exige más administración y no incluye autenticación ni almacenamiento de archivos. Descartada.
- PostgreSQL propio en el VPS: tiene el menor costo; el equipo tendría que administrar respaldos, actualizaciones y seguridad. Descartada.

**Decisión**

Se adopta **Supabase (PostgreSQL 16 + pgvector)** como plataforma de datos.

**Fundamento:**

- Supabase ofrece PostgreSQL gestionado con extensión pgvector incluida, eliminando la necesidad de administrar RDS
- Incluye autenticación, Realtime (WebSocket), Storage y APIs automáticas, reduciendo servicios externos
- Plan Free Project (500 MB DB, 2 GB storage, 50k MAU) es suficiente para prototipo y validación
- Al estar basado en PostgreSQL puro, no hay vendor lock-in: se puede migrar a PostgreSQL estándar en cualquier momento
- pgvector proporciona búsqueda vectorial HNSW integrada, suficiente para el RAG previsto (memoria del paciente). Hoy el MVP no usa búsqueda vectorial: consulta las memorias aprobadas como contexto (hasta 20 por consulta) y guarda los embeddings como JSON; pgvector queda disponible en Supabase para esa evolución

**Consecuencias**

**Positivas:**

- Reducción de servicios externos: Supabase reemplaza RDS, ElastiCache (Realtime), Auth0 y S3 (storage)
- Costo inicial $0 con el Free Project de Supabase
- APIs automáticas de Supabase (REST + Realtime) agilizan el desarrollo inicial
- Migración trivial a PostgreSQL estándar si se supera el Free Tier
- Auth integrado con Row Level Security (RLS) para multi-tenant cada cuidador autenticado puede acceder solo a las cuentas DOT/hogar en las que tenga una asociación activa. Desde esa cuenta DOT accede al paciente único asociado al hogar.

**Negativas:**

- Free Project limitado a 500 MB DB, 2 proyectos simultáneos
- Supabase Realtime no es un reemplazo completo de Redis para colas/pub-sub complejos
- Dependencia parcial de un servicio externo (Supabase Cloud); la instancia self-hosted de Supabase requiere recursos adicionales
- pgvector tiene rendimiento inferior a soluciones vectoriales dedicadas (Qdrant, Pinecone) en conjuntos de datos muy grandes (>1M vectores), pero es suficiente para el volumen esperado

### ADR-004: Patrón Arquitectónico

| Campo | Valor |
| --- | --- |
| ID | ADR-004 |
| Fecha | Mayo 2026 |
| Estado | Aceptado |

**Contexto**

Aurora integra múltiples subsistemas (voz, IA, automatización, notificaciones, app móvil del cuidador) que deben coordinarse de manera confiable. El patrón arquitectónico define cómo se estructuran y comunican estos componentes.

**Drivers de decisión**

1. **Tolerancia a fallos parciales**: una caída en la IA no debe impedir recordatorios básicos
2. **Escalabilidad selectiva**: los componentes críticos (alertas, Worker IA) pueden necesitar escalar independientemente
3. **Complejidad controlada**: el equipo es pequeño y el presupuesto acotado
4. **Integración con n8n**: el orquestador de flujos existente en el diseño
5. **Evolución**: poder partir de una arquitectura simple y evolucionar hacia microservicios si es necesario

**Alternativas consideradas**

Se comparó la opción siguiente con los drivers de decisión de arriba (tolerancia a fallos parciales, escalabilidad selectiva, complejidad controlada e integración con n8n):

- Monolito Django con la IA incluida: es lo más simple de desplegar y de depurar; una caída o una demora del modelo de lenguaje afectaría a los recordatorios, y la IA no podría escalar por separado. Descartada.

**Decisión**

Se adopta el patrón de **Microservicios** como arquitectura principal, organizados por dominio.

**Estructura propuesta:**

- **Aurora Core API** — Gateway REST + WebSocket (Django + Channels) — punto único de entrada
- **Worker IA** — Servicio Python independiente (FastAPI) para inferencia LLM + RAG
- **Aurora Band Gateway (futuras versiones, no desplegado en el MVP) —** Servicio Python / Django para ingesta de datos biométricos
- **n8n** — Orquestador de flujos separado para automatización (recordatorios, escalado de alertas)
- Comunicación síncrona vía REST/HTTP entre servicios; comunicación asíncrona vía Redis Pub/Sub (el Redis 7 del backend) para eventos en tiempo real

**Fundamento**:

- Tolerancia a fallos parciales: una caída del Worker IA no afecta los recordatorios programados
- Escalabilidad selectiva: el Worker IA puede escalar independientemente si aumenta la demanda de LLM
- n8n como orquestador externo desacopla la automatización de flujos del código de dominio
- Redis Pub/Sub (del backend) como backbone de eventos permite comunicación en tiempo real sin acoplar servicios
- Cada servicio puede desarrollarse en el lenguaje más adecuado (Python para Aurora Core y el Worker IA; n8n corre sobre Node.js)

**Consecuencias**

**Positivas:**

- Aislamiento de fallos: un error en el Worker IA no bloquea el resto del sistema
- Despliegue independiente: cada servicio puede actualizarse sin afectar a los demás
- El stack heterogéneo (Python y n8n sobre Node.js) permite usar la herramienta adecuada para cada tarea
- n8n externaliza flujos de automatización sin necesidad de código personalizado
- Redis Pub/Sub proporciona comunicación en tiempo real desacoplada

**Negativas:**

- Mayor complejidad operativa: múltiples servicios que monitorear, desplegar y mantener
- Latencia de red entre servicios (vs. llamadas internas en un monolito)
- Consistencia eventual entre servicios: requiere manejo de estados y compensaciones
- Debugging distribuido más complejo (trazabilidad entre servicios)
- El equipo pequeño enfrenta una sobrecarga inicial de configuración (Docker Compose, redes, health checks)

### ADR-005: Autenticación y Autorización

| **Campo** | **Valor** |
| --- | --- |
| **ID** | ADR-005 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado con enmienda (12/10/2026): proveedor Supabase Auth |

**Contexto**

Aurora adopta autenticación OAuth para cuidadores en Aurora Care. El proveedor vigente es Supabase Auth (enmienda del 12/10/2026); Auth0 fue evaluado en los primeros sprints y quedó como alternativa descartada. Aurora Core no almacena contraseñas; sólo conserva en core.caregivers la identidad externa del cuidador mediante auth_provider y auth_subject, junto con sus datos funcionales y preferencias.

**Drivers de decisión**

1. **Cumplimiento de privacidad**: los datos de salud requieren autenticación fuerte y cifrado
2. **Multi-tenant**: cada cuidador puede estar asociado a una o más cuentas DOT, y cada cuenta DOT contiene un único paciente.
3. **Múltiples canales**: acceso desde Aurora Care (app móvil) y la API para Aurora Home
4. **Costo**: preferencia por solución gratuita o de bajo costo en etapa inicial
5. **Bajo mantenimiento**: el equipo no debe administrar infraestructura de autenticación compleja

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba (privacidad, multi-tenant, varios canales, costo y bajo mantenimiento):

- Auth0: es completo y está bien documentado; es un servicio externo más y su plan gratuito es limitado. Se evaluó en los primeros sprints y se descartó cuando se adoptó Supabase, que ya incluye autenticación (ver ADR-003).
- Autenticación propia con Django (usuarios y contraseñas locales): da control total; Aurora tendría que guardar contraseñas y resolver la recuperación de cuenta, aumentando la superficie de riesgo para datos de salud. Descartada.
- Firebase Authentication o AWS Cognito: son servicios maduros; agregan otro proveedor distinto del de datos y se integran peor con las políticas por hogar de la base. Descartadas.

**Decisión**

Se adopta OAuth 2.0 / OpenID Connect (OIDC) como mecanismo de autenticación para cuidadores, utilizando Supabase Auth como proveedor.

Aurora no gestionará contraseñas propias ni credenciales locales de cuidadores. Cada cuidador tendrá una identidad externa asociada mediante auth_provider y auth_subject, que permitirá identificarlo de forma única dentro de Aurora Core.

La autorización funcional no se delega completamente al proveedor OAuth. Aurora Core mantendrá la relación entre cuidadores y cuentas DOT mediante core.home_account_caregivers, donde cada cuidador puede estar asociado a una o más cuentas DOT con rol operativo primary o support.

**Fundamento:**

- OAuth 2.0 / OIDC es un estándar ampliamente soportado y evita acoplar el diseño a un único proveedor.
- Permite usar Supabase Auth, que cumple el estándar y permite login social (por ejemplo, Google o Apple) si se necesita.
- Evita almacenar passwords en Aurora Core, reduciendo la superficie de riesgo.
- Facilita login social y recuperación de cuenta según el proveedor elegido.
- Se alinea con el modelo de datos definido para cuidadores: auth_provider + auth_subject.
- Permite que un cuidador tenga una cuenta personal y pueda acceder a múltiples cuentas DOT asociadas.
- La separación de acceso por hogar/paciente queda bajo control de Aurora Core, no del proveedor OAuth.
- Auth0 se evaluó y se descartó: Supabase ya incluye autenticación y evita un servicio externo más (ver ADR-003). Aurora Core valida el JWT emitido por Supabase Auth (ES256/RS256, con JWKS).

**Consecuencias**

**Positivas**:

- Menor acoplamiento a un proveedor específico.
- Mayor flexibilidad para cambiar de proveedor si el costo, el alcance o las condiciones cambian.
- No se almacenan credenciales sensibles de cuidadores en la base de datos de Aurora.
- El modelo soporta múltiples cuidadores por cuenta DOT y un cuidador asociado a varias cuentas DOT.
- La autorización de negocio queda representada explícitamente en la base de datos mediante home_account_caregivers.

**Negativas:**

- OAuth/OIDC resuelve autenticación, pero no reemplaza la autorización propia de Aurora.
- Se deben implementar validaciones en backend para asegurar que cada cuidador solo acceda a cuentas DOT asociadas.
- La trazabilidad de acceso debe complementarse con logs propios de Aurora (audit_logs, data_access_logs).
- Cambiar de proveedor puede requerir migrar o reconciliar identidades externas.
- Dependencia de un proveedor externo para la identidad: si Supabase Auth cambia sus condiciones, habría que migrar las identidades externas (auth_provider y auth_subject).

### ADR-006: Procesamiento de Voz — STT local en Raspberry Pi (reemplazado por ADR-011)

| **Campo** | **Valor** |
| --- | --- |
| **ID** | ADR-006 |
| **Fecha** | Mayo 2026 |
| **Estado** | Reemplazado por ADR-011 (12/10/2026) |

**Nota del 12/10/2026:** esta decisión fue reemplazada por el ADR-011. La decisión vigente es usar Azure Speech en la nube (reconocimiento continuo y síntesis) como principal, solo durante las ventanas de escucha abiertas por un recordatorio o una actividad, y mantener Whisper.cpp y Piper locales como respaldo sin conexión. El texto que sigue se conserva como registro histórico de la decisión original.

**Contexto**

Aurora Home (Raspberry Pi) captura audio del paciente para procesarlo mediante STT (Speech-to-Text) y enviar el texto transcrito a Aurora Core. La pregunta clave es dónde ocurre la transcripción: si en la nube (enviando audio crudo a una API STT externa) o localmente en la Raspberry Pi. Esta decisión impacta la latencia, la privacidad, la capacidad offline y el consumo de recursos del dispositivo.

**Drivers de decisión**

1. **Latencia**: el envío de audio a la nube agrega latencia de red + procesamiento cloud (300-800 ms)
2. **Privacidad**: el audio crudo del paciente contiene información sensible que idealmente no debería salir del hogar
3. **Modo offline**: para que Aurora Home funcione sin internet, el STT debe ejecutarse localmente
4. **Recursos de la RPi**: Whisper.cpp puede ejecutarse en RPi 4/5 con modelos pequeños (tiny/base) con latencia aceptable
5. **Ancho de banda**: enviar texto transcrito (~100 bytes) vs. audio comprimido (~10-50 KB/segundo) reduce drásticamente el uso de red

**Decisión**

Se adopta **STT local en la Raspberry Pi** con Whisper.cpp (modelo base) para la transcripción de voz del paciente.

**Fundamento:**

- La privacidad del paciente es crítica: el audio crudo nunca sale del hogar, solo se envía texto transcrito a Aurora Core
- Whisper.cpp en RPi 4/5 logra transcripción en tiempo real (200-500 ms) con el modelo base, comparable a la latencia de cloud
- El STT local es un requisito habilitante para el modo offline (ADR-008)
- Enviar texto en lugar de audio reduce el ancho de banda y la dependencia de red
- La API de Aurora Core recibe texto (no audio), simplificando el protocolo a REST + WebSocket para mensajes de texto
- Para TTS se mantiene cloud (ElevenLabs) para calidad de voz superior, con fallback a TTS offline (Piper) en modo degradado

**Consecuencias**

**Positivas:**

- Privacidad total del audio del paciente (nunca sale de la RPi)
- Latencia de transcripción predecible y sin dependencia de red
- Funcionamiento offline completo para STT (interacción vocal básica sin internet)
- Reducción de ancho de banda: texto vs. audio crudo
- Simplificación del protocolo: Aurora Home envía texto, no audio, a Aurora Core

**Negativas:**

- Whisper.cpp en RPi consume 30-60% de CPU durante la transcripción, limitando otros procesos
- La precisión del modelo base es inferior a Whisper large o Google STT, especialmente con acentos o ruido de fondo
- La RPi requiere ~1-2 GB de RAM adicional para Whisper.cpp
- Actualizaciones del modelo STT requieren descarga de archivos a la RPi
- No es posible mejorar la precisión usando modelos más grandes sin afectar la experiencia de usuario (latencia + CPU)

**Presupuesto de latencia para el pipeline de voz (baseline esperado)**

Con STT local en RPi, la cadena de procesamiento cambia:

| **Etapa** | **Latencia estimada** | **Dependencia** |
| --- | --- | --- |
| Captura de audio | <50 ms | Aurora Home (local). |
| STT local (Whisper.cpp base) | 200-500 ms | Aurora Home (RPi CPU). |
| Envío de texto transcrito a Aurora Core | <50 ms | Red local → cloud. |
| LLM + RAG (generación de respuesta) | 500-2000 ms | API cloud externa + consulta a BD. |
| TTS (Text-to-Speech) | 200-500 ms | API cloud externa. |
| Recepción + reproducción | <100 ms | Red local → Aurora Home. |
| **Total estimado (p50)** | **~1.0-3.2 segundos** | - |

**Objetivo de diseño:** p95 por debajo de 3.5 segundos para respuestas conversacionales simples. Para respuestas que requieren RAG completo, se acepta hasta 5.5 segundos.

**Implicaciones:**

- Whisper.cpp debe ejecutarse con prioridad ajustable para no bloquear otros procesos de Aurora Home
- Si la CPU de la RPi no da abasto, considerar: (a) modelo smaller (tiny en lugar de base), (b) offloading a GPU (si hay acelerador), (c) STT híbrido con fallback a cloud selectivo
- Pipeline de voz completamente offline es posible (STT local + TTS Piper + LLM local) para operación degradada total

### ADR-007: Despliegue e Infraestructura

| Campo | Valor |
| --- | --- |
| ID | ADR-007 |
| Fecha | Mayo 2026 |
| Estado | Aceptado con enmienda (12/10/2026) |

**Contexto**

El sistema Aurora debe desplegarse inicialmente con costos mínimos (un VPS de bajo costo y servicios gestionados con plan gratuito) pero con la capacidad de migrar a infraestructura escalable de pago según evolucione. El despliegue debe ser reproducible y automatizado.

**Drivers de decisión**

1. **Costo mínimo** en etapa de prototipo y validación
2. **Reproducibilidad** (infraestructura como código)
3. **Migración viable a otra infraestructura (alternativa futura) si los costos superan el presupuesto**
4. **Actualizaciones remotas** de Aurora Home (Raspberry Pi) sin intervención física
5. **Monitoreo** básico para detectar caídas del servicio

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba (costo mínimo, reproducibilidad, migración posible, actualizaciones remotas y monitoreo básico):

- AWS (instancias, base y almacenamiento propios): escala y se gestiona mejor; su costo mensual supera el presupuesto del proyecto y exige más configuración. Queda como alternativa futura.
- Plataforma como servicio (Render): el despliegue es simple y tiene plan gratuito; tiene límites de recursos y de procesos de larga duración como WebSocket. Se usó al principio para el entorno de desarrollo (AURA-92) antes de pasar al VPS.
- Servidor propio en el hogar del paciente (on-premise): no tiene costo mensual y los datos quedan en el domicilio; depende de la conexión y la energía del hogar y de que alguien lo administre. Descartada por ahora.

**Decisión**

Se adopta un despliegue en un VPS de Hostinger con Docker Compose y Traefik, más servicios gestionados:

- **Aurora Core (API + workers)** → VPS Hostinger con Docker Compose y Traefik (TLS con Let's Encrypt). Dos entornos en el mismo VPS: staging y producción.
- **Base de datos y autenticación** → Supabase (PostgreSQL 16 + pgvector, Supabase Auth y Storage compatible con S3), región us-east-1.
- **Redis** → Redis 7 en el backend (VPS) para caché y pub-sub entre servicios. Aurora Home no usa Redis: guarda su cola local en SQLite.
- **Aurora Care (frontend)** → builds Android/iOS (los de staging, mediante EAS).
- **n8n** → Misma instancia VPS que Aurora Core.
- **Aurora Home** → Raspberry Pi 5 en el hogar del paciente.
- **Voz en la nube** → Azure Speech (región eastus), con respaldo local en Aurora Home (ver ADR-011).
- **AWS** → No se despliegan recursos propios de AWS. Queda como alternativa futura si el VPS no alcanza.
- **Dominio** → Namecheap/Hostinger (costo mínimo)
- **CI/CD** → GitHub Actions (Free Tier: 2000 min/mes para repos privados)

**Plan de migración:**

- Todo el stack empaquetado en Docker Compose desde el inicio, permitiendo migrar entre proveedores (por ejemplo, AWS u on-premise, como alternativas futuras) sin cambios de código
- n8n permite configurar flujos sin cambiar código
- Aurora Home mantiene su cola de eventos offline en SQLite local; Redis existe solo en el backend.

**Consecuencias**

**Positivas:**

- Costo inicial bajo: VPS Hostinger + servicios gestionados con plan gratuito (Supabase)
- SQLite en la Raspberry Pi mantiene la cola offline sin depender de un servicio adicional ni de Redis.
- Sin depender de un solo proveedor cloud: Docker Compose permite migrar a otro proveedor (por ejemplo, AWS u on-premise) si hiciera falta
- GitHub Actions automatiza pruebas y despliegue sin costo adicional
- Aurora Home con actualización OTA via `git pull` o Docker pull

**Negativas:**

- Hostinger VPS tiene recursos limitados comparado con AWS; puede requerir migrar a AWS si la carga crece
- Staging y producción comparten el mismo VPS: una falla del servidor afecta a ambos entornos.
- La administración del VPS (actualizaciones OS, seguridad) es responsabilidad del equipo, no gestionado
- La alternativa on-premise (futura) requeriría que el cuidador tenga internet estable y conocimientos básicos para reiniciar el sistema si falla
- La migración entre proveedores cloud requiere sincronización de datos (backup/restore de PostgreSQL)

### ADR-008: Modo Offline y Operación Degradada

| **Campo** | **Valor** |
| --- | --- |
| **ID** | ADR-008 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado con enmienda (12/10/2026) |

**Contexto**

Aurora Home (el asistente de voz en el hogar del paciente) depende de conectividad a internet para funciones críticas: transcripción STT, generación de respuestas LLM, síntesis TTS, y comunicación con Aurora Core. Dado que no se puede garantizar conectividad continua en un entorno doméstico (cortes de ISP, reinicio de router, mantenimiento), el sistema debe definir una estrategia de operación degradada que mantenga funcionalidades esenciales.

**Drivers de decisión**

1. **Seguridad del paciente**: recordatorios de medicación y alertas de emergencia no deben depender de conectividad cloud.
2. **Experiencia de usuario**: la interacción por voz no debe fallar abruptamente; debe degradarse gradualmente.
3. **Autonomía del dispositivo**: la batería y recursos de la Raspberry Pi limitan qué puede ejecutarse localmente.
4. **Recuperación automática**: al restaurar la conectividad, el sistema debe sincronizar datos sin intervención manual.

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba (seguridad del paciente, experiencia de usuario, recursos de la Raspberry Pi y recuperación automática):

- Todo en la nube, sin modo offline: es lo más simple; los recordatorios de medicación dependerían de internet, lo que no es aceptable para la seguridad del paciente. Descartada.
- Operación 100 % local (reconocimiento y síntesis de voz y modelo de lenguaje en la Raspberry Pi): funciona sin internet y con privacidad total; la placa no alcanza la calidad ni la latencia necesarias para una conversación fluida (ver ADR-011). Descartada como modo principal; se conserva para la operación degradada.
- Alarmas locales fijas, sin cola de eventos: los recordatorios suenan igual sin conexión; las respuestas del paciente y las omisiones no llegan al cuidador al volver la conexión. Descartada.

**Decisión**

Se adopta el modo **degradado híbrido** con la siguiente estrategia:

- **En línea (conectividad normal):** STT y TTS en la nube (Azure Speech) y LLM en la nube (a través de Aurora Core y el Worker IA). Aurora Home envía el texto transcrito a Aurora Core.
- **Sin conectividad (degradado):**
  - **Recordatorios programados** se ejecutan localmente desde un archivo de configuración con horarios cacheados (sincronizado desde Aurora Core cuando hay conexión)
  - **Interacción por voz básica:** STT local (Whisper.cpp) + TTS offline (Piper TTS) para respuestas predefinidas ("Lo siento, no tengo conexión", "Es hora de tu medicación"). LLM offline con modelo pequeño (opcional)
  - **El audio del paciente** se transcribe localmente y las transcripciones se almacenan para su envío posterior cuando la conexión se restablezca
  - **Alertas y eventos críticos (por ejemplo, un recordatorio sin respuesta)** se almacenan localmente y se reenvían al restaurar la conexión; no se pierden
- **Reconexión automática:** Al detectar conectividad, Aurora Home sincroniza eventos almacenados, descarga actualizaciones de configuración, y reanuda la operación completa. Implementar con **retry exponencial** y health check periódico.

**Consecuencias**

**Positivas:**

- Recordatorios de medicación y rutinas críticas nunca se pierden, incluso sin internet
- El paciente no experimenta una falla total del sistema ante cortes de conectividad
- Los eventos críticos tienen una cola local en SQLite que garantiza su entrega diferida
- La sincronización automática elimina la necesidad de intervención del cuidador en cortes de red

**Negativas:**

- La interacción conversacional rica (charla, reminiscencia, actividades cognitivas) no está disponible offline
- Aurora Home necesita almacenamiento persistente local (SQLite en la tarjeta SD) para la cola de eventos
- El TTS offline tiene calidad de voz inferior a los servicios cloud
- La RPi debe ejecutar un cron local o scheduler para recordatorios offline, agregando complejidad al firmware
- La gestión de la cola local requiere políticas de descarte cuando se llena durante cortes prolongados

### ADR-009: Protocolo de Comunicación IoT — Aurora Band

| Campo | Valor |
| --- | --- |
| ID | ADR-009 |
| Fecha | Mayo 2026 |
| Estado | Aceptado, sin implementar (fuera del MVP desde el 29/08/2026) |

**Contexto**

Aurora Band (pulsera IoT) debe enviar datos biométricos (frecuencia cardíaca, IMU, GPS, EDA, temperatura) al Aurora Band Gateway en la nube. La comunicación debe ser confiable, de bajo consumo energético (la pulsera funciona con batería), y capaz de manejar desconexiones intermitentes. El diagrama de contenedores muestra "API REST / MQTT" como opciones tentativas sin decisión registrada.

**Drivers de decisión**

- **Bajo consumo energético**: la transmisión de datos es el mayor consumo en dispositivos IoT con batería
- **Confiabilidad en entrega**: los datos biométricos (especialmente eventos de caída) no deben perderse
- **Desconexiones frecuentes**: la pulsera puede salir del alcance del gateway o perder conectividad Bluetooth
- **Volumen de datos**: envío periódico de lecturas biométricas (cada 1-5 minutos) más eventos esporádicos
- **Simplicidad del firmware**: el hardware de la pulsera tiene recursos limitados

**Decisión**

Se adopta **API REST (HTTP)** como protocolo de comunicación entre Aurora Band y Aurora Band Gateway.

**Fundamento**:

- **Simplicidad del firmware**: la pulsera IoT tiene recursos limitados; un cliente HTTP es más simple y liviano que un cliente MQTT completo
- **Frecuencia de envío baja**: datos biométricos cada 1-5 minutos más eventos esporádicos — no justifica una conexión persistente MQTT
- **Batería**: REST con conexión HTTP corta (send-and-forget) consume menos energía que mantener una conexión TCP persistente para envíos tan espaciados
- **Integración nativa**: Django REST Framework procesa los endpoints HTTP sin necesidad de un broker MQTT adicional
- **Compatibilidad con modo offline**: la pulsera acumula datos localmente y los envía como batch REST cuando hay conectividad
- **Menor infraestructura**: no requiere broker MQTT, simplificando el despliegue y monitoreo

**Nota:** Para eventos críticos (detección de caídas) donde la latencia importa, se puede establecer una conexión WebSocket bajo demanda como complemento a REST.

**Consecuencias**

**Positivas:**

- Firmware más simple y testeable (HTTP es ubicuo, librerías maduras en C/C++ para IoT)
- Sin broker MQTT que administrar (una pieza menos de infraestructura)
- Compatible con REST estándar de Django (DRF viewsets, serializers, auth JWT)
- Buffer de datos offline simple: almacenar en JSON local y enviar como batch HTTP cuando hay conexión
- Debugging sencillo con herramientas HTTP estándar (curl, Postman, logs de Django)

**Negativas:**

- Mayor consumo energético por envío individual que MQTT (handshake TCP + headers HTTP por cada request), aunque mitigado por la baja frecuencia de envío
- Sin QoS nativo: necesita retry manual en el firmware si la request falla
- Mayor latencia por envío que MQTT persistente (handshake TCP overhead)
- Headers HTTP más verbosos que el binario MQTT, aunque el payload biométrico es pequeño
- Si la frecuencia de envío aumenta a segundos (no minutos), MQTT sería más eficiente

### ADR-010: Cifrado de Datos Personales Identificatorios (PII)

| Campo | Valor |
| --- | --- |
| ID | ADR-010 |
| Fecha | Agosto 2026 |
| Estado | Aceptado |
| Decisores | Equipo Aurora |

**Contexto**

Aurora guarda datos de salud de pacientes con Alzheimer (FAST ≤5). La Ley 25.326 exige proteger los datos personales identificativos (nombre y DNI), y el cifrado debe ser verificable y auditable. La base de datos es Supabase Cloud (PostgreSQL 16).

**Drivers de decisión**

- Cumplimiento normativo (Ley 25.326).
- Cifrado en la aplicación: la clave no viaja a la base de datos ni queda en los registros de consultas.
- Portabilidad: sin depender de extensiones de PostgreSQL.
- Rotación de claves sin migraciones de base de datos.
- Transparencia para el ORM: los serializers y la lógica de negocio reciben y devuelven texto plano.

**Alternativas consideradas**

- pgcrypto (extensión de PostgreSQL, disponible en Supabase): descartada, porque cifra dentro de la base: la clave viaja en cada consulta SQL y puede quedar en los registros de consultas.
- AES-GCM sobre columnas bytea mediante pgcrypto: descartada, por la misma razón.
- Fernet (biblioteca cryptography de Python) en campos personalizados de Django: elegida.

**Decisión**

Se adopta Fernet simétrico, mediante campos personalizados de Django (EncryptedCharField y EncryptedTextField) que cifran al guardar y descifran al leer. Se cifran el nombre y el DNI del paciente, el nombre y el teléfono de los contactos de emergencia y el nombre de la cuenta del hogar.

La clave se toma de la variable de entorno FERNET_KEY; en producción es obligatoria (la aplicación no inicia sin ella). Fernet acepta una lista de claves, lo que permite rotarlas sin migrar datos.

**Consecuencias**

**Positivas:**

- Portable y testeable: no depende de extensiones de la base de datos.
- Rotación de claves sin migración.
- Transparente para los serializers y la lógica de negocio.
- Auditable: cada campo cifrado es identificable.

**Negativas:**

- No se puede buscar, filtrar ni ordenar por campos cifrados en SQL; el ordenamiento por nombre se hace en la aplicación.
- Overhead mínimo de CPU y unos 50 bytes de almacenamiento por campo.
- La búsqueda por nombre y DNI se resuelve con un hash determinístico con sal (columnas name_hash y dni_hash), implementado el 23/08/2026; el dato en claro no se guarda.
- Solo se cifran los campos identificativos listados; el resto de los datos (por ejemplo, el texto de las conversaciones) no se cifra a nivel de aplicación.

### ADR-011: Voz en la nube con respaldo local

| Campo | Valor |
| --- | --- |
| ID | ADR-011 |
| Fecha | Septiembre 2026 |
| Estado | Aceptado |
| Decisores | Equipo Aurora |

**Contexto**

El pipeline de voz 100 % local (detección de voz propia más Whisper.cpp) no alcanzó el nivel de usabilidad necesario en las pruebas en vivo con el dispositivo del 24 y 25/09/2026: el paciente tenía que acercarse al micrófono y repetir varias veces, y la palabra de activación «Aurora» fallaba más que el resto de la frase. Además, la única voz argentina disponible en Piper no cumplió el objetivo de latencia (p95 de 8,02 s medidos, contra un objetivo menor a 2 s) y sonaba menos amigable que las alternativas en la nube.

**Decisión**

Se adopta Azure Speech (nube) como proveedor principal de reconocimiento de voz (STT, en modo continuo o streaming) y de síntesis (TTS), con respaldo local sin conexión. La síntesis sigue la cadena Azure → Aurora Core → Piper (local); el reconocimiento usa Azure como principal y Whisper.cpp local como respaldo. La palabra de activación «Aurora» se detecta localmente (EfficientWord-Net), sin enviar audio. Se escucha y transmite audio solo durante las ventanas de escucha abiertas por un recordatorio o una actividad; nunca de forma ambiental ni continua.

La clasificación de la respuesta a un recordatorio (confirmó, rechazó o ninguna) usa un modelo local acotado a un vocabulario fijo (CONFIRMÓ, RECHAZO, NINGUNA); cualquier otra salida se descarta. La decisión de qué hacer con la respuesta es determinista y vive en Aurora Home, no en un modelo de lenguaje de un tercero.

**Alternativas descartadas**

- Mantener Whisper.cpp local y seguir ajustando parámetros: ya se intentó, sin resolver el problema de fondo.
- Plataformas de agente conversacional completo (por ejemplo, ElevenLabs Agents): delegan la decisión clínica de «confirmó la medicación» a un modelo de un tercero, sin auditoría.
- Azure Custom Keyword y openWakeWord para la palabra de activación: el primero no soporta español y el segundo tiene licencia no comercial.

**Consecuencias**

**Positivas:**

- Mejor reconocimiento y una voz con acento argentino natural.
- El dispositivo sigue funcionando sin conexión: Piper y Whisper.cpp locales nunca se eliminan.
- La decisión clínica sigue siendo determinista y auditable.

**Negativas y riesgos:**

- El texto de la conversación y el audio de las ventanas de escucha salen hacia un proveedor en EE. UU. (Azure, región eastus): hay que informar y obtener el consentimiento (ver Consideraciones de Privacidad).
- La credencial de Azure reside en un archivo de configuración de cada Raspberry Pi: si un dispositivo se pierde o se vulnera, la clave queda expuesta. Es deuda técnica: lo recomendable es que Aurora Core emita tokens de corta duración a cada dispositivo.
- Hoy se usa el nivel gratuito (F0), con una cuota de 500.000 caracteres mensuales en la síntesis; las condiciones pueden cambiar y, para pacientes reales, se necesita el nivel pago.
- El camino principal depende de un proveedor externo y de la conectividad.

### ADR-012: Diseño de API

| **Campo** | **Valor** |
| --- | --- |
| ID | ADR-012 |
| Fecha | Octubre 2026 (formaliza una decisión vigente desde el Sprint 2) |
| Estado | Aceptado |
| Decisores | Equipo Aurora |

**Contexto**

Aurora Core expone su API a dos tipos de clientes: la aplicación Aurora Care (React Native, usada por cuidadores autenticados) y los dispositivos Aurora Home (Raspberry Pi), que quedan instalados en los hogares y no se actualizan al mismo tiempo que el servidor. Además, Aurora Core se comunica con el Worker IA. La API debía ser fácil de consumir desde TypeScript y desde Python, tener un contrato verificable y poder evolucionar sin romper a los dispositivos ya desplegados.

**Drivers de decisión**

- Facilidad de consumo desde React Native (TypeScript) y desde Python (Aurora Home).
- Contrato documentado y verificable, que sea la fuente de verdad de los clientes.
- Evolución sin romper a los dispositivos ya instalados en los hogares.
- Autenticación diferenciada: cuidadores (identidad de Supabase) y dispositivos (credencial propia).
- Curva de aprendizaje baja y herramientas maduras en Django.
- Tiempo real para enviar comandos a Aurora Home.

**Alternativas consideradas**

Se compararon las opciones siguientes con los drivers de decisión de arriba:

- GraphQL: permite pedir solo los campos necesarios y reduce los pedidos de las pantallas; agrega complejidad (esquema, resolvers y control de acceso por campo y por hogar), el equipo no lo conocía y la caché y la auditoría por endpoint son más difíciles. Descartada.
- gRPC: es eficiente y tiene contrato tipado; tiene poca compatibilidad directa con React Native y Expo, y es más difícil de depurar en la Raspberry Pi. Descartada.
- REST sin versionado ni contrato formal: es lo más rápido al principio; un cambio en el servidor puede romper a los dispositivos instalados y la documentación se desactualiza. Descartada.
- Solo WebSocket: es bueno para tiempo real; no ofrece semántica de recursos ni caché y complica la autenticación y las pruebas. Se usa únicamente como complemento para los comandos hacia Aurora Home.

**Decisión**

Se adopta una API REST sobre HTTPS con JSON, implementada con Django REST Framework, y un canal WebSocket (Django Channels) para los comandos hacia Aurora Home.

- Versionado por ruta: los recursos cuelgan de /api/v1/ y se agrupan por dominio (pacientes, cuidadores, rutinas, eventos, alertas, interacciones, IA, cumplimiento y privacidad, entre otros).
- Contrato: la especificación OpenAPI 3.0 se genera desde el código con drf-spectacular y se publica en el repositorio (api-openapi.yaml). Es la fuente de verdad de Aurora Care y de Aurora Home.
- Autenticación: los cuidadores envían el token JWT emitido por Supabase Auth en el encabezado Authorization (Bearer). Los dispositivos Aurora Home usan una API key propia (X-Device-API-Key), que se entrega una sola vez al activarlos, después de un pairing con un secreto efímero y una clave de fábrica.
- Formato: listas paginadas (20 elementos por defecto, máximo 100), filtros y orden por parámetros de la URL, y un sobre de error único con código, mensaje y detalle.
- Compatibilidad: un chequeo del CI compara el contrato de la rama contra el de la rama base y falla ante los cambios que romperían a los dispositivos desplegados (quitar respuestas u operaciones, o cambiar la autenticación). Agregar campos u operaciones es compatible y no exige una versión nueva.

**Consecuencias**

Positivas:

- Cualquier cliente (TypeScript o Python) consume la API sin librerías especiales.
- El contrato se genera a través del código, por lo que no se desactualiza, y se verifica en el CI.
- Los dispositivos instalados siguen funcionando mientras se respete la compatibilidad de /api/v1/.
- Las credenciales separadas limitan el daño si se compromete una (la de un cuidador o la de un dispositivo).

Negativas (trade-offs):

- Las pantallas pueden necesitar varios pedidos y recibir más datos de los que usan.
- Mantener /api/v1/ mientras haya dispositivos instalados limita los cambios incompatibles; un cambio grande exigirá publicar una versión v2 en paralelo.
- Hay dos protocolos (REST y WebSocket) para operar y probar.
- La API key de cada dispositivo es una credencial más que proteger; su rotación y revocación tienen un proceso propio (AURA-130).
- El chequeo de compatibilidad cubre solo la superficie de Aurora Home; la de Aurora Care depende de las pruebas.

## 4. Pautas de codificación

### 4.1 Convenciones de nomenclatura

| **Elemento** | **Convención** | **Ejemplo** |
| --- | --- | --- |
| **Archivos Python** | `snake_case` | `patient_service.py`, `event_handler.py` |
| **Clases** | `PascalCase` | `PatientService`, `AlertEvent` |
| **Funciones / métodos / variables** | `snake_case` | `get_patient_by_id()`, `create_event()` |
| **Constantes globales** | `UPPER_SNAKE_CASE` | `MAX_RETRY_COUNT`, `ALERT_CRITICAL` |
| **Directorios** | `snake_case` | `apps/patients/`, `common/` |
| **Archivos de test** | `test_*.py` | `test_patient_service.py` |
| **Migraciones de BD** | Django autogenera | `apps/patients/migrations/0001_initial.py` |

### 4.2 Estructura de directorios propuesta

El código vive en cuatro repositorios independientes, más el vault de documentación:

- **AuroraCore:** backend (Django). Aplicaciones de dominio en apps/, despliegue en deploy/ y ADR en docs/adr/.
- **AuroraCareFront:** app móvil del cuidador (React Native + Expo + TypeScript).
- **AuroraHome:** asistente de voz para la Raspberry Pi (Python, arquitectura hexagonal, SQLite).
- **Aurora-Worker-IA:** servicio de inferencia con LLM (FastAPI).
- **ObsidianAurora:** documentación (Document Hub/), diseño (Design/) y snapshot de Jira (jira/).

### 4.3 Linting y formateo

| **Herramienta** | **Propósito** | **Configuración** |
| --- | --- | --- |
| **Ruff** | Linter + formateo unificado (reemplaza flake8, isort, black, pylint) | `line-length = 100`, `select = ["E", "F", "I", "N", "W"]` |
| **pre-commit** | Git hooks | `.pre-commit-config.yaml` con hooks: `ruff`, `trailing-whitespace`, `end-of-file-fixer` |
| **mypy** | Type checking estático (opcional, recomendado) | `strict = true` |
| **Commitlint** | Validación de mensajes de commit | `conventional-changelog` (Angular convention) |

**Convención de commits:**

![Convención de commits](images/Convenci%C3%B3n%20de%20commits.png)

### 4.4 Calidad y testing

- **Unit tests**: `pytest` + `pytest-django` para backend; Jest, React Native Testing Library para frontend. Cobertura mínima: 80 % del código nuevo. Pruebas en dispositivos Android/iOS reales o emulados.
- **Integration tests**: `Django Test Client` + `APITestCase` (DRF) para endpoints de API
- **E2E**: Appium para la app móvil Aurora Care
- **GitHub Actions**: Ejecutar `pytest` + `ruff check` en cada push y P

## 5. Proceso de Despliegue y Gestión de Ambientes

### 5.1 Ambientes

| **Ambiente** | **Infraestructura** | **Propósito** | **Actualización** |
| --- | --- | --- | --- |
| **Desarrollo (dev)** | Local (Docker Compose) | Desarrollo diario, testing interno, pruebas unitarias y de integración | Manual (sin CI/CD, cada desarrollador gestiona su entorno) |
| **Staging** | VPS Hostinger (entorno de staging) | Validación de integración, pruebas con stakeholders, UAT | Automática al merge a staging |
| **Producción (prod)** | VPS Hostinger (entorno de producción) | Uso real con pacientes | Automática al merge a main (Aurora Core) |

### 5.2 Flujo CI/CD (GitHub Actions)

### 5.3 Estrategia de releases

- **Desarrollo diario** en ramas feature/*, creadas desde staging → PR a staging
- **Integración en staging** (revisión por pares y CI en verde) → despliegue automático al entorno de staging
- **Promoción** → PR de staging a main, aprobado por el Product Owner → despliegue a producción
- **Release** → tag semántico (v1.0.0) en main para marcar cada entrega
- **Hotfix** → rama hotfix/* desde main → PR a main y luego a staging

### 5.4 Monitoreo y logging

Por ahora el proyecto no cuenta con monitoreo ni logging centralizado: ninguna de las herramientas de la tabla está en uso, salvo los chequeos de salud básicos (Aurora Core expone /health/ y el contenedor del Worker IA tiene un healthcheck de Docker), sin alertas ni paneles. Las demás herramientas están previstas para una etapa posterior.

| **Herramienta** | **Propósito** | **Costo** |
| --- | --- | --- |
| **Sentry (previsto)** | Monitoreo de errores del backend (Aurora Core). La biblioteca ya está en las dependencias de producción, pero no está configurada | Free Tier: 5k eventos/mes |
| **Prometheus (previsto)** | Métricas de Aurora Home y del Worker IA | Gratuito (open source) |
| **Chequeos de salud (en uso)** | Verificación del estado de los servicios: /health/ en Aurora Core y healthcheck de Docker en el Worker IA | Incluido |
| **Loki (previsto)** | Logs de contenedores (self-hosted en el VPS) | Gratuito (open source) |
| **Grafana (previsto)** | Dashboard unificado de logs (Loki) y métricas (Prometheus) | Gratuito (open source) |
| **Uptime Kuma (previsto)** | Health checks de endpoints críticos (self-host) | Gratuito |
| **n8n (en uso)** | Monitoreo visual de los flujos de automatización | Incluido en n8n |

### 5.5 Respaldo y recuperación

- **PostgreSQL (Supabase):** por ahora no hay respaldos definidos; el plan gratuito de Supabase no los incluye. Propuesta para el piloto: un pg_dump diario programado en el VPS, cifrado y guardado fuera del servidor, con retención de 30 días y una prueba de restauración antes de usar datos reales de pacientes. Para producción, el plan pago de Supabase con respaldos diarios, ya contemplado en el OPEX. Objetivo de recuperación: pérdida máxima de 24 h y restauración en 4 h (ver Plan de Testing, 4.5).
- **Configuración n8n**: Exportada a JSON y versionada en Git (no incluye credenciales)
- **Código y assets**: Versionado en Git (GitHub); el frontend estático se regenera desde CI/CD

## 6. Consideraciones de Privacidad, Retención y Cumplimiento Normativo

### 6.1 Marco regulatorio aplicable

Dado que Aurora maneja datos sensibles de salud (medicación, rutinas, recuerdos, voz y texto de las conversaciones; los datos biométricos y de ubicación quedan para futuras versiones) de pacientes con Alzheimer, el marco aplicable al alcance actual (hogares en Argentina) es la Ley 25.326; los demás se citan solo como referencia:

| **Marco** | **Jurisdicción** | **Relevancia** |
| --- | --- | --- |
| Ley de Protección de Datos Personales (Ley 25.326) | Argentina | Marco aplicable al alcance actual. Exige consentimiento libre, expreso e informado, finalidad y calidad de los datos, y reconoce los derechos de acceso (10 días corridos), rectificación, actualización y supresión (5 días hábiles). Restringe la transferencia a países sin protección adecuada (art. 12). |
| GDPR | Unión Europea | No aplica al alcance actual (solo si hubiera titulares residentes en la UE). Se cita como referencia de buenas prácticas. |
| HIPAA | Estados Unidos | No aplica: rige en el sistema de salud de EE. UU. No se usa como argumento de cumplimiento. |
| LGPD | Brasil | No aplica al alcance actual (Brasil). Se cita como referencia. |

### 6.2 Datos que trata Aurora y adónde van

Antes de fijar plazos hay que saber por dónde circulan los datos. Con la arquitectura vigente:

| **Dato** | **Se genera en** | **Adónde llega** | **Sensibilidad** |
| --- | --- | --- | --- |
| **Voz del paciente (audio)** | Aurora Home | Azure Speech (reconocimiento en tiempo real) solo durante las ventanas de escucha abiertas por un recordatorio o una actividad; nunca de forma ambiental ni continua. Sin conexión: Whisper.cpp local. | Alta (dato de salud) |
| **Texto de lo que dice el paciente y lo que responde Aurora** | Aurora Home y Aurora Core | Aurora Core; Worker IA y su proveedor de modelos de lenguaje (Gemini de Google); Azure para la síntesis de voz. La clasificación de si el paciente confirmó un recordatorio la hace un modelo local en Aurora Home. | Alta |
| **Datos identificatorios (nombre, DNI, contactos de emergencia)** | Aurora Care | Aurora Core y Supabase, cifrados en la aplicación. | Alta |
| **Medicación, rutinas y recuerdos personales** | Aurora Care | Aurora Core y Supabase. | Alta (dato de salud) |
| **Respuestas a recordatorios, eventos y alertas** | Aurora Home y Aurora Core | Aurora Core y Supabase. | Alta |
| **Datos biométricos y de ubicación** | No aplica | No se procesan en el MVP. | Futuras versiones |

**Hallazgo a explicitar:** hoy el audio del paciente (durante las ventanas de escucha) y el texto de la conversación salen del hogar hacia proveedores externos de voz y de IA. Esto cambió respecto de la versión anterior de este documento, que decía que el reconocimiento de voz era local y que el audio crudo no salía de la Raspberry Pi. Se decidió de forma consciente y documentada (ADR-011), y el consentimiento debe informar con claridad (RF-95).

### 6.3 Política de retención con justificación

Principio: la Ley 25.326 establece que los datos no deben conservarse más tiempo del necesario para la finalidad con que se recolectaron. Cada plazo se justifica por una finalidad concreta. Los plazos son una propuesta del equipo, pendiente de validación legal.

| **Tipo de dato** | **Período** | **Justificación** |
| --- | --- | --- |
| Audio crudo del paciente | No se almacena (buffer circular de 5 minutos en el dispositivo) | Solo se necesita para transcribir en el momento; guardarlo no aporta a ninguna función del MVP. Al vencer: se sobrescribe. |
| Transcripciones de interacciones | 6 meses | Permite al cuidador revisar el historial reciente y auditar las respuestas de la IA; cubre un ciclo habitual de seguimiento con el profesional. Al vencer: se anonimiza o elimina. |
| Respuestas a recordatorios, eventos y alertas | 2 años | Es la base del historial de cumplimiento que el cuidador lleva a la consulta y la evidencia de qué ocurrió y cómo se actuó; más de 2 años no se justifica para el MVP. Al vencer: se elimina (puede conservarse un resumen estadístico anonimizado). |
| Rutinas, medicación y recuerdos del paciente | Mientras dure la relación + 90 días | Son necesarios para prestar el servicio; los 90 días posteriores permiten exportar los datos o revertir una baja por error. Al vencer: se elimina. |
| Datos identificatorios del paciente | Mientras dure la relación + 90 días | Ídem. Al vencer: se elimina. |
| Cuenta del cuidador | Mientras dure la relación + 90 días | Ídem; el piloto no tiene facturación que justifique plazos contables. Al vencer: se elimina. |
| Registro de consentimientos y revocaciones | Mientras dure la relación + 5 años | Prueba de que el tratamiento fue autorizado y de cuándo dejó de estarlo; se conserva por la prescripción general de reclamos. Es el único dato que sobrevive a la baja. Al vencer: se elimina. |
| Registro de accesos y de solicitudes de derechos | 2 años | Auditoría de quién accedió a datos sensibles. Al vencer: se elimina. |
| Datos biométricos y de ubicación | Futuras versiones | No se tratan en el MVP. Si se incorporan: plazos cortos y justificación propia (punto de partida: biometría 90 días, ubicación 7 días). |

**Estado de la implementación:** el backend tiene el modelo de políticas de retención y el campo de vencimiento en las interacciones, pero todavía no hay un proceso automático que depure los datos vencidos (RF-96); es trabajo pendiente.

### 6.4 Controles de privacidad (requisitos verificables)

- **Cifrado en reposo (RNF-44, RNF-46):** los datos identificatorios (nombre, DNI y contactos de emergencia) se cifran a nivel de aplicación con Fernet (ver ADR-010), y existe un procedimiento para rotar la clave sin migraciones masivas.
- **Cifrado en tránsito (RNF-45):** TLS 1.2 o superior en todas las comunicaciones externas; los endpoints rechazan HTTP plano.
- **Minimización de datos (RNF-48, RF-98):** Aurora Home no almacena audio más allá de un buffer circular de 5 minutos; el audio solo se transmite durante las ventanas de escucha; las notificaciones push no incluyen datos personales.
- **Consentimiento (RF-92, RF-93, RF-95):** el tratamiento exige un consentimiento informado, versionado y revocable (ver 6.5).
- **Derechos del titular (RF-94, RNF-49):** acceso (10 días corridos), rectificación, actualización y supresión (5 días hábiles), con registro de cada solicitud en Aurora Care.
- **Depuración (RF-96):** proceso programado que elimina o anonimiza los datos vencidos. Pendiente de implementar.
- **Registro de accesos (RF-97):** toda lectura de datos sensibles por un cuidador queda registrada (quién, qué, cuándo y motivo).
- **Separación de entornos (RNF-47):** los datos reales de pacientes no se usan en desarrollo ni en staging.
- **Proveedores de voz e IA (RNF-51):** no conservan el audio ni el texto; la configuración de cada proveedor se revisa con una lista de control en cada cambio.
- **Credencial del proveedor de voz (RNF-52):** no debe quedar expuesta en los dispositivos. Estado actual: no cumple, porque la clave está en el archivo de entorno de la Raspberry Pi; se corregiría emitiendo tokens de corta duración desde Aurora Core.
- **Anonimización (RNF-50):** ningún dato de pacientes se usa para entrenar o ajustar modelos sin consentimiento específico y sin eliminar identificadores; por defecto, no se usa.

### 6.5 Consentimiento: quién lo da, cómo se registra y qué pasa al revocar

La Ley 25.326 exige el consentimiento libre, expreso e informado del titular del dato. En Aurora el titular es una persona con deterioro cognitivo, lo que plantea una cuestión de capacidad: la persona se presume capaz, y un familiar no tiene representación sin una designación judicial. La siguiente es una propuesta del equipo, pendiente de validación legal.

| **Situación** | **Quién otorga y revoca** | **Quién lo registra** |
| --- | --- | --- |
| **El paciente conserva capacidad para decidir** | El propio paciente, con ayuda del cuidador principal. | El cuidador principal en Aurora Care, dejando constancia de que el titular fue informado. |
| **Hay una sentencia que restringe su capacidad** | El paciente con su apoyo, o su curador, según lo que diga la sentencia. | El cuidador principal, indicando el vínculo con el paciente. |
| **Un cuidador de apoyo** | No puede otorgar ni revocar. | No aplica. |

Hoy el sistema registra la aceptación desde Aurora Care, a cargo del cuidador que da de alta al paciente. Falta registrar si el consentimiento lo otorga el paciente o su representante, y el vínculo del representante: es un campo nuevo a agregar.

**Cómo se registra:** cada consentimiento queda como un registro con el paciente, el tipo, la versión de la política aceptada, el alcance, la fecha de aceptación, la fecha de revocación, el vencimiento y el cuidador que lo registró. Se usan tres consentimientos separados: tratamiento de datos de salud, transferencia internacional y datos del cuidador. Repetir la misma aceptación no duplica el registro; una versión nueva de la política exige una nueva aceptación.

**Qué pasa al revocar:**

| **Momento** | **Efecto** |
| --- | --- |
| **Inmediato (hasta 24 horas)** | Aurora Home deja de capturar y enviar voz. Aurora Core deja de procesar datos con IA y de enviar recordatorios. Se suspenden las notificaciones. |
| **Dentro de los 90 días** | El cuidador principal puede exportar todos los datos del paciente. |
| **A los 90 días** | Se eliminan los datos del paciente: identificatorios, medicación, rutinas, recuerdos, transcripciones, respuestas, eventos y alertas. |
| **Se conserva** | El registro de consentimientos y revocaciones (5 años) y el registro de accesos y solicitudes (2 años), sin los datos del paciente. |
| **Excepción** | Si una obligación legal exige conservar un dato, se conserva solo ese dato y se documenta el motivo. |

La revocación no afecta la validez del tratamiento realizado antes de revocar.

### 6.6 Voz en la nube y transferencia internacional de datos

Aurora usa Azure Speech (región eastus, en Estados Unidos) para el reconocimiento y la síntesis de voz (ADR-011). La decisión se tomó con mediciones: la solución local no alcanzó la latencia ni la calidad que necesita un paciente con Alzheimer, y se prefirió un producto usable, acotado de la siguiente forma:

- **Qué sale del hogar:** el audio solo durante las ventanas de escucha abiertas por un recordatorio o una actividad (nunca de forma ambiental ni continua) y el texto de la conversación, que llega a Aurora Core, al Worker IA y a su proveedor de modelos de lenguaje (Gemini de Google).
- **Qué se queda en el hogar:** la palabra de activación «Aurora» y la clasificación de si el paciente confirmó un recordatorio (CONFIRMO, RECHAZO o NINGUNA), que se hacen localmente. Whisper.cpp y Piper siguen disponibles como respaldo sin conexión.
- **Qué dice el proveedor:** según la documentación oficial de Microsoft, en el reconocimiento y la síntesis en tiempo real el audio y el texto no se almacenan; las excepciones son el registro (si se activa), el procesamiento por lotes y las voces personalizadas. Microsoft aclara que la responsabilidad legal es de quien implementa el servicio.
- **Base legal de la transferencia (Ley 25.326, art. 12):** los datos viajan a un tercer país, por lo que se apoya en el consentimiento informado y expreso, que nombra a cada proveedor y su ubicación (RF-95). El equipo decidió mantener las regiones en Estados Unidos (Supabase us-east-1, Hostinger en Boston y Azure eastus) y dejarlo asentado en la política de privacidad y en el consentimiento de transferencia. Si el consentimiento alcanza por sí solo o hace falta además un contrato (cláusulas modelo de la autoridad de aplicación) queda pendiente de validación legal.
- **Normas que no aplican:** HIPAA y GDPR no se usan como argumento de legalidad; el marco que corresponde es la Ley 25.326.
- **Lista de control de RNF-51:** sin transcripción por lotes ni voces personalizadas (cumple); respaldo local sin conexión (cumple); región documentada, con análisis legal pendiente; nivel gratuito (F0) no apto para pacientes reales (pendiente); credencial en cada dispositivo (no cumple); consentimiento que informa la transferencia (pendiente de implementar); sin registro de solicitudes (la cuenta de Azure Speech no tiene configuraciones de diagnóstico definidas, verificado en el portal de Azure el 16/10/2026) y sin diarización (el código de Aurora Home no la solicita) (cumple).

### 6.7 Trazabilidad: requisito, diseño y prueba

| **Requisito** | **Decisión de arquitectura** | **Prueba** |
| --- | --- | --- |
| **RF-92 y RF-93 (consentimiento)** | Registro de consentimiento versionado en Aurora Core | Pruebas de API y E2E de alta y revocación |
| **RF-94 (derechos del titular)** | Registro de solicitudes de datos | Pruebas de API |
| **RF-96 (depuración)** | Proceso programado (pendiente de implementar) | Prueba con fechas simuladas |
| **RNF-44 y RNF-46 (cifrado y rotación de claves)** | ADR-010 (Fernet) | Prueba automática sobre la base y prueba de rotación |
| **RNF-45 (cifrado en tránsito)** | TLS en el proxy inverso (Traefik) | Prueba de configuración |
| **RF-98 (notificaciones)** | Contenido genérico en Expo Push | Prueba de contenido de las notificaciones |
| **RNF-48 (minimización)** | Buffer circular en Aurora Home | Prueba en dispositivo |

Estos requisitos entran al Plan de Testing como casos de criticidad P1 cuando su falla implique una brecha de seguridad.

## Documentos relacionados
- [[Requerimientos]]
- [[Boceto de Arquitectura]]
- [[Diseño del Prototipo]]
- [[Índice Aurora]]
