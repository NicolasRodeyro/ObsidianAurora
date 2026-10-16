---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-16
---

# Desarrollo del Proyecto Aurora — Sprints 0, 1 y 2

| **Campo** | **Valor** |
| --- | --- |
| Sponsor | Virginia Santos |
| Cierre de ejecución | 05/10/2026 |
| Entrega final | 05/11/2026 |
| Gestión | Jira (proyecto AURA), sitio [project-aurora-alz.atlassian.net](http://project-aurora-alz.atlassian.net/) |
| Documentación | Vault Obsidian (ObsidianAurora), repos de código en GitHub (AuroraMemory) |

### Equipo

| **Persona** | **Roles** |
| --- | --- |
| Jeremías Maldonado Gómez | PM · DevOps · UX/UI · Scrum Master |
| Mateo Romero Plaza | **Frontend · DBA · Aurora Home · Analista Funcional** |
| Haik Kilic Aslan | Backend · Worker IA · Analista Funcional · Product Owner |
| Nicolás Rodeyro Contarino | UX/UI · DBA · Frontend |
| Octavio Escudero | **Backend · Worker IA · Aurora Home** |

### 1.1 Nota importante sobre la numeración de sprints

Durante el arranque, la gestión de sprints en Jira fue irregular: el campo "Sprint" de Jira **no coincide** con la numeración de sprints que usa la documentación del proyecto. Para evitar confusiones, este documento usa la **numeración de la documentación (Sprint 0, 1 y 2)** y aclara en cada sección a qué iteración(es) de Jira corresponde.

| **Sprint (este documento)** | **Corresponde en Jira** | **Naturaleza del trabajo** |
| --- | --- | --- |
| Sprint 0 — Fundación | "SCRUM Sprint 0" (aparece dividido en dos iteraciones, id 1 e id 2) | Definición y setup, sin código de producto |
| Sprint 1 — Diseño y primeras vistas | "SCRUM Sprint 2" + "SCRUM Sprint 3" | Modelo de datos, design system, primeras pantallas |
| Sprint 2 — Backend, integración y Aurora Home | "SCRUM Sprint 4" (+ tickets de Aurora Home etiquetados retroactivamente) | Backend, integración, agente edge |

La propia inconsistencia de numeración es un hallazgo de proceso, registrado en la retrospectiva combinada del equipo (Mega Retro Sprints 0-2).

### 2. Stack tecnológico del ecosistema

El ecosistema Aurora se compone de cuatro componentes de producto (Aurora Home, Aurora Care, Aurora Core y Aurora Worker IA) más el vault de documentación; Aurora Band quedó fuera del MVP. El stack se definió en el Sprint 0 (ver documento "Arquitectura y Stack Tecnológico", 11 ADRs).

| **Componente** | **Rol** | **Tecnologías** |
| --- | --- | --- |
| **Aurora Home** | Asistente de voz en el hogar (corre en Raspberry Pi) | Python, arquitectura hexagonal, SQLite; voz en la nube (Azure Speech) con respaldo local (Whisper.cpp y Piper) |
| **Aurora Band** | Wearable biométrico comercial (HR, movimiento, GPS) | Se consume su API; no se modifica el firmware. Fuera del MVP (decisión del 29/08/2026) |
| **Aurora Care** | App móvil del cuidador | React Native 0.81 + Expo 54 + TypeScript, Expo Router, TanStack React Query, Supabase Auth |
| **Aurora Core** | Backend central: API REST y WebSocket, lógica de dominio, alertas y notificaciones (antes AuroraCareBack) | Python 3.12, Django + Django REST Framework + Channels, PostgreSQL (Supabase), JWT de Supabase Auth, gunicorn + whitenoise |
| **Aurora Worker IA** | Backend de IA: inferencia con el modelo de lenguaje, memoria del paciente y resúmenes | Python + FastAPI (servicio independiente; proveedor de modelos de lenguaje configurable) |
| **Orquestación** | Automatización de flujos | n8n (alcance acotado en el MVP) |
| **Datos** | Persistencia y memoria | PostgreSQL 16 + pgvector (Supabase) |
| **Auth** | Autenticación | Supabase Auth (OAuth 2 + PKCE en el cliente; validación del JWT en Aurora Core) |

**Nota sobre los nombres:** hasta el Sprint 2 el backend se llamó AuroraCareBack. Desde la decisión del 28/07/2026 es el backend único y central de Aurora, con el nombre Aurora Core (repositorio AuroraCore); no existe un backend aparte para el panel del cuidador. La inferencia con el modelo de lenguaje la hace un servicio independiente, Aurora Worker IA (repositorio Aurora-Worker-IA).

Actualización al 12/10/2026: la tabla refleja el stack vigente. Durante el Sprint 2 la autenticación era Auth0, la voz era local (Whisper.cpp) y el backend se llamaba AuroraCareBack. Hoy la autenticación es Supabase Auth (ADR-005), la voz usa Azure Speech con respaldo local (ADR-011) y Aurora Band quedó fuera del MVP. La arquitectura vigente es la del documento Arquitectura y Stack Tecnológico.

### 3. Sprint 0 — Fundación

**Período:** 21 de abril de 2026 – 07 de junio de 2026 (cierre real).  
**Corresponde en Jira:** "SCRUM Sprint 0" (dos iteraciones).  
**Objetivo (goal):** "Ponernos de acuerdo y configurar todo" → comenzar el proyecto con las bases definidas.

### Resumen del sprint

Sprint de arranque. El equipo alineó **alcance, arquitectura y forma de trabajo**, y dejó lista toda la documentación de gestión y los 5 repositorios. No se escribió código de producto: el valor entregado son las definiciones que gobiernan todo lo posterior — 9 épicas alineadas 1:1 con los 9 módulos funcionales, 91 requerimientos funcionales + 43 no funcionales, la elección del stack tecnológico y 9 ADRs. Ya aparece el primer indicio del patrón que marcaría el proyecto: el cierre real se estiró por encima de lo planificado.

### 3.1 Naturaleza del sprint

Sprint de **fundación**: definición de alcance, arquitectura, documentación de gestión y setup de repositorios. **No hay código de producto**; los entregables son documentos y decisiones.

### 3.2 Gestión

- **Tickets Finalizados:** 16 (AURA-1, 2, 5, 6, 7, 8, 9, 10, 26, 32, 33, 34, 35, 36, 37, 38).
- El cierre real (07/06) quedó por encima de lo planificado, primer indicio del patrón de sprints que se estiran.

### 3.3 Desarrollo y entregables

Al no haber código, el "desarrollo" del sprint es la producción de los artefactos que rigen todo lo posterior:

- **Definición de alcance y funcionalidades** (AURA-1, AURA-2, AURA-26).
- **Arquitectura del sistema** (AURA-5, AURA-35): modelo C4 + 9 ADRs; elección de stack.
- **9 épicas de producto alineadas 1:1 con los 9 módulos funcionales** (AURA-8).
- **Documentos de gestión:** Project Charter (AURA-32), Working Agreement (AURA-33), Gestión de la Configuración (AURA-34), Plan de Testing (AURA-36).
- **Requerimientos:** 91 RF + 43 RNF distribuidos en 9 módulos (fuente autoritativa).
- **User Story Map** (AURA-37) y **Backlog inicial** (AURA-38).
- **Investigación de dominio:** demencia/neurología y contacto con profesional de la salud (AURA-6, AURA-7).
- **Creación de los 5 repositorios** (AURA-9): AuroraCore, AuroraCareBack (hoy unificados en AuroraCore), AuroraCareFront, AuroraHome, ObsidianAurora.
- **Definición de roles y capacidad semanal por integrante** (AURA-10).

### 3.4 Decisiones clave

- **Stack tecnológico oficial:** Python/Django-DRF (backend) · React Native + Expo + TypeScript (móvil) · Supabase/PostgreSQL + pgvector · Supabase Auth · n8n · Azure Speech con respaldo local (Whisper.cpp y Piper).
- **Modelo de épicas:** 9 épicas de producto (1:1 con módulos) + épicas de gestión.
- **Deprecación** de las épicas AURA-23/24/25 (detección de comportamiento, estados fisiológicos y geolocalización), absorbidas por la épica AURA-22 (Detección de Eventos y Riesgos) por solapamiento.

### 3.5 Retrospectiva del Sprint 0

Las retrospectivas de esta sección salen de la sesión de retro del equipo (técnica de las **4 L's**: *Liked / Learned / Lacked / Longed for*). Como las retros individuales quedaron pendientes, se hizo una sola sesión combinada y acá se **repartieron los aportes por sprint según su contenido**. Los aportes que abarcan varios sprints (o que no son atribuibles a uno solo) se agrupan al final, en 6.4.

**Lo que funcionó bien:** Documentos de gestión (Todos) · Creación de los repositorios (Nico) · Investigaciones útiles (Haik, Mateo).

**Lo que faltó:** definir/seleccionar el reloj-pulsera todavía pendiente (Haik).

*(Aprendizajes y deseos de este sprint no tuvieron aportes específicos; ver transversales en 6.4.)*

### 4. Sprint 1 — Diseño, modelo de datos y primeras vistas

**Período:** 17 de junio de 2026 – 02 de agosto de 2026 (cierre real; fin planificado 08/07/2026).  
**Corresponde en Jira:** "SCRUM Sprint 2" + "SCRUM Sprint 3".  
**Objetivo:** cerrar el diseño (datos + UI) y producir las primeras pantallas navegables del panel del cuidador.

### Resumen del sprint

Sprint de diseño. Se cerró el **modelo de datos** (DER completo, 8 vistas DBML) y todo el **diseño de producto**: un Design System verificado en accesibilidad (WCAG AA/AAA), el Manual de UX/UI de 11 capítulos, un prototipo navegable y 32 pantallas del MVP maquetadas, además de las primeras vistas de Aurora Care. Fue el sprint con **mayor desvío de cierre (+25 días)**. El backend todavía no arranca, lo que deja **bloqueada** la conexión app ↔ base de datos (AURA-63) — dependencia que se arrastra al sprint siguiente.

### 4.1 Gestión

- **Tickets Finalizados:** ~31 en total — ~22 de la iteración Jira "Sprint 2" (AURA-27, 30, 41–46, 48–62) + 9 de la iteración Jira "Sprint 3" (AURA-65 a AURA-73).
- **Desvío de cierre importante:** planificado para el 08/07, cerró el 02/08 (**+25 días**). Es el desvío más marcado del período.
- **Arrastres / no cerrados:** AURA-47 (Agregar US, quedó pendiente), AURA-63 (Conexión Care ↔ BD, **bloqueada** por falta de backend), AURA-64 (Investigación pulsera Aurora Band, **en curso**, continúa en Sprint 2).

Nota: el bloque de diseño (AURA-65 a AURA-73) figura en Jira bajo "Sprint 3", pero corresponde conceptualmente a este sprint de diseño de la documentación. Se incluye acá para no dejar avances afuera.

### 4.2 Desarrollo técnico

**a) Modelo de datos (AURA-53).**  
Diseño completo del DER de la base de datos, materializado en 8 vistas DBML + PDF y documento de decisiones de tablas. Es el contrato de datos que después implementa el backend.

**b) Design System y verificación de accesibilidad (AURA-65).**

- Tokens de diseño como fuente de verdad (`tokens.json` → `tokens.css`): rampas de color (violet de marca, lime de acento, neutrales, semánticos), tipografía (Figtree/Inter para app; Atkinson Hyperlegible Next para el display del hogar por accesibilidad), escala de espaciado base-8, radios, elevaciones, motion y breakpoints (390/768/1440).
- Tres temas: claro (Aurora Care por defecto), oscuro (identidad de marca) y device (display de Aurora Home, tipografía grande 32–72px para legibilidad a 2–3 m).
- **Verificación WCAG 2.2 AA/AAA automatizada** con un script propio (`contrast.py`) que valida 32 pares de contraste fg/bg contra los tokens; todos los pares cumplen.

**c) Manual de UX/UI (AURA-66).**  
Manual de 11 capítulos: identidad de marca, color, tipografía, proto-personas, journeys, user flows, VUI (diseño conversacional), accesibilidad y handoff.

**d) Prototipo navegable y wireframes (AURA-67, AURA-73).**

- Prototipo HTML navegable de Aurora Care (`aurora-care.html`) con flujos interactivos y un documento de wiring (flujo principal de demo, flujo de alerta/emergencia, flujo de terapias, navegación global).
- 32 pantallas del MVP maquetadas en HTML (auth/onboarding, core, recuerdos/actividad, ajustes, desktop, device, visión, terapias).
- Wireframes de visión V1–V6.

**e) Primeras vistas de Aurora Care (AURA-54 a AURA-62, AURA-68 a AURA-72).**  
Primeras pantallas del panel del cuidador: Login, Módulo Paciente, Terapias Cognitivas, Recordatorios y Recetario, más las vistas de UI derivadas (Auth/Onboarding, Alertas/Actividad, Ajustes, Display de Aurora Home y variante Desktop 1440).

**f) Investigaciones de soporte.**

- Almacenamiento de datos y cumplimiento de la Ley 25.326 (protección de datos personales, Argentina).
- Despliegue e infraestructura.
- Pulsera Aurora Band (AURA-64, continúa en Sprint 2).

### 4.3 Artefactos producidos

DER de la base de datos (8 vistas DBML + PDF), Design System (tokens + verificación WCAG), Manual de UX/UI (11 capítulos), prototipo navegable + 32 pantallas HTML, wireframes de visión, e investigaciones de Ley 25.326 e infraestructura.

### 4.4 Retrospectiva del Sprint 1

**Lo que funcionó bien:** UX casi completo (Jere) · Definición temprana de las pantallas principales de Aurora Care (Jere) · Wireframes, prototipo navegable y manual de UX/UI (Jere) · DER de la BD (Mateo, Nico) · Skill de trazabilidad e informes (Jere) · Modelo de dominio consistente desde el día 1 (Octavio).

**Lo que aprendimos:** en Aurora Care, definir antes los flujos completos de usuario evita rehacer pantallas después (Jere).

**Lo que faltó:** comunicación back–front (arrancó en Haik+Octa y derivó en Mateo+Nico) — se arrastra al Sprint 2.

### 5. Sprint 2 — Backend, integración y Aurora Home

**Período:** 08 de julio de 2026 – en curso (estado al 25/08/2026).  
**Corresponde en Jira:** "SCRUM Sprint 4" (+ tickets de Aurora Home AURA-90/91 etiquetados retroactivamente como trabajo de esta etapa).  
**Objetivo:** arrancar el backend real, iniciar la integración app ↔ API y levantar el agente de Aurora Home.

### Resumen del sprint (en curso)

Sprint **abierto al 25/08/2026** y el de mayor peso técnico: por primera vez hay **código de servidor**. Lo avanzado hasta ahora:

- **Backend del panel del cuidador (entonces AuroraCareBack, hoy Aurora Core), liderado** por **Octavio**: Auth0/JWT + APIs de rutinas, medicación, cumplimiento y paciente, con multi-tenancy por hogar y batería de tests.
- **Arranque del track de hardware/edge — Aurora Home**, liderado por **Mateo**: el software del dispositivo del hogar (sobre Raspberry Pi), con los módulos M01 (base del repo), M02 (contratos v1 + simulador local del Core) y M03 (persistencia SQLite resiliente con patrón outbox/inbox).
- **Integración de la app móvil** con la API (Auth0 + cliente HTTP con refresh de token) y features de reglas de negocio (alertas, drop-in, validación de recuerdos).
- **Herramientas nuevas de operaciones: Render** (entorno de deploy dev) e **Infisical** (gestión de secretos).

Queda abierto para el resto del sprint: consolidar el backend en Aurora Core, completar varias APIs (dashboard, geofencing, acknowledge, `/api/me`), cerrar formalmente Aurora Home M03 y las historias de terapia. Este sprint también refleja el **cambio de roles del equipo** (Mateo → Aurora Home, Octavio → backend).

Los períodos de Sprint 1 y Sprint 2 se solapan (ambos arrancan en julio). Es consecuencia directa del estiramiento de los sprints anteriores y del arranque tardío del backend, ambos registrados como hallazgos de la retrospectiva.

### 5.1 Gestión

- **Tickets Finalizados:** 12 (AURA-75, 79, 80, 82, 83, 84, 87, 88, 89, 90, 91, 100).
- **En curso / bloqueados / pendientes:** el sprint sigue abierto; conviven historias terminadas con varias en curso (AURA-74, 76, 77, 78, 92, 95, 96…) y en revisión (AURA-97, 98, 99). Ver 5.4.

### 5.2 Desarrollo técnico — Backend del panel del cuidador (entonces AuroraCareBack, hoy Aurora Core)

Backend **Django + Django REST Framework** (Python 3.12, PostgreSQL/Supabase), **liderado por Octavio Escudero** (principal autor del repositorio) con aportes de Haik Kilic y Mateo Romero. Lo **entregado y verificado con código + tests** en este sprint:

- **Integración Auth0 / JWT (AURA-82).** Autenticación por `Bearer <JWT>`: validación de firma RSA256 contra las claves públicas de Auth0 (JWKS cacheado con TTL), verificación de `audience` e `issuer`, mapeo del `sub` a un perfil de cuidador, y un bypass de token estático **sólo para desarrollo**. Con test automatizado.
- **API REST de Rutinas del Paciente (AURA-87).** CRUD de rutinas, con endpoints anidados bajo `patients/{id}/routines/`. Con tests.
- **API REST de Medicación y Recetario (AURA-88).** CRUD de medicación.
- **API REST de Registro de Cumplimiento (AURA-89).** Registro de cumplimiento de rutinas y de toma de medicación (taken/missed). Con tests.
- **Setup inicial del proyecto (AURA-83).** Estructura del proyecto, configuración de BD y entorno (ver nota de discrepancia más abajo).
- **API REST de Paciente (AURA-84).** CRUD del perfil del paciente.

**Fundamentos transversales implementados (código + tests):**

- **Multi-tenancy por hogar:** aislamiento de datos por "hogar" (HomeAccount); un cuidador sólo ve los datos de sus hogares. Se garantiza con mixins reutilizables (queryset filtrado por subconsulta `Exists()` y validación del paciente en las escrituras). Hay un test específico de escritura cruzada entre hogares.
- **Optimización de consultas:** índices estratégicos por paciente/fecha y test de conteo de queries para prevenir el problema N+1.
- **Auditoría:** registro de mutaciones (qué campo cambió, quién y cuándo), guardando nombres de campos y no valores (para no persistir PII).
- **Documentación de API:** OpenAPI/Swagger (drf-spectacular).
- **14 tests** cubriendo autenticación, seguridad multi-tenant, N+1, paginación y las APIs críticas (rutinas, cumplimiento, acknowledge de alertas, ingestión de la banda, contribuciones de memoria).

**Discrepancia de nomenclatura (hallazgo).** Los tickets AURA-82 a AURA-89 están etiquetados/titulados como "AuroraCore", y AURA-83 "Setup inicial AuroraCore" figura Finalizado. Sin embargo, en ese momento el backend estaba implementado en el repositorio AuroraCareBack y el repositorio AuroraCore estaba vacío (sólo un README de una línea). El 28/07 se designó a Aurora Core como backend único; la consolidación se completó después y AuroraCareBack dejó de existir: hoy el backend es Aurora Core.

**"Entregado" vs. "scaffold presente".** El repositorio del backend (entonces AuroraCareBack) tenía además scaffolding de apps que **no** corresponden a trabajo entregado en este período: eventos y geofencing (AURA-86, pendiente), dashboard del cuidador (AURA-85, pendiente), acuse de recibo de alertas (AURA-96, pendiente), biometría, memoria/IA y orquestación. Existen los modelos y la estructura, pero sus tickets siguen abiertos o pertenecen a épicas de visión. Se listan como base preparada para sprints futuros, no como avances cerrados.

### 5.3 Desarrollo técnico — Aurora Home (dispositivo del hogar / hardware-edge)

Este es el track de **hardware/edge** del proyecto: el software del dispositivo que vive en el hogar del paciente y corre sobre **Raspberry Pi**. Está **liderado por Mateo Romero Plaza**, autor de prácticamente la totalidad del repositorio AuroraHome. Es un agente en **Python 3.11+ con arquitectura hexagonal**. Entregado en este sprint:

- **AH-M01 — Base del repositorio (AURA-90).** Estructura inicial, puertos abstractos (reloj, red, audio, LED, botón), bootstrap asíncrono y logging estructurado.
- **AH-M02 — Contratos v1 y simulador Home↔Core (AURA-91).** Definición de 8 operaciones del contrato (pairing, heartbeat, snapshot de configuración, batch de eventos, comando + ack, etc.) con modelos JSON versionados (schema 1.0) y validación estricta; y un **simulador local del Core** que emula el backend con fallos determinísticos (timeouts, respuestas no-JSON, duplicados) para poder desarrollar y testear sin red.
- **AH-M03 — Fundación local resiliente (AURA-95).** *El código ya está mergeado* (SQLite durable con WAL, patrón **outbox** para eventos con reintento exponencial, **inbox** de comandos con deduplicación, snapshots de configuración versionados y resiliencia ante reinicios), pero **el ticket AURA-95 todavía figura abierto** en Jira. Se reporta como código entregado con ticket pendiente de cierre.

Cobertura de tests de Aurora Home: unidad (contratos, matrix, migraciones), integración (persistencia SQLite, outbox/inbox) y contrato (simulador Core), con umbral de cobertura del 80%. El audio real (Whisper.cpp) está definido como puerto pero aún es un stub simulado.

### 5.4 Desarrollo técnico — App móvil Aurora Care (AuroraCareFront)

Sobre las primeras vistas del Sprint 1, en esta etapa la app avanzó a **integración con el backend**: cliente HTTP propio contra `/api/v1` con refresco automático de token, gestión de estado y datos con TanStack React Query (query keys centralizadas), y **autenticación Auth0** (OAuth 2 + PKCE) con modo local de respaldo. Hay implementadas ~16 pantallas (tabs de inicio, actividad, pacientes, rutinas, medicación, recuerdos, dispositivos, ajustes + modales de detalle). Features de reglas de negocio ya codificadas: alertas (RF-45), drop-in bidireccional con Aurora Home (RN15) y cola de validación de recuerdos (RN6).

El ticket AURA-63 (Conexión Care ↔ BD), bloqueado en el Sprint 1, quedó **desbloqueado** por la entrega de Auth0 (AURA-82); su cierre depende además del setup definitivo del backend.

### 5.5 Deploy, operaciones y herramientas nuevas

En este sprint se incorporaron herramientas de operaciones que no existían antes en el proyecto:

- **Render — entorno de deploy dev (AURA-92, en curso).** Blueprint de Render + Dockerfile (Python 3.12-slim) + `entrypoint.sh` que corre migraciones, seed y `gunicorn`; estáticos servidos con whitenoise; BD Supabase (Session pooler, SSL). Pensado como entorno de desarrollo, con bypass de auth de dev. Verificable en el repositorio: `render.yaml` y `entrypoint.sh` en AuroraCareBack.
- **Infisical — gestión de secretos.** Se incorporó Infisical como gestor de secretos y variables sensibles (tokens, claves de Auth0/Supabase, credenciales de BD): las credenciales se administran en el gestor y se referencian por nombre, en vez de versionarlas en el código. Por diseño, esto **no deja rastro en los repositorios** — es justamente el objetivo: que ningún secreto viva en el código. Se documenta como parte del stack de operaciones del proyecto.

### 5.6 En curso, en revisión y bloqueado (al 25/08/2026)

| **Key** | **Estado** | **Descripción** |
| --- | --- | --- |
| AURA-74 | Bloqueado | US-D1 — Sesión guiada de terapia |
| AURA-78 | Bloqueado | Registro y perfil del paciente |
| AURA-76 / AURA-77 | Por hacer | US-D3 Descubrimientos con validación / US-D4 Dificultad adaptativa |
| AURA-85 / AURA-86 | Por hacer | API Dashboard del Cuidador / API Zonas Seguras (geofencing) |
| AURA-93 | Por hacer | ADR formal de cifrado de PII (Ley 25.326) |
| AURA-94 | Por hacer | Endpoint GET /api/me |
| AURA-96 | Por hacer | API acuse de recibo de alertas (acknowledge) |
| AURA-64 | En curso | Investigación pulsera Aurora Band (arrastrada de Sprint 1) |
| AURA-97 / AURA-98 | En revisión | Cifrado PII conforme Ley 25.326 / API de consentimiento informado |
| AURA-99 | En curso | Asistencia backend a AURA-74 |
| AURA-102 / AURA-103 | Por hacer | Contract tests OpenAPI y E2E real Aurora Home ↔ Core |

### 5.7 Retrospectiva del Sprint 2 (en curso)

Es el sprint con más aportes en la retro (concentra casi todo el trabajo técnico).

**Lo que funcionó bien:** Auth real con JWKS cacheado y rotación de claves (Haik, Octa) · Contrato OpenAPI publicado (Octavio) · API REST CRUD de Paciente (Octavio) · Mateo escribió tests junto a sus features cuando main casi no los tenía (Mateo) · Contexto versionado por área + `agents.md` como fuente de verdad (Octavio) · Convención de commits explícita y sostenida (Octavio) · Docker Compose reproducible (Octavio) · Flujo de PRs con rama staging (Todos) · Agentes de IA especializados por área + orquestador (Octavio) · Paper + póster (Octa).

**Lo que aprendimos (backend y hardware):**

- El queryset scopeado protege lecturas, pero **no** escrituras (Haik).
- Una abstracción que existe pero se copia a mano no protege (Haik).
- `.distinct()` sobre un join de 3 tablas es un parche: `Exists()` correlacionado da el mismo resultado sin fan-out (Haik).
- `get_or_create` en loop = 2 queries por fila; un lote de 30 lecturas pasó de **122 a 6 queries** con `bulk_create` (Haik).
- Una clave de deduplicación incompleta pierde datos en silencio (Haik).
- `auto_now` no corre si el campo no está en `update_fields` (Haik).
- Testear en SQLite y desplegar en Postgres deja huecos: `bulk_create(ignore_conflicts)` y migraciones (Haik).
- La config OAuth de Swagger se resolvió por prueba y error (Octavio).
- Restructurar épicas (Jere) · la ley de datos del paciente (Ley 25.326) es un tema espinoso (Jere).
- Expo es clave (Mateo) · manejo de hooks (Nico).
- **Aprendimos a armar el hardware del hogar (Aurora Home) e instalarle/configurar el software** (Haik, Mateo).

**Lo que faltó:**

- CI/CD: `AGENTS.md` declara "GitHub Actions" y un DoD con `ruff check` + `pytest`, pero **no existe ningún workflow** (Back).
- Tests desde el arranque: main tenía 4 archivos de test para 13 apps; los 6 bugs latentes que aparecieron eran todos detectables con un test de create (Back).
- Revisión cruzada real: los PRs se mergearon rápido y por el mismo autor; ninguno de los bugs sobrevivientes se detectó en review (Back).
- Convención de ramas `feature/AUR-[num]`: se cumplió 1 de 9 veces, y una quedó con typo (`facture/`) (Todos).
- Dependencia del Auth0 (Octa) · integrar facture/notifications-aurora (Haik, Mateo).

**Lo que hubiéramos querido tener:**

- Entorno de staging desplegado para probar el callback de Auth0 sin 5 commits de prueba y error (Todos).
- Plantilla de PR con el checklist del DoD que ya estaba escrito en `AGENTS.md` (Jere).
- Cobertura mínima exigida: `pytest-cov` estaba en `requirements/local.txt` y nunca se usó (Jere).
- Seed representativo para ver performance — los N+1 sólo aparecen con volumen y `seed_local` crea pocas filas (Todos).

### 6. Estado consolidado al cierre del período

### 6.1 Estado por subsistema

La columna "Responsable / autoría principal" se basa en la autoría real de los repositorios (git) y en los roles del equipo; no en el campo *assignee* de Jira, que en este período no es confiable.

| **Subsistema** | **Responsable / autoría principal** | **Estado al 25/08/2026** |
| --- | --- | --- |
| Documentación / gestión | Jeremías (PM) | Base completa (charter, requerimientos, arquitectura, plan de testing, backlog) |
| Diseño (Design System + UX/UI) | Nicolás + Jeremías (UX/UI) | Completo y verificado (WCAG AA/AAA); handoff a Figma parcialmente pendiente por límite del plan Figma |
| Modelo de datos | Mateo + Nicolás (DBA) | DER completo (8 vistas DBML) |
| Backend del panel (entonces AuroraCareBack, hoy Aurora Core) | **Octavio** (+ Haik, Mateo) | Operativo en dev: Auth0/JWT + APIs de rutinas, medicación, cumplimiento y paciente, multi-tenant, con tests; scaffolding amplio de apps aún no entregadas |
| Aurora Core (orquestación/IA) | A definir | Repositorio vacío en ese momento; el backend se consolidó después en Aurora Core |
| Aurora Home (hardware/edge) | **Mateo** | M01–M02 entregados; M03 con código mergeado y ticket abierto; audio real (Whisper.cpp) pendiente |
| App móvil (AuroraCareFront) | Mateo (autoría histórica) + equipo frontend | ~16 pantallas + Auth0 + integración con API; conexión definitiva a BD pendiente de setup de backend |
| Deploy / operaciones | Jeremías + Octavio (DevOps) | Entorno dev en Render en curso; gestión de secretos con Infisical |

### 6.2 Métricas de referencia

Advertencia metodológica: los valores de "planificados" **no son confiables** en Jira para este período (dos "Sprint 0", tickets arrastrados/reasignados entre sprints y tickets sin sprint). Por eso sólo se reportan los tickets Finalizados; los "planificados" se omiten deliberadamente en lugar de inventarlos. Esto es en sí un hallazgo de proceso.

| **Sprint** | **Tickets Finalizados** | **Desvío de cierre** |
| --- | --- | --- |
| Sprint 0 — Fundación | 16 | Cierre por encima de lo planificado |
| Sprint 1 — Diseño y primeras vistas | ~31 | +25 días (planificado 08/07, cerró 02/08) |
| Sprint 2 — Backend, integración y Aurora Home | 12 (sprint aún abierto) | En curso |

### 6.3 Hallazgos de proceso (de la retrospectiva del equipo)

- **Los sprints se estiran** muy por encima de lo planificado (Sprint 1: +25 días).
- **El backend arrancó tarde:** recién en el Sprint 2 aparece código de servidor.
- **Gestión de sprints en Jira inconsistente:** dos "Sprint 0", arrastres y tickets sin sprint dificultan medir velocidad.
- **Decisiones estructurales a mitad de camino:** AuroraCare pasó a frontend-only y AuroraCore a backend único (28/07); esa consolidación aún no se ejecutó.
- **Bloqueos por dependencias:** AURA-63 estuvo bloqueada por falta de backend.
- **Límites de herramientas externas:** el plan Starter de Figma (6 lecturas/mes) frenó el push del design system.

Varios de estos hallazgos quedaron confirmados por la retro del equipo (3.5, 4.4, 5.7): la falta de CI/CD real, de tests desde el arranque y de revisión cruzada efectiva son los más marcados.

### 6.4 Aportes transversales y acciones acordadas

**Aportes que abarcan todos los sprints (o no atribuibles a uno solo):**

- *Lo que faltó:* **constancia** (todos menos Mateo).
- *Lo que hubiéramos querido tener:* presupuesto para Hostinger · más tiempo · una profe más presente.

**Acciones acordadas (accionables — objetivo: Sprint 3):**

| **#** | **Acción** | **Deriva de** |
| --- | --- | --- |
| 1 | DoD como normativa para cada IA / skill | Falta de DoD aplicado |
| 2 | GitHub Actions para CI/CD | CI/CD declarado pero inexistente |
| 3 | PRs obligatoriamente vinculadas al ticket + convención de nombres | Convención de ramas incumplida |
| 4 | Restringir la creación de PRs que no cumplan la convención | Revisión cruzada débil |
| 5 | Cron para Supabase | Operación de BD |
| 6 | Llenar la DB de prueba (seed representativo) | N+1 sólo visibles con volumen |

### 7. Trabajo pendiente y próximos pasos

- **Consolidar el backend en Aurora Core (resuelto después: el backend pasó a llamarse Aurora Core y AuroraCareBack dejó de existir).**
- **Completar las APIs pendientes:** dashboard del cuidador (AURA-85), zonas seguras/geofencing (AURA-86), acknowledge de alertas (AURA-96), `GET /api/me` (AURA-94).
- **Cerrar AURA-95** (Aurora Home M03, código ya mergeado) y avanzar M04+ hacia audio real (Whisper.cpp).
- **Desbloquear y cerrar la conexión Care ↔ BD** (AURA-63) sobre Auth0 ya entregado.
- **Formalizar el cumplimiento de la Ley 25.326:** ADR de cifrado de PII (AURA-93) y API de consentimiento informado (AURA-97/98).
- **Estabilizar la gestión de sprints en Jira** para poder medir velocidad de forma confiable.

### Anexo A — Índice de tickets por sprint

**Sprint 0 (Finalizados):** AURA-1, 2, 5, 6, 7, 8, 9, 10, 26, 32, 33, 34, 35, 36, 37, 38.

**Sprint 1 (Finalizados):** AURA-27, 30, 41, 42, 43, 44, 45, 46, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62 (iteración Jira "Sprint 2") · AURA-65, 66, 67, 68, 69, 70, 71, 72, 73 (iteración Jira "Sprint 3"). No cerrados: AURA-47 (pendiente), AURA-63 (bloqueado), AURA-64 (en curso).

**Sprint 2 (Finalizados):** AURA-75, 79, 80, 82, 83, 84, 87, 88, 89, 90, 91, 100. En curso/bloqueado/pendiente: AURA-64, 74, 76, 77, 78, 85, 86, 92, 93, 94, 95, 96, 97, 98, 99, 101, 102, 103.

### Anexo B — Documentos de referencia

- Project Charter, Requerimientos (91 RF + 43 RNF), Arquitectura y Stack Tecnológico (C4 + 9 ADRs), Plan de Testing, User Story Map, Backlog Inicial (Sprint 0).
- DER — Base de Datos Aurora (8 vistas DBML), Manual de UX/UI Aurora (11 capítulos), Design System (tokens + verificación WCAG), Investigación Ley 25.326, Investigación Infraestructura (Sprint 1).
- Informe Sprint 0, Informe Sprint 1, Informe Sprint 2 y Mega Retro Sprints 0-2 (documentación de gestión existente en el vault).

*Documento de desarrollo consolidado de los Sprints 0, 1 y 2. Complementa los informes de sprint individuales y la retrospectiva combinada del equipo. Elaborado a partir de Jira (proyecto AURA), el estado real de los repositorios de código y el Document Hub del vault, al 25/08/2026.*
