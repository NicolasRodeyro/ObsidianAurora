---
base: "[[Document Hub.base]]"
Created time: 2026-05-25T20:39:00
Last edited by: Octavio Escudero
Created by: Octavio Escudero
Category:
  - Documentación Interna
Last updated time: 2026-05-25T20:43:00
---
## 1. Introducción y Propósito

### 1.1 Objetivo del documento

Este documento registra las decisiones técnicas fundacionales del sistema Aurora, su arquitectura de solución y las pautas de desarrollo que guiarán la construcción del sistema. Su propósito es servir como referencia compartida para el equipo durante el desarrollo y para futuros mantenedores del sistema.

### 1.2 Audiencia

- Equipo de desarrollo (ingenieros de software, integradores IoT)
- Director del proyecto
- Futuros mantenedores y contribuyentes

### 1.3 Sistema en alcance

Aurora es un ecosistema de acompañamiento y monitoreo para personas con Alzheimer u otros trastornos de memoria que residen en su hogar. Se compone de cuatro subsistemas principales:

| Componente | Descripción |
|---|---|
| **Aurora Home** | Asistente de voz que interactúa proactivamente con el paciente |
| **Aurora Band** | Pulsera IoT para monitoreo biométrico continuo |
| **Aurora Care** | Aplicación para cuidadores (monitoreo, alertas, configuración) |
| **Aurora Core** | Núcleo de orquestación, automatización, análisis e IA |

### 1.4 Convenciones del documento

- Los diagramas utilizan la notación **C4 Model** (Contexto, Contenedores, Despliegue) con sintaxis **Mermaid**
- Las decisiones arquitectónicas significativas se registran como **Architecture Decision Records (ADRs)** en la sección 3
- Cada ADR incluye: contexto, alternativas consideradas, criterios de comparación, decisión tomada y consecuencias (incluyendo trade-offs negativos)

---

## 2. Arquitectura de Solución — Modelo C4

### 2.1 Contexto (Nivel 1)

El diagrama de contexto muestra a Aurora como un sistema que interactúa con el paciente (por voz), el cuidador (a través de Aurora Care) y diversos sistemas externos para brindar sus funcionalidades.

```mermaid
flowchart TB

    patient(["👤 Paciente<br/>Persona con Alzheimer<br/>Interactúa por voz"])
    caregiver(["👩‍⚕️ Cuidador<br/>Familiar o profesional<br/>Monitorea y configura"])

    aurora["🌐 Sistema Aurora<br/>Ecosistema de acompañamiento<br/>Monitoreo e interacción inteligente"]

    subgraph ext_ai["IA & Voz"]
        direction TB
        llm(["🤖 Proveedor LLM - OpenAI / Anthropic / Local"])
        tts(["🔊 Servicio TTS - ElevenLabs / API cloud"])
    end

    subgraph ext_notif["Notificaciones"]
        direction TB
        email(["✉️ Email SMTP"])
        telephony(["📞 API Telefonía - Twilio / VoIP"])
        messaging(["💬 Mensajería - WhatsApp / Telegram"])
    end

    patient -->|"Audio bidireccional"| aurora
    caregiver -->|"Monitorea, configura, alertas"| aurora

    aurora -->|"Genera respuestas"| llm
    aurora -->|"Sintetiza texto a voz"| tts
    aurora -->|"Reportes y notificaciones"| email
    aurora -->|"Llamadas de emergencia"| telephony
    aurora -->|"Notificaciones push"| messaging
```

#### Actores del sistema

| Actor        | Descripción                                                                                                                                   |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **Paciente** | Persona con Alzheimer o pérdida de memoria. Interactúa exclusivamente por voz con Aurora Home. No requiere habilidades técnicas.              |
| **Cuidador** | Familiar o profesional que supervisa al paciente. Utiliza Aurora Care (app web/mobile) para monitorear, configurar rutinas y recibir alertas. |

#### Sistemas externos

| Sistema                     | Propósito                                                                                |
| --------------------------- | ---------------------------------------------------------------------------------------- |
| **Proveedor LLM**           | Generación de respuestas conversacionales, inferencia emocional, adaptación de contenido |
| **TTS**                     | Síntesis de voz natural para respuestas del asistente (p.ej., ElevenLabs, AWS Polly)     |
| **WhatsApp / Telegram API** | Canales de notificación alternativos al cuidador                                         |
| **API de Telefonía**        | Llamada automática de emergencia cuando la alerta escala                                 |
| **Email SMTP**              | Notificaciones por correo electrónico (reportes diarios/semanales)                       |

---

### 2.2 Contenedores (Nivel 2)

El diagrama de contenedores descompone el sistema en sus unidades desplegables y muestra las relaciones entre ellas.

```mermaid
flowchart TB

    patient(["👤 Paciente"])
    caregiver(["👩‍⚕️ Cuidador"])

    subgraph aurora["Sistema Aurora"]
        direction TB

        subgraph iot["IoT / Dispositivos"]
            direction TB
            aurora_home["Aurora Home<br/>Raspberry Pi - STT local · TTS · Audio"]
            aurora_band["Aurora Band Gateway<br/>Python / DRF - Ingesta biométrica"]
        end

        subgraph core["Backend"]
            direction TB
            aurora_core["Aurora Core<br/>Python / Django + DRF<br/>API REST + WebSocket"]
            worker_ia["Worker IA<br/>Python / FastAPI<br/>LLM + RAG"]
            n8n["Orquestador n8n<br/>Workflow automation"]
        end

        subgraph data["Datos"]
            direction TB
            supabase[("Supabase<br/>PostgreSQL + pgvector")]
            redis[("Redis<br/>Cache + Pub/Sub")]
        end

        aurora_care["Aurora Care<br/>React / Next.js 14<br/>PWA"]
    end

    subgraph ext["Servicios Externos"]
        direction TB
        llm(["LLM API"])
        tts_ext(["TTS API"])
        messaging_ext(["WhatsApp / Telegram"])
        telephony_ext(["Telefonía / Twilio"])
    end

    patient -->|"Audio"| aurora_home
    patient -->|"Bluetooth / Zigbee"| aurora_band
    caregiver -->|"HTTPS"| aurora_care

    aurora_home -->|"REST / WebSocket (texto)"| aurora_core
    aurora_home -->|"HTTPS"| tts_ext

    aurora_care -->|"HTTPS + JWT"| aurora_core

    aurora_core -->|"SQL / TCP"| supabase
    aurora_core -->|"TCP"| redis
    aurora_core -->|"HTTP / WebSocket"| worker_ia
    aurora_core -->|"Webhook / REST"| n8n
    aurora_core -->|"REST"| telephony_ext
    aurora_core -->|"REST"| messaging_ext

    worker_ia -->|"HTTPS"| llm
    worker_ia -->|"RAG — vectores"| supabase

    aurora_band -->|"REST"| aurora_core
```


#### Descripción de contenedores

| Contenedor              | Tecnología propuesta                    | Responsabilidad                                                                                               |
| ----------------------- | --------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Aurora Home**         | Raspberry Pi OS + Python + ALSA         | Captura de audio, STT local (Whisper.cpp), reproducción de respuestas, comunicación con Aurora Core, modo offline |
| **Aurora Core**         | Python / Django + DRF + Channels        | API REST/WebSocket, lógica de dominio, orquestación de módulos, autenticación JWT, gestión de eventos         |
| **Worker IA**           | Python (FastAPI)                        | Inferencia con LLM, pipeline RAG, clasificación de eventos, detección de estados                              |
| **Base de Datos**       | Supabase (PostgreSQL 16 + pgvector)     | Datos relacionales (pacientes, cuidadores, eventos, rutinas) + vectores de embeddings para RAG + Auth + Realtime |
| **Redis**               | Redis 7 (en Raspberry Pi + VPS)         | Caché local en RPi, cola de eventos offline; Redis compartido en VPS para pub-sub entre servicios             |
| **n8n**                 | n8n (self-hosted)                       | Automatización de flujos: recordatorios por horario, escalado de alertas, reglas condicionales                |
| **Aurora Care**         | React + Next.js 14 (PWA)                | Panel del cuidador responsive, notificaciones push, modo offline parcial                                      |
| **Aurora Band Gateway** | Python / Django (módulo de Aurora Core) | API REST de ingesta de datos biométricos, gestión de estado de conexión, buffer de datos offline              |

---

### 2.3 Despliegue (Nivel 3)

El diagrama de despliegue muestra cómo se distribuyen físicamente los contenedores en la infraestructura.

```mermaid
flowchart TB

    subgraph cloud["☁️ Hostinger VPS + AWS — Híbrido"]
        direction TB

        subgraph vps["VPS Hostinger — Docker Compose"]
            direction TB
            aurora_core_d["Aurora Core<br/>Python / Django"]
            n8n_d["n8n<br/>Workflow automation"]
            worker_ia_d["Worker IA<br/>Python / FastAPI"]
            aurora_band_d["Aurora Band Gateway<br/>Python / DRF"]
        end

        subgraph supabase_cloud["Supabase Cloud — Free Project"]
            direction TB
            supabase_d[("PostgreSQL + pgvector<br/>Auth + Realtime")]
        end

        subgraph s3["AWS S3 + CloudFront — Estático"]
            direction TB
            aurora_care_d["Aurora Care<br/>Next.js SSG / PWA"]
        end
    end

    subgraph home["🏠 Hogar del Paciente — Red local"]
        direction TB

        subgraph rpi["Raspberry Pi 4/5 — Raspberry Pi OS Lite"]
            aurora_home_d["Aurora Home<br/>Python + Whisper.cpp"]
            redis_rpi[("Redis local<br/>Caché + cola offline")]
        end

        subgraph band["Aurora Band — Firmware IoT"]
            aurora_band_device["Pulsera IoT<br/>PPG · IMU · GPS · EDA · Temperatura"]
        end
    end

    subgraph cg_devices["📱 Dispositivos del Cuidador"]
        direction TB
        browser["Navegador Web / PWA<br/>Chrome · Safari · Firefox"]
    end

    rpi -->|"REST / WebSocket — HTTPS/WSS (texto)"| vps
    band -->|"Datos biométricos — HTTPS REST"| vps
    browser -->|"HTTPS"| s3
    s3 -->|"Consume API — HTTPS + JWT"| vps
```


#### Estrategia de despliegue

| Ambiente | Infraestructura | Propósito |
|---|---|---|
| **Desarrollo** | Local (Docker Compose) | Desarrollo activo, testing interno, pruebas unitarias y de integración |
| **Staging** | VPS Hostinger / AWS (recursos mínimos) | Integración, pruebas E2E, validación con stakeholders |
| **Producción** | VPS Hostinger / AWS (escalable) u on-premise | Uso real con pacientes |

**Nota sobre costos:** La configuración inicial combina Hostinger VPS + AWS Free Tier:

- 1 VPS Hostinger (plan básico ~$4-8/mes) — Aurora Core, n8n, Worker IA, Aurora Band Gateway
- Supabase Free Project ($0) — Base de datos PostgreSQL + pgvector (500 MB)
- S3 + CloudFront (Free Tier 1TB/mes) — Aurora Care (frontend estático)
- Redis en Raspberry Pi ($0) — caché local y cola de eventos
- Alternativa on-premise: servidor local en el hogar del paciente con port forwarding/DuckDNS

---

## 3. Architecture Decision Records (ADRs)

---

### ADR-001: Lenguaje y Framework Backend

| Campo | Valor |
|---|---|
| **ID** | ADR-001 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |
| **Decisores** | Equipo Aurora |

#### Contexto

El backend de Aurora (Aurora Core) debe manejar múltiples responsabilidades: API REST para Aurora Care y Aurora Home, WebSocket para comunicación bidireccional en tiempo real, procesamiento de eventos, integración con n8n, y gestión de datos. El equipo no tiene una preferencia definida previamente.

#### Drivers de decisión

1. **Baja latencia** para interacciones conversacionales en tiempo real
2. **Ecosistema maduro** para integración con n8n (construido en Node.js)
3. **Facilidad de despliegue** en AWS Free Tier (Lambda, ECS, EC2)
4. **Curva de aprendizaje razonable** para el equipo
5. **Tipado estático** para reducir errores en un sistema crítico (alertas de emergencia)
6. **Rendimiento** para concurrencia moderada (~decenas de pacientes simultáneos)

#### Decisión

Se adopta **Python con Django** como lenguaje y framework backend para Aurora Core.

**Fundamento:**
- El equipo tiene experiencia sólida en Python, lo que acelera el desarrollo y reduce la curva de aprendizaje
- Django ofrece un ecosistema maduro con ORM, autenticación, admin panel y migraciones integradas
- La integración con IA/ML es nativa (Python es el lenguaje estándar del ecosistema)
- Django REST Framework (DRF) proporciona una base sólida para la API REST
- La concurrencia con Django Channels + ASGI cubre las necesidades de WebSocket
- Aunque n8n está construido en Node.js, la integración vía webhooks/REST no requiere mismo lenguaje

#### Consecuencias

**Positivas:**
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

---

### ADR-002: Framework Frontend para Aurora Care

| Campo | Valor |
|---|---|
| **ID** | ADR-002 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora Care es la aplicación que utiliza el cuidador para monitorear al paciente, configurar rutinas, recibir alertas y gestionar el sistema. Debe funcionar tanto en dispositivos móviles (notificaciones push, acceso rápido) como en computadoras de escritorio (gestión detallada).

#### Drivers de decisión

1. **Soporte mobile y desktop** con una sola base de código
2. **Notificaciones push** en tiempo real para alertas críticas
3. **Modo offline parcial** para visualizar datos sin conexión
4. **Rapidez de desarrollo** con el equipo actual
5. **SEO** no es relevante (app protegida por autenticación)
6. **Compartir tipos** con el backend TypeScript

#### Decisión

Se adopta **React + Next.js (PWA)** como framework frontend para Aurora Care.

**Fundamento:**
- Next.js con App Router proporciona una base sólida para PWA con service workers
- TypeScript compartido con el backend (Django → DRF → OpenAPI → generar tipos TS)
- Despliegue estático (SSG) en S3 + CloudFront, sin necesidad de servidor Node.js en producción
- Service Workers permiten modo offline parcial (caché de datos recientes)
- Next.js 14 tiene soporte maduro para PWA mediante `next-pwa` o `@serwist/next`

#### Consecuencias

**Positivas:**
- Una sola base de código para mobile y desktop (responsive + PWA)
- Sin servidor Node.js en producción (SSG + S3 + CloudFront → costo mínimo)
- Tipos compartidos backend ↔ frontend mediante generación OpenAPI → TypeScript
- Notificaciones push vía Service Worker + Push API
- Despliegue simple: `next build && next export` → subir a S3

**Negativas:**
- PWA no es una app nativa; ciertas APIs de hardware (bluetooth, sensores) pueden no estar disponibles
- Service Workers tienen limitaciones en iOS Safari (notificaciones push no soportadas en iOS < 16.4)
- La experiencia offline es parcial (no permite crear/modificar datos sin conexión)

---

### ADR-003: Base de Datos (Relacional y Vectorial)

| Campo | Valor |
|---|---|
| **ID** | ADR-003 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora requiere persistencia para datos relacionales (pacientes, cuidadores, eventos, rutinas, alertas, configuraciones) y datos vectoriales (embeddings para RAG — Retrieval-Augmented Generation — en el motor de IA). Se evaluaron opciones de base de datos única vs. especializadas.

#### Drivers de decisión

1. **Consistencia y confiabilidad** para datos de salud (eventos, alertas, medicación)
2. **Búsqueda vectorial** eficiente para RAG (memoria del paciente, contexto conversacional)
3. **Costo** en Free Tier / bajos recursos
4. **Simplicidad operativa** (preferible una sola base de datos)
5. **Respaldo y recuperación** ante fallas

#### Decisión

Se adopta **Supabase (PostgreSQL 16 + pgvector)** como plataforma de datos.

**Fundamento:**
- Supabase ofrece PostgreSQL gestionado con extensión pgvector incluida, eliminando la necesidad de administrar RDS
- Incluye autenticación, Realtime (WebSocket), Storage y APIs automáticas, reduciendo servicios externos
- Plan Free Project (500 MB DB, 2 GB storage, 50k MAU) es suficiente para prototipo y validación
- Al estar basado en PostgreSQL puro, no hay vendor lock-in: se puede migrar a PostgreSQL estándar en cualquier momento
- pgvector proporciona búsqueda vectorial HNSW integrada, suficiente para RAG (memoria del paciente)

#### Consecuencias

**Positivas:**
- Reducción de servicios externos: Supabase reemplaza RDS, ElastiCache (Realtime), Auth0 y S3 (storage)
- Costo inicial $0 con el Free Project de Supabase
- APIs automáticas de Supabase (REST + Realtime) agilizan el desarrollo inicial
- Migración trivial a PostgreSQL estándar si se supera el Free Tier
- Auth integrado con Row Level Security (RLS) para multi-tenant (cada cuidador ve solo sus pacientes)

**Negativas:**
- Free Project limitado a 500 MB DB, 2 proyectos simultáneos
- Supabase Realtime no es un reemplazo completo de Redis para colas/pub-sub complejos
- Dependencia parcial de un servicio externo (Supabase Cloud); la instancia self-hosted de Supabase requiere recursos adicionales
- pgvector tiene rendimiento inferior a soluciones vectoriales dedicadas (Qdrant, Pinecone) en conjuntos de datos muy grandes (>1M vectores), pero es suficiente para el volumen esperado


---

### ADR-004: Patrón Arquitectónico

| Campo | Valor |
|---|---|
| **ID** | ADR-004 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora integra múltiples subsistemas (voz, IoT, IA, automatización, notificaciones, panel web) que deben coordinarse de manera confiable. El patrón arquitectónico define cómo se estructuran y comunican estos componentes.

#### Drivers de decisión

1. **Tolerancia a fallos parciales**: una caída en la IA no debe impedir recordatorios básicos
2. **Escalabilidad selectiva**: los componentes críticos (alertas, monitoreo IoT) pueden necesitar escalar independientemente
3. **Complejidad controlada**: el equipo es pequeño y el presupuesto acotado
4. **Integración con n8n**: el orquestador de flujos existente en el diseño
5. **Evolución**: poder partir de una arquitectura simple y evolucionar hacia microservicios si es necesario

#### Decisión

Se adopta el patrón de **Microservicios** como arquitectura principal, organizados por dominio.

**Estructura propuesta:**
- **Aurora Core API** — Gateway REST + WebSocket (Django + Channels) — punto único de entrada
- **Worker IA** — Servicio Python independiente (FastAPI) para inferencia LLM + RAG
- **Aurora Band Gateway** — Servicio Node.js para ingesta de datos biométricos
- **n8n** — Orquestador de flujos separado para automatización (recordatorios, escalado de alertas)
- Comunicación síncrona vía REST/HTTP entre servicios; comunicación asíncrona vía Redis Pub/Sub para eventos en tiempo real

**Fundamento:**
- Tolerancia a fallos parciales: una caída del Worker IA no afecta los recordatorios programados ni la ingesta biométrica
- Escalabilidad selectiva: el Worker IA puede escalar independientemente si aumenta la demanda de LLM
- n8n como orquestador externo desacopla la automatización de flujos del código de dominio
- Redis Pub/Sub como backbone de eventos permite comunicación en tiempo real sin acoplar servicios
- Cada servicio puede desarrollarse en el lenguaje más adecuado (Python para IA, Node.js para IoT Gateway)

#### Consecuencias

**Positivas:**
- Aislamiento de fallos: un error en el Worker IA no bloquea el resto del sistema
- Despliegue independiente: cada servicio puede actualizarse sin afectar a los demás
- Stack heterogéneo permite usar Python para IA y Node.js para tiempo real según convenga
- n8n externaliza flujos de automatización sin necesidad de código personalizado
- Redis Pub/Sub proporciona comunicación en tiempo real desacoplada

**Negativas:**
- Mayor complejidad operativa: múltiples servicios que monitorear, desplegar y mantener
- Latencia de red entre servicios (vs. llamadas internas en un monolito)
- Consistencia eventual entre servicios: requiere manejo de estados y compensaciones
- Debugging distribuido más complejo (trazabilidad entre servicios)
- El equipo pequeño enfrenta una sobrecarga inicial de configuración (Docker Compose, redes, health checks)

---

### ADR-005: Autenticación y Autorización

| Campo | Valor |
|---|---|
| **ID** | ADR-005 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora maneja datos sensibles de salud (biométricos, ubicación, medicación, historial médico). El acceso debe estar estrictamente controlado: cada cuidador solo debe ver los datos del paciente a su cargo, y debe existir trazabilidad de quién accedió o modificó información.

#### Drivers de decisión

1. **Cumplimiento de privacidad**: los datos de salud requieren autenticación fuerte y cifrado
2. **Multi-tenant**: cada cuidador asociado a uno o más pacientes, con datos estrictamente separados
3. **Múltiples canales**: acceso desde Aurora Care (web), API para Aurora Home, y potencialmente app mobile
4. **Costo**: preferencia por solución gratuita o de bajo costo en etapa inicial
5. **Bajo mantenimiento**: el equipo no debe administrar infraestructura de autenticación compleja

#### Decisión

Se adopta **Auth0** como proveedor de autenticación y autorización.

**Fundamento:**
- Auth0 ofrece un SDK maduro para Python/Django (social-auth-app-django, django-rest-framework-simplejwt)
- Soporte nativo para multi-tenant mediante Organizations (cada cuidador asociado a un paciente)
- MFA/2FA incluido sin configuración adicional, crítico para datos de salud
- Free Tier (7k MAU) es suficiente para la etapa inicial (decenas de cuidadores)
- Cero mantenimiento de infraestructura de autenticación
- Integración con redes sociales (Google, Apple) para facilitar el registro de cuidadores

#### Consecuencias

**Positivas:**
- Implementación rápida: semanas en lugar de meses para un sistema de autenticación seguro
- MFA, social login, y recuperación de contraseña sin desarrollo interno
- Organizations de Auth0 simplifican el multi-tenant (cada organización = un paciente)
- Trazabilidad de accesos incluida (logs de autenticación)
- Políticas de contraseñas y bloqueo por intentos fallidos sin código personalizado

**Negativas:**
- Free Tier limitado a 7k MAU; al crecer, el costo escala significativamente
- Dependencia de un servicio externo: si Auth0 cae, el sistema completo queda inaccesible
- Los datos de identidad residen en Auth0 (consideraciones de privacidad/residencia de datos)
- Migrar a otro proveedor requiere cambiar todos los usuarios de identidad
- Las Organizations de Auth0 tienen limitaciones en el Free Tier (solo 2 organizaciones)

---

### ADR-006: Procesamiento de Voz — STT Local en Raspberry Pi

| Campo | Valor |
|---|---|
| **ID** | ADR-006 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora Home (Raspberry Pi) captura audio del paciente para procesarlo mediante STT (Speech-to-Text) y enviar el texto transcrito a Aurora Core. La pregunta clave es dónde ocurre la transcripción: si en la nube (enviando audio crudo a una API STT externa) o localmente en la Raspberry Pi. Esta decisión impacta la latencia, la privacidad, la capacidad offline y el consumo de recursos del dispositivo.

#### Drivers de decisión

1. **Latencia**: el envío de audio a la nube agrega latencia de red + procesamiento cloud (300-800 ms)
2. **Privacidad**: el audio crudo del paciente contiene información sensible que idealmente no debería salir del hogar
3. **Modo offline**: para que Aurora Home funcione sin internet, el STT debe ejecutarse localmente
4. **Recursos de la RPi**: Whisper.cpp puede ejecutarse en RPi 4/5 con modelos pequeños (tiny/base) con latencia aceptable
5. **Ancho de banda**: enviar texto transcrito (~100 bytes) vs. audio comprimido (~10-50 KB/segundo) reduce drásticamente el uso de red

#### Decisión

Se adopta **STT local en la Raspberry Pi** con Whisper.cpp (modelo base) para la transcripción de voz del paciente.

**Fundamento:**
- La privacidad del paciente es crítica: el audio crudo nunca sale del hogar, solo se envía texto transcrito a Aurora Core
- Whisper.cpp en RPi 4/5 logra transcripción en tiempo real (200-500 ms) con el modelo base, comparable a la latencia de cloud
- El STT local es un requisito habilitante para el modo offline (ADR-008)
- Enviar texto en lugar de audio reduce el ancho de banda y la dependencia de red
- La API de Aurora Core recibe texto (no audio), simplificando el protocolo a REST + WebSocket para mensajes de texto
- Para TTS se mantiene cloud (ElevenLabs) para calidad de voz superior, con fallback a TTS offline (Piper) en modo degradado

#### Consecuencias

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

#### Presupuesto de latencia para el pipeline de voz (baseline esperado)

Con STT local en RPi, la cadena de procesamiento cambia:

| Etapa | Latencia estimada | Dependencia |
|---|---|---|
| Captura de audio | <50 ms | Aurora Home (local) |
| STT local (Whisper.cpp base) | 200-500 ms | Aurora Home (RPi CPU) |
| Envío de texto transcrito a Aurora Core | <50 ms | Red local → cloud |
| LLM + RAG (generación de respuesta) | 500-2000 ms | API cloud externa + consulta a BD |
| TTS (Text-to-Speech) | 200-500 ms | API cloud externa |
| Recepción + reproducción | <100 ms | Red local → Aurora Home |
| **Total estimado (p50)** | **~1.0-3.2 segundos** | |

**Objetivo de diseño:** p95 por debajo de 3.5 segundos para respuestas conversacionales simples. Para respuestas que requieren RAG completo, se acepta hasta 5.5 segundos.

**Implicaciones:**
- Whisper.cpp debe ejecutarse con prioridad ajustable para no bloquear otros procesos de Aurora Home
- Si la CPU de la RPi no da abasto, considerar: (a) modelo smaller (tiny en lugar de base), (b) offloading a GPU (si hay acelerador), (c) STT híbrido con fallback a cloud selectivo
- Pipeline de voz completamente offline es posible (STT local + TTS Piper + LLM local) para operación degradada total

---

### ADR-007: Despliegue e Infraestructura

| Campo | Valor |
|---|---|
| **ID** | ADR-007 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

El sistema Aurora debe desplegarse inicialmente con costos mínimos (Free Tier AWS o alternativas gratuitas) pero con la capacidad de migrar a on-premise o a infraestructura escalable de pago según evolucione. El despliegue debe ser reproducible y automatizado.

#### Drivers de decisión

1. **Costo mínimo** en etapa de prototipo y validación
2. **Reproducibilidad** (infraestructura como código)
3. **Migración viable** a on-premise si los costos cloud superan el presupuesto
4. **Actualizaciones remotas** de Aurora Home (Raspberry Pi) sin intervención física
5. **Monitoreo** básico para detectar caídas del servicio

#### Decisión

Se adopta una estrategia **híbrida multicloud + local**:

- **Aurora Core** (API + workers) → **VPS Hostinger** (plan económico, ~$4-8/mes) con Docker Compose
- **Base de datos** → **Supabase** (PostgreSQL + pgvector, Free Project) — o **RDS PostgreSQL Free Tier** como alternativa si se supera el Free Tier de Supabase
- **Redis** → **Ejecutado en la Raspberry Pi** (Aurora Home) para caché local y cola de mensajería offline. Alternativa cloud si se necesita Redis compartido entre servicios
- **Aurora Care** (frontend) → **S3 + CloudFront** (AWS Free Tier 1TB/mes) o **Hostinger VPS** (misma instancia)
- **n8n** → Misma instancia VPS que Aurora Core
- **Aurora Home** → **Raspberry Pi 4/5** en el hogar del paciente
- **AWS Free Tier** → Uso complementario para S3/CloudFront y como respaldo si Hostinger no es suficiente
- **Dominio** → Namecheap/Hostinger (costo mínimo)
- **CI/CD** → **GitHub Actions** (Free Tier: 2000 min/mes para repos privados)

**Plan de migración:**
- Todo el stack empaquetado en Docker Compose desde el inicio, permitiendo migrar entre Hostinger, AWS o on-premise sin cambios de código
- n8n permite reconfigurar flujos sin cambiar código
- Redis en la RPi proporciona caché local y cola de eventos para operación offline; si se necesita Redis compartido, se puede añadir un contenedor Redis en el VPS

#### Consecuencias

**Positivas:**
- Costo inicial bajo: VPS Hostinger (~$4-8/mes) + Free Tier de AWS/Supabase
- Redis en la RPi reduce costos cloud y mejora la resiliencia offline (caché local siempre disponible)
- Sin depender de un solo proveedor cloud: se puede migrar entre Hostinger, AWS u on-premise
- GitHub Actions automatiza pruebas y despliegue sin costo adicional
- Aurora Home con actualización OTA via `git pull` o Docker pull

**Negativas:**
- Hostinger VPS tiene recursos limitados comparado con AWS; puede requerir migrar a AWS si la carga crece
- Redis en la RPi no está disponible para servicios cloud si la RPi está apagada o sin red (limitado a uso local)
- La administración del VPS (actualizaciones OS, seguridad) es responsabilidad del equipo, no gestionado
- On-premise requiere que el cuidador tenga internet estable y conocimientos básicos para reiniciar el sistema si falla
- La migración entre proveedores cloud requiere sincronización de datos (backup/restore de PostgreSQL)

---

### ADR-008: Modo Offline y Operación Degradada

| Campo | Valor |
|---|---|
| **ID** | ADR-008 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora Home (el asistente de voz en el hogar del paciente) depende de conectividad a internet para funciones críticas: transcripción STT, generación de respuestas LLM, síntesis TTS, y comunicación con Aurora Core. Dado que no se puede garantizar conectividad continua en un entorno doméstico (cortes de ISP, reinicio de router, mantenimiento), el sistema debe definir una estrategia de operación degradada que mantenga funcionalidades esenciales.

#### Drivers de decisión

1. **Seguridad del paciente**: recordatorios de medicación y alertas de emergencia no deben depender de conectividad cloud
2. **Experiencia de usuario**: la interacción por voz no debe fallar abruptamente; debe degradarse gracefulmente
3. **Autonomía del dispositivo**: la batería y recursos de la Raspberry Pi limitan qué puede ejecutarse localmente
4. **Recuperación automática**: al restaurarse la conectividad, el sistema debe sincronizar datos sin intervención manual

#### Decisión

Se adopta el modo **degradado híbrido** con la siguiente estrategia:

- **En línea (conectividad normal):** STT local con Whisper.cpp, TTS cloud (ElevenLabs) y LLM cloud. Aurora Home envía texto transcrito a Aurora Core.
- **Sin conectividad (degradado):**
  - **Recordatorios programados** se ejecutan localmente desde un archivo de configuración con horarios cacheados (sincronizado desde Aurora Core cuando hay conexión)
  - **Interacción por voz básica:** STT local (Whisper.cpp) + TTS offline (Piper TTS) para respuestas predefinidas ("Lo siento, no tengo conexión", "Es hora de tu medicación"). LLM offline con modelo pequeño (opcional)
  - **El audio del paciente** se transcribe localmente y las transcripciones se almacenan para su envío posterior cuando la conexión se restablezca
  - **Alertas críticas** (caídas detectadas por la pulsera) se almacenan localmente y se reenvían al restaurar la conexión; no se pierden
- **Reconexión automática:** Al detectar conectividad, Aurora Home sincroniza eventos almacenados, descarga actualizaciones de configuración, y reanuda operación completa. Implementar con **retry exponencial** y health check periódico.

#### Consecuencias

**Positivas:**
- Recordatorios de medicación y rutinas críticas nunca se pierden, incluso sin internet
- El paciente no experimenta una falla total del sistema ante cortes de conectividad
- Los eventos críticos (caídas) tienen un buffer local que garantiza su entrega diferida
- La sincronización automática elimina la necesidad de intervención del cuidador en cortes de red

**Negativas:**
- La interacción conversacional rica (charla, reminiscencia, actividades cognitivas) no está disponible offline
- Aurora Home necesita almacenamiento persistente local para buffer de audio y eventos (SD card o SSD)
- El TTS offline tiene calidad de voz inferior a los servicios cloud
- La RPi debe ejecutar un cron local o scheduler para recordatorios offline, agregando complejidad al firmware
- La gestión del buffer circular requiere políticas de descarte cuando se llena durante cortes prolongados

---

### ADR-009: Protocolo de Comunicación IoT — Aurora Band

| Campo | Valor |
|---|---|
| **ID** | ADR-009 |
| **Fecha** | Mayo 2026 |
| **Estado** | Aceptado  |

#### Contexto

Aurora Band (pulsera IoT) debe enviar datos biométricos (frecuencia cardíaca, IMU, GPS, EDA, temperatura) al Aurora Band Gateway en la nube. La comunicación debe ser confiable, de bajo consumo energético (la pulsera funciona con batería), y capaz de manejar desconexiones intermitentes. El diagrama de contenedores muestra "API REST / MQTT" como opciones tentativas sin decisión registrada.

#### Drivers de decisión

1. **Bajo consumo energético**: la transmisión de datos es el mayor consumo en dispositivos IoT con batería
2. **Confiabilidad en entrega**: los datos biométricos (especialmente eventos de caída) no deben perderse
3. **Desconexiones frecuentes**: la pulsera puede salir del alcance del gateway o perder conectividad Bluetooth
4. **Volumen de datos**: envío periódico de lecturas biométricas (cada 1-5 minutos) más eventos esporádicos
5. **Simplicidad del firmware**: el hardware de la pulsera tiene recursos limitados

#### Decisión

Se adopta **API REST (HTTP)** como protocolo de comunicación entre Aurora Band y Aurora Band Gateway.

**Fundamento:**
- **Simplicidad del firmware**: la pulsera IoT tiene recursos limitados; un cliente HTTP es más simple y liviano que un cliente MQTT completo
- **Frecuencia de envío baja**: datos biométricos cada 1-5 minutos más eventos esporádicos — no justifica una conexión persistente MQTT
- **Batería**: REST con conexión HTTP corta (send-and-forget) consume menos energía que mantener una conexión TCP persistente para envíos tan espaciados
- **Integración nativa**: Django REST Framework procesa los endpoints HTTP sin necesidad de un broker MQTT adicional
- **Compatibilidad con modo offline**: la pulsera acumula datos localmente y los envía como batch REST cuando hay conectividad
- **Menor infraestructura**: no requiere broker MQTT, simplificando el despliegue y monitoreo

**Nota:** Para eventos críticos (detección de caídas) donde la latencia importa, se puede establecer una conexión WebSocket bajo demanda como complemento a REST.

#### Consecuencias

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


---

## 4. Pautas de codificación
### 4.1 Convenciones de nomenclatura

| Elemento                        | Convención                  | Ejemplo                                  |
| ------------------------------- | --------------------------- | ---------------------------------------- |
| Archivos TypeScript/JavaScript  | `kebab-case`                | `patient-service.ts`, `event-handler.ts` |
| Clases / interfaces / tipos     | `PascalCase`                | `PatientService`, `AlertEvent`           |
| Funciones / métodos / variables | `camelCase`                 | `getPatientById()`, `createEvent()`      |
| Constantes globales             | `UPPER_SNAKE_CASE`          | `MAX_RETRY_COUNT`, `ALERT_CRITICAL`      |
| Directorios                     | `kebab-case`                | `src/modules/patient/`, `src/common/`    |
| Archivos de componentes React   | `PascalCase`                | `PatientDashboard.tsx`, `AlertCard.tsx`  |
| Archivos de test                | `*.test.ts` / `*.spec.ts`   | `patient-service.test.ts`                |
| Migraciones de BD               | `YYYYMMDDHHmmss_<desc>.sql` | `20260525120000_create_patients.sql`     |

### 4.2 Estructura de directorios propuesta

```
backend/
  src/
    modules/
      patient/
        patient.module.ts
        patient.controller.ts
        patient.service.ts
        patient.entity.ts
        dto/
        interfaces/
      event/
      alert/
      biometric/
      auth/
      caregiver/
      routine/
      medication/
      interaction/
    common/
      guards/
      filters/
      interceptors/
      pipes/
      decorators/
      utils/
    config/
    database/
      migrations/
      seeds/
    webhooks/
      n8n/
      aurora-home/
      aurora-band/
  test/
    unit/
    integration/
    e2e/
frontend/
  src/
    app/        (Next.js App Router)
      (auth)/
      dashboard/
      patient/
      alerts/
      routines/
      settings/
    components/
      ui/
      shared/
      features/
    lib/
      api/
      hooks/
      utils/
      types/
    public/
      sw.js       (Service Worker)
infra/
  docker/
    docker-compose.yml
    Dockerfile.backend
    Dockerfile.frontend
  terraform/
    main.tf
    variables.tf
  scripts/
    deploy.sh
    backup.sh
```

### 4.3 Linting y formateo

| Herramienta | Propósito | Configuración |
|---|---|---|
| **ESLint** | Análisis estático TypeScript/JavaScript | Configuración basada en `@typescript-eslint` + `eslint-plugin-nestjs` |
| **Prettier** | Formateo automático de código | `printWidth: 100`, `semi: true`, `singleQuote: true`, `trailingComma: 'all'` |
| **Husky** | Git hooks | Pre-commit: lint-staged (ESLint + Prettier) |
| **lint-staged** | Linting solo de archivos staged | `*.ts` → eslint --fix + prettier --write |
| **Commitlint** | Validación de mensajes de commit | `conventional-changelog` (Angular convention) |

**Convención de commits:**
```
<type>(<scope>): <descripciónBreve>

<descripciónCompleta>

tipos: feat, fix, refactor, test, docs, chore, style, perf
scope: patient, alerts, auth, home, band, api, infra...
ejemplo: feat(patient): agregar CRUD de perfil de paciente

	- Create para cuidadores
	- Read para cuidadores y pacientes
	- Update para cuidadores
	- Delete deshabilitar
```

### 4.4 Calidad y testing

- **Unit tests**: Jest para backend y Vitest para frontend. Cobertura mínima: 70%
- **Integration tests**: Supertest para endpoints de API
- **E2E**: Playwright para Aurora Care (web)
- **GitHub Actions**: Ejecutar tests automáticamente en cada push y PR

---

## 5. Proceso de Despliegue y Gestión de Ambientes

### 5.1 Ambientes

| Ambiente              | Infraestructura                                 | Propósito                                                              | Actualización                                              |
| --------------------- | ----------------------------------------------- | ---------------------------------------------------------------------- | ---------------------------------------------------------- |
| **Desarrollo (dev)**  | Local (Docker Compose)                          | Desarrollo diario, testing interno, pruebas unitarias y de integración | Manual (sin CI/CD, cada desarrollador gestiona su entorno) |
| **Staging**           | VPS Hostinger                                   | Validación de integración, pruebas con stakeholders, UAT               | Automática al merge a `main`                               |
| **Producción (prod)** | VPS Hostinger / AWS (pago por uso) u on-premise | Uso real con pacientes                                                 | Manual mediante GitHub Releases                            |

### 5.2 Flujo CI/CD (GitHub Actions)

```yaml
# .github/workflows/ci.yml
name: CI/CD Aurora

on:
  push:
    branches: [develop, main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm ci
      - run: npm run lint
      - run: npm run test:coverage
  
  build-and-deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Build Docker images
        run: docker compose -f infra/docker/docker-compose.yml build
      
      - name: Push to registry
        run: docker push ... (GHCR o Docker Hub)
      
      - name: Deploy to staging
        run: ... (SSH + Docker pull + restart)
      
      - name: Deploy frontend to S3
        run: ... (aws s3 sync)
```

### 5.3 Estrategia de releases

1. **Desarrollo diario** en ramas `feature/*` → PR a `develop`
2. **Integración** en `develop` (testing interno) → despliegue automático a dev
3. **Pre-release** → merge a `main` → despliegue automático a staging
4. **Release** → tag semántico (`v1.0.0`) en `main` → build de producción + deploy manual a prod
5. **Hotfix** → rama `hotfix/*` desde `main` → PR directo a `main`

### 5.4 Monitoreo y logging

| Herramienta                   | Propósito                                              | Costo                     |
| ----------------------------- | ------------------------------------------------------ | ------------------------- |
| **Loki + Prometheus**         | Logs de contenedores y métricas del sistema (self-hosted en VPS) | Gratuito (open source)    |
| **Sentry**                    | Monitoreo de errores en frontend (Aurora Care) y backend (Aurora Core) | Free Tier: 5k eventos/mes |
| **Grafana**                   | Dashboard unificado para visualizar logs (Loki) y métricas (Prometheus) | Gratuito (open source)    |
| **Uptime Kuma** (self-host)   | Health checks de endpoints críticos                    | Gratuito                  |
| **n8n**                       | Monitoreo visual de flujos de automatización           | Incluido en n8n           |

### 5.5 Respaldo y recuperación

- **PostgreSQL dump (Supabase)**: Backup vía `pg_dump` semanal, almacenado en S3 (5 GB gratis) o en el VPS
- **Configuración n8n**: Exportada a JSON y versionada en Git (no incluye credenciales)
- **Código y assets**: Versionado en Git (GitHub); el frontend estático se regenera desde CI/CD

---

## 6. Consideraciones de Privacidad, Retención y Cumplimiento Normativo

Esta sección identifica aspectos regulatorios y de privacidad que deben ser considerados en la implementación, sin pretender constituir asesoramiento legal. El equipo debe validar estos puntos con el sponsor y, de ser necesario, con asesoría legal especializada.

### 6.1 Marco regulatorio aplicable

Dado que Aurora maneja datos sensibles de salud (biométricos, ubicación, medicación, grabaciones de voz) de pacientes con Alzheimer, los siguientes marcos podrían ser relevantes según la jurisdicción:

| Marco | Jurisdicción | Relevancia |
|---|---|---|
| **Ley de Protección de Datos Personales (Ley 25.326)** | Argentina | Aplicable si el proyecto opera en Argentina. Regula el consentimiento, finalidad, y derechos ARCO (acceso, rectificación, cancelación, oposición) |
| **GDPR** | Unión Europea | Si los datos pertenecen a residentes europeos. Requiere consentimiento explícito para datos de salud, DPO, notificación de brechas |
| **HIPAA** | Estados Unidos | Si el sistema se utiliza en el contexto del sistema de salud estadounidense. Regla de privacidad y seguridad para PHI (Protected Health Information) |
| **LGDP** | Brasil | Similar a GDPR para residentes brasileños |

### 6.2 Políticas de retención de datos propuestas

| Tipo de dato                             | Período                              | Justificación                                                                       |
| ---------------------------------------- | ------------------------------------ | ----------------------------------------------------------------------------------- |
| Grabaciones de voz (audio crudo)         | 30 días, luego anonimizar o eliminar | Necesario para mejora de modelos STT y auditoría inmediata                          |
| Transcripciones de interacciones         | 6 meses                              | Trazabilidad de interacciones y mejora de respuestas LLM                            |
| Datos biométricos (HR, temperatura, EDA) | 90 días                              | Detección de tendencias y patrones de salud                                         |
| Datos de ubicación (GPS)                 | 7 días                               | Seguridad inmediata; datos históricos agregados (sin precisión) se retienen 90 días |
| Eventos y alertas                        | 2 años                               | Trazabilidad legal y médica; base para auditoría                                    |
| Configuración de rutinas y medicación    | Vigencia de la relación + 1 año      | Continuidad del servicio; respaldo post-cesación                                    |
| Datos de cuenta de cuidador              | Vigencia de la relación + 2 años     | Cumplimiento contable y legal                                                       |

### 6.3 Controles de privacidad recomendados

- **Cifrado en reposo**: Todos los datos sensibles en PostgreSQL deben cifrarse a nivel de columna (pgcrypto)
- **Cifrado en tránsito**: TLS 1.3 obligatorio para todas las comunicaciones externas
- **Minimización de datos**: Aurora Home solo debe transmitir el audio necesario para la interacción; no debe almacenar grabaciones en la RPi más allá del buffer circular de 5 minutos
- **Consentimiento**: El sistema debe registrar el consentimiento del paciente o su tutor legal para el tratamiento de datos, incluyendo alcance, finalidad y vigencia
- **Anonimización**: Los datos usados para entrenamiento o mejora de modelos IA deben ser anonimizados (eliminar identificadores directos y cuasi-identificadores)
- **Portal de derechos ARCO**: Aurora Care debe incluir una funcionalidad que permita al cuidador/tutor solicitar acceso, rectificación, cancelación u oposición sobre los datos del paciente