# Corrección 11 — Arquitectura: los ADR como fuente de verdad

> **Criterio de la profe:** controlar que las tecnologías descriptas sean **decisiones vigentes** y no alternativas abiertas. Los ADR deben ser la fuente de verdad; cuando una decisión cambia hay que actualizar los diagramas y las demás secciones, y distinguir la arquitectura actual de las alternativas futuras.
>
> **Cómo lo resuelvo:** (1) una tabla única de "arquitectura vigente" verificada contra los cuatro repositorios de código; (2) la lista exacta de ADR y secciones que hay que enmendar; (3) una regla de gobierno para que no vuelva a pasar.
>
> **Qué cambia en el Docs:** sección **Arquitectura y Stack Tecnológico Aurora**. El detalle está en la sección 3 de este archivo.

---

## 1. Arquitectura vigente (verificada contra el código, 12/10/2026)

Cada fila indica la decisión **vigente**, su fuente en los repos, y lo que el documento dice hoy.

| Tema | Decisión vigente | Evidencia en el código | Qué dice hoy el documento |
| ----- | ----- | ----- | ----- |
| **Backend (Aurora Core)** | Python 3.12 + Django + DRF + Channels, en contenedores Docker | `AuroraCore/AGENTS.md`, `Dockerfile` | ✅ Coincide |
| **Worker IA** | Servicio FastAPI independiente. Core **nunca** llama al LLM directamente: delega al Worker | `Aurora-Worker-IA/README.md` (ADR-004) | ✅ Coincide |
| **Proveedor de LLM** | Configurable por variable de entorno (API compatible con OpenAI). Por defecto `gpt-4o-mini`; Gemini como alternativa | `Aurora-Worker-IA/README.md`, `app/llm.py` | ⚠️ El documento dice "Proveedor LLM" genérico y el presupuesto "Llama 3 8B vía Groq"; la WBS dice "Gemini / Claude" |
| **Base de datos** | Supabase (PostgreSQL 16 + pgvector) | `AuroraCore/AGENTS.md` | ✅ Coincide |
| **Cifrado de datos personales** | Cifrado **a nivel de aplicación** con **Fernet** (de la biblioteca `cryptography` de Python: AES-128 en modo CBC con firma HMAC-SHA256), mediante el campo `EncryptedCharField`, por ADR-010; Supabase Cloud no permite habilitar pgcrypto | `AuroraCore/docs/adr/ADR-010-cifrado-pii.md` | ❌ El documento (6.3) dice "cifrado a nivel de columna (pgcrypto)" |
| **Autenticación** | **Supabase Auth**; Core valida el JWT (ES256/RS256 con JWKS). Sin Auth0 | `AuroraCore/README.md`, `docs/supabase-auth-setup.md` | ❌ ADR-005 y el resumen de Sprints nombran Auth0 como proveedor; el ADR-005 deja abierto "Auth0, Supabase Auth u otro" |
| **Aplicación móvil (Aurora Care)** | React Native + Expo + TypeScript; cliente `supabase-js`; notificaciones push con **Expo Push** | `AuroraCare/package.json`, `AuroraCore/apps/notifications/services.py` | ⚠️ `AuroraCare/AGENTS.md` todavía menciona Auth0 (a corregir en el repo) |
| **Caché y mensajería** | Redis 7 **en el backend** (caché + pub-sub) | `AuroraCore/docker-compose.yml` | ❌ El documento ubica Redis **en la Raspberry Pi** |
| **Almacenamiento local en Aurora Home** | **SQLite** (WAL) como línea base del MVP; no se usa Redis en la Raspberry | `AuroraHome/AGENTS.md` | ❌ Ver fila anterior |
| **Hardware de Aurora Home** | **Raspberry Pi 5** (8 GB de referencia), Debian 13 | `AuroraHome/Docs/01-contexto-arquitectura-y-hardware.md` | ❌ Dice Raspberry Pi 4 (2 GB / 4 GB) |
| **STT (voz a texto)** | **Azure Speech (nube, streaming) como principal**, solo durante las ventanas de escucha abiertas por un recordatorio o una actividad (nunca de forma ambiental ni continua); Whisper.cpp local como respaldo sin conexión. La palabra de activación "Aurora" se detecta localmente (EfficientWord-Net) | `AuroraHome/Docs/05-calidad-roadmap-y-decisiones.md` (ADR-HOME-011) | ❌ ADR-006 dice "STT local con Whisper.cpp" como decisión principal |
| **TTS (texto a voz)** | Cadena **Azure (nube) → Core → Piper (local)**; Piper es el respaldo sin conexión y nunca se elimina | ADR-HOME-010 | ❌ El documento dice "ElevenLabs, AWS Polly" |
| **Clasificación de la respuesta a un recordatorio** (¿confirmó la medicación?) | Un modelo local (Qwen3 vía llama.cpp) es el camino primario, con salida **acotada a un vocabulario fijo** (CONFIRMO / RECHAZO / NINGUNA); cualquier otra salida se descarta. La decisión de qué hacer con la respuesta es determinista y está en Aurora Home (ADR-HOME-011) | `AuroraHome/Docs/05-calidad-roadmap-y-decisiones.md` | ⚠️ No figura en el documento |
| **Orquestación** | n8n para disparar interacciones diarias; alcance acotado | `AuroraCore/apps/interactions` (comando de interacciones diarias) | ⚠️ Presentado como pieza general de orquestación; la épica AURA-21 está marcada `vision` |
| **Despliegue** | **VPS Hostinger** con Docker Compose y Traefik (TLS con Let's Encrypt). Dos entornos en el mismo VPS: `staging-api.…` y `api.…` | `AuroraCore/deploy/`, `.env.example` | ⚠️ El documento dice "Hostinger / AWS / on-premise" para staging y producción |
| **AWS** | **No se despliegan recursos propios de AWS.** (La base de Supabase está alojada en infraestructura de AWS, pero eso es del proveedor.) | `deploy/.env.example` | ⚠️ AWS figura como parte de la infraestructura (Free Tier, S3, respaldo) Verificado el 14/10/2026: `boto3` se usa solo como cliente S3-compatible de **Supabase Storage** (fotos de recuerdos y adjuntos); no hay recursos propios de AWS. |
| **Observabilidad** | Sentry (Core) y chequeos de salud; métricas en Prometheus en Home y Worker | `requirements/production.txt` | ⚠️ El documento describe Loki + Prometheus + Grafana + Uptime Kuma como pila vigente; **no encontré Loki ni Grafana en los repos** |
| **Notificaciones externas** | Solo **Expo Push** en el MVP | `apps/notifications` | ⚠️ El documento lista WhatsApp/Telegram, telefonía y SMTP como sistemas externos |
| **Aurora Band Gateway** | **No desplegado.** Fuera del MVP | Decisión del 29/08/2026 | ❌ Figura como contenedor del sistema |

---

## 2. Regla de gobierno para que no vuelva a pasar

Se agrega al comienzo de la sección 3 (ADR):

> **Gobierno de los ADR.** Cada ADR tiene un estado: **Propuesto**, **Aceptado**, **Reemplazado por ADR-N** o **Rechazado**. Solo los ADR *Aceptados* describen la arquitectura vigente. Las tecnologías que aparecen en una tabla o en un diagrama deben corresponder a un ADR aceptado; las alternativas se anotan en la sección *Alternativas futuras* de ese ADR y **nunca** en las tablas de contenedores o de despliegue. Cuando un ADR cambia de estado, se actualizan en la misma tarea los diagramas C4 y las secciones que lo mencionan. En el repositorio, cada ADR vive en `docs/adr/` junto al código que gobierna.

---

## 3. Qué cambiar en el Docs

### 3.1 Estado de cada ADR

| ADR | Estado actual propuesto | Qué enmendar |
| ----- | ----- | ----- |
| ADR-001 Backend | Aceptado | Sin cambios de fondo. En "Facilidad de despliegue en AWS Free Tier" agregar "o en VPS con Docker (solución vigente)". |
| ADR-002 Frontend | Aceptado | Sin cambios de fondo. |
| ADR-003 Base de datos | Aceptado | Sin cambios. Se confirma Supabase. |
| ADR-004 Patrón arquitectónico | Aceptado | En el texto, "Redis Pub/Sub como backbone": aclarar que el Redis es el del backend. |
| ADR-005 Autenticación | **Aceptado con enmienda** | La decisión pasa de "Auth0, Supabase Auth u otro" a **"Supabase Auth"**. Auth0 se registra como alternativa descartada. Corregir el resumen de Sprints y los textos que dicen Auth0. |
| ADR-006 Voz (STT) | **Reemplazado parcialmente** | La decisión pasa a "**STT en la nube (Azure) como principal, con Whisper.cpp local como respaldo offline**", según ADR-HOME-011. Se actualiza la sección de privacidad (ver abajo). |
| ADR-007 Despliegue | **Aceptado con enmienda** | La decisión pasa a "**VPS Hostinger con Docker Compose y Traefik**". AWS y on-premise pasan a *Alternativas futuras*. Quitar "Redis en la Raspberry". |
| ADR-008 Modo offline | **Aceptado con enmienda** | Reemplazar "STT local + TTS cloud ElevenLabs" por "**STT y TTS en la nube con respaldo local (Whisper.cpp y Piper)**"; cola local en **SQLite**, no Redis. |
| ADR-009 IoT / Aurora Band | **Diferido** | Estado: "Aceptado, sin implementar (fuera del MVP desde el 29/08/2026)". |
| **ADR-010 Cifrado de PII** (nuevo) | Aceptado | Incorporar el ADR existente en `AuroraCore/docs/adr/ADR-010-cifrado-pii.md`: cifrado a nivel de aplicación con Fernet. |
| **ADR-011 Voz en la nube con respaldo local** (nuevo) | Aceptado | Resumen de ADR-HOME-010 y ADR-HOME-011, con su consecuencia en privacidad (el texto de la conversación puede salir hacia el proveedor de voz). |

### 3.2 Secciones a corregir

| Sección del Docs | Cambio |
| ----- | ----- |
| **1.3 Sistema en alcance** | Aclarar que el alcance es el del MVP (archivo 04) y que Aurora Band no está incluido. |
| **2.1 Contexto** → *Sistemas externos* | Reemplazar la fila **TTS** por "**Servicios de voz (Azure Speech)**: reconocimiento y síntesis de voz". Marcar **WhatsApp/Telegram**, **API de Telefonía** y **Email SMTP** como "Futuras versiones". Agregar **Expo Push** (notificaciones) y **Proveedor de autenticación (Supabase Auth)**. |
| **2.2 Contenedores** | Tabla de contenedores actualizada con la sección 4 de este archivo. Quitar **Aurora Band Gateway** del diagrama (o rotularlo "No desplegado en el MVP"). Ubicar **Redis** en el backend. Cambiar la tecnología de Aurora Home a "Raspberry Pi 5 + Python (arquitectura hexagonal) + SQLite". |
| **2.3 Despliegue** (tabla y *Nota sobre costos*) | Dos entornos en el VPS Hostinger (staging y producción). Quitar "AWS Free Tier", "Redis en Raspberry Pi" y "Alternativa on-premise" de la nota de costos; esas opciones van a *Alternativas futuras*. |
| **Diagramas C4 (contexto, contenedores, despliegue)** | **Rehacer o corregir las tres figuras** con los cambios anteriores. Es lo que más va a revisar la profe. |
| **4.2 Estructura de directorios propuesta** | Reemplazar por la estructura real: cuatro repositorios (`AuroraCore`, `AuroraCareFront`, `AuroraHome`, `Aurora-Worker-IA`) más el vault de documentación. |
| **5.1 Ambientes** | Staging: "Automática al hacer merge a **`staging`**" (no a `main`). Producción: "Automática al hacer merge a **`main`**" para Core, según el flujo del archivo 05. Quitar "AWS (pago por uso) u on-premise". |
| **5.3 Estrategia de releases** | Reemplazar por el flujo `feature` → `staging` → `main` del archivo 05; quitar toda mención a `develop`. |
| **5.4 Monitoreo y logging** | Dividir en **"En uso"** (Sentry, chequeos de salud, métricas Prometheus en Home y Worker) y **"Previsto"** (Loki, Grafana, Uptime Kuma). `[A CONFIRMAR con Octavio qué está activo en el VPS.]` |
| **5.5 Respaldo y recuperación** | Aclarar dónde se guarda el respaldo real `[A COMPLETAR]`. Hoy dice "S3 (5 GB gratis) o en el VPS". |
| **6.3 Controles de privacidad** | "Cifrado a nivel de columna (pgcrypto)" → "**Cifrado a nivel de aplicación (Fernet) de los campos identificatorios; ver ADR-010**". |
| **6.3 Minimización de datos** | "Aurora Home solo debe transmitir el audio necesario…" → ver el archivo 07 (el flujo de voz cambió). |

### 3.3 Qué dicen los otros documentos sobre la misma tecnología (revisar coherencia)

| Documento | Frase a corregir |
| ----- | ----- |
| Plan de Proyecto → Entregable 1 | "lógica local para STT/TTS" |
| Plan de Proyecto → WBS 4.3 | "módulo de transcripción STT/TTS" (hoy es pipeline con nube y respaldo local) |
| Plan de Proyecto → 6.2 y 6.6 | "procesamiento local de voz reduce costos y evita enviar audio crudo" |
| Plan de Proyecto → 7.2 | "Gemini y Claude" |
| Resumen de Sprints → tabla de stack | "Auth0", "Whisper.cpp — pendiente", "Aurora Core: repositorio aún vacío" (obsoleto: Core está implementado) |
| Glosario → **Raspberry Pi** | Agregar "(modelo 5)" |
| Glosario → **STT** | "En Aurora se plantea realizarla localmente" → "En Aurora se realiza principalmente en la nube (Azure), con respaldo local (Whisper.cpp)" |
| Glosario → **Aurora Care** | "Aplicación web/móvil" → "Aplicación móvil" (la web es una posibilidad futura) |
| Glosario → agregar | **Supabase**, **Worker IA**, **Expo Push**, **Fernet** |

---

## 4. Tabla de contenedores corregida (reemplaza la de 2.2)

| Contenedor | Tecnología | Responsabilidad | Alcance |
| :---- | :---- | :---- | :---- |
| **Aurora Home** | Raspberry Pi 5 + Debian 13 + Python (arquitectura hexagonal) + SQLite | Captura de audio, STT y TTS (nube con respaldo local), ejecución de recordatorios y actividades, cola de eventos offline, sincronización con Core | MVP |
| **Aurora Core** | Python 3.12 + Django + DRF + Channels | API REST y WebSocket, lógica de dominio, autenticación (validación de JWT), alertas, notificaciones push | MVP |
| **Worker IA** | Python + FastAPI | Inferencia con LLM, memoria del paciente, insights y resúmenes. Único acceso al LLM | MVP |
| **Base de datos y autenticación** | Supabase (PostgreSQL 16 + pgvector + Supabase Auth) | Datos del paciente, vectores de la memoria, usuarios | MVP |
| **Redis** | Redis 7 (en el backend) | Caché y pub-sub entre servicios | MVP |
| **Aurora Care** | React Native + Expo + TypeScript | App del cuidador: configuración, estado, historial, alertas push | MVP |
| **n8n** | n8n (autoalojado) | Disparo programado de interacciones diarias | MVP (acotado) |
| **Aurora Band Gateway** | — | Ingesta de datos biométricos | **No desplegado; futuras versiones** |

---

## 5. Pendiente de definición del equipo

1. ~~Modelo de Raspberry Pi~~ (confirmado: Pi 5 de 8 GB). **Falta confirmar el módulo de audio**: el código habla de ReSpeaker v2 y el presupuesto de "ReSpeaker 2-Mics Pi HAT v2.0".
2. **Observabilidad:** qué herramientas están realmente activas en el VPS.
3. **AWS:** si se usa algún servicio propio (por ejemplo S3 para respaldos). Si no, se elimina de ADR-007.
4. **Los diagramas C4:** alguien con acceso a la herramienta original debe rehacerlos; puedo dejar los diagramas en texto para que los redibujen.

## 6. Hallazgos de seguridad de la arquitectura de voz (para la sección de ADR-011)

1. **La clave de Azure está en el dispositivo.** Aurora Home lee `AURORA_HOME_AZURE_SPEECH_KEY` desde `/etc/aurora-home/aurora-home.env`, es decir, una credencial del proveedor vive en una Raspberry Pi dentro de la casa de cada paciente. Si un dispositivo se pierde o se vulnera, la clave queda expuesta, y al ser la misma para todos los dispositivos, habría que rotarla en todos. La práctica recomendada es que **Aurora Core emita tokens de corta duración** a cada dispositivo (el servicio de voz de Azure lo permite) o que los dispositivos usen su propia credencial revocable. Registrarlo como **deuda técnica y riesgo** (archivo 03, riesgo R14), no como algo resuelto.
2. **Hoy se usa el nivel gratuito (F0)** de Azure Speech, con una cuota de 500.000 caracteres mensuales en la síntesis (ADR-HOME-010). El propio ADR advierte que las condiciones pueden cambiar. Para pacientes reales se necesita el nivel pago.
3. **Región del recurso de Azure: `eastus` (Este de EE. UU.).** Es un dato necesario para la sección de transferencia internacional de datos (archivo 07): el audio y el texto se procesan en Estados Unidos.
4. **Contraste útil para el documento:** la comunicación entre Aurora Home y Core **sí usa una credencial propia de cada dispositivo** (`X-Device-API-Key`), con rotación y ventana de gracia, y Core solo guarda su *hash*. Es el modelo que habría que replicar para la credencial de Azure.

---

## 7. Estado de aplicación en el Docs (14/10/2026)

Aplicado en el Google Doc: 1.3, 2.1, 2.2, 2.3, gobierno y estado de los ADR, enmiendas de los ADR-001, 004, 005, 006, 007, 008 y 009, ADR-010 y ADR-011 nuevos, 4.2, 5.1, 5.3, 5.4, 5.5, 6.3 (cifrado), glosario (Supabase, Worker IA, Expo Push, Fernet y correcciones) y nota de actualización en el resumen de Sprints. Pendiente: reemplazar a mano los tres diagramas C4 (ver `figuras/`) y los `[A COMPLETAR]` de 5.4 y 5.5. La minimización de datos (6.3) se trata con el archivo 07.

Confirmado por el equipo el 14/10/2026: se usa el plan gratuito (Free) de Supabase; la autenticación migró de Auth0 a Supabase Auth; Supabase Storage guarda recursos como fotos y audios. En el Plan de Proyecto 6.2 el monto de $15 USD para persistencia quedó rotulado como estimado para un plan pago (hoy $0).
