---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-11-09T12:00:00
---
# Tablero Jira — Proyecto AURA (snapshot)

Snapshot legible del board de Jira para consulta rápida y trazabilidad. El espejo machine-readable está en `jira/snapshot.json`. Cómo refrescar: ver [[CLAUDE]].

> **Sitio:** project-aurora-alz.atlassian.net · **Proyecto:** AURA · **Último sync:** 2026-11-09 · **202 issues** (19 épicas · 113 tareas · 46 historias · 15 errores · 5 subtareas · 4 análisis)
> Relacionados: [[Índice Aurora]] · [[Trazabilidad RF-Épicas]] · [[Requerimientos]] · [[Diseño UX-UI/Handoff y Backlog de Diseño|Handoff de Diseño]].

## Épicas de producto (9)

| Épica | Nombre | Componente | RF | Scope | Hijas |
| --- | --- | --- | --- | --- | --- |
| AURA-14 | Interacción y Asistencia por Voz (Aurora Home) | Módulo 1 | RF-01–14 | `mvp` | 26 |
| AURA-19 | Monitoreo Biométrico (Aurora Band) | Módulo 2 | RF-15–23 | `mvp` | 1 |
| AURA-22 | Detección de Eventos y Riesgos | Módulo 3 | RF-24–35 | `mvp` | 0 |
| AURA-16 | Alertas y Comunicación con el Cuidador | Módulo 4 | RF-36–46 | `mvp` | 2 |
| AURA-15 | Motor de IA y Memoria del Paciente (Aurora Core) | Módulo 5 | RF-47–54 | `mvp` | 12 |
| AURA-21 | Orquestación y Automatización | Módulo 6 | RF-55–59 | `vision` | 0 |
| AURA-18 | Panel del Cuidador (Aurora Care) | Módulo 7 | RF-60–75 | `mvp` | 49 |
| AURA-20 | Seguridad, Privacidad y Cumplimiento (Ley 25.326) | Módulo 8 | RF-76–81 | `mvp` | 7 |
| AURA-17 | Administración de Rutinas y Medicación | Módulo 9 | RF-82–91 | `mvp` | 4 |

## Épicas de gestión (5)

| Épica | Nombre | Labels | Tareas hijas |
| --- | --- | --- | --- |
| AURA-12 | Configuraciones Iniciales | `gestion` `sprint-0` | 9 |
| AURA-13 | Documentación para Proyecto | — | 25 |
| AURA-28 | Requerimientos Funcionales y No Funcionales | `gestion` | 2 |
| AURA-29 | Branding Inicial y UX | `diseno` `gestion` | 14 |
| AURA-31 | Automatización IA | `gestion` `tooling` | 2 |

## Épicas técnicas (2)

| Épica | Nombre | Labels | Tareas hijas |
| --- | --- | --- | --- |
| AURA-81 | Backend AuroraCore — API REST para Panel del Cuidador | `aurora-core` `backend` `mvp` | 8 |
| AURA-139 | Infraestructura & CD — Ambiente estable en VPS Hostinger | `cicd` `deploy` `devops` `infra` | 9 |

## Épicas deprecadas (cerradas — pendientes de borrado manual)

| Épica | Nombre |
| --- | --- |
| AURA-23 | [OBSOLETA — absorbida por AURA-22] Detección de comportamiento anómalo |
| AURA-24 | [OBSOLETA — absorbida por AURA-22] Detección de estados fisiológicos/emocionales |
| AURA-25 | [OBSOLETA — absorbida por AURA-22] Sistema de geolocalización inteligente |

## Tareas, historias, errores y análisis (por key)

| Issue | Épica | Estado | Responsable | Resumen |
| --- | --- | --- | --- | --- |
| AURA-1 | AURA-12 | Finalizada | Mateo Romero Plaza | Terminar de Definir el Alcance del Proyecto |
| AURA-2 | AURA-12 | Finalizada | Mateo Romero Plaza | Terminar de Definir Funcionalidades del Sistema |
| AURA-5 | AURA-12 | Finalizada | Octavio Escudero | Definir Arquitectura del Proyecto |
| AURA-6 | AURA-12 | Finalizada | Haik Kilic | Investigar sobre Demencia y enfermedades similares |
| AURA-7 | AURA-12 | Finalizada | Jeremías Daniel Maldonado Gómez | Contacto con Profesional - Parte 1 |
| AURA-8 | AURA-12 | Finalizada | Jeremías Daniel Maldonado Gómez | Definir las Épicas |
| AURA-9 | AURA-12 | Finalizada | nicolasrodeyro | Crear y Configurar Repos de Github |
| AURA-10 | AURA-12 | Finalizada | Octavio Escudero | Terminar de Definir Roles y Tiempo por semana por miembro |
| AURA-26 | AURA-28 | Finalizada | Mateo Romero Plaza | Documento de Objetivo y Funcionalidades |
| AURA-27 | AURA-29 | Finalizada | nicolasrodeyro | Definir Branding |
| AURA-30 | AURA-31 | Finalizada | Haik Kilic | Skills/rules para diseño - Parte 1 |
| AURA-32 | AURA-13 | Finalizada | Jeremías Daniel Maldonado Gómez | Crear Project Charter/ Plan de Proyecto |
| AURA-33 | AURA-13 | Finalizada | Haik Kilic | Crear Documento Working Agreement |
| AURA-34 | AURA-13 | Finalizada | nicolasrodeyro | Crear Documento de Gestión de la Configuración |
| AURA-35 | AURA-13 | Finalizada | Octavio Escudero | Definir Documento de Arquitectura y Stack Tecnológico |
| AURA-36 | AURA-13 | Finalizada | Haik Kilic | Definir Documento de Plan de Testing |
| AURA-37 | AURA-13 | Finalizada | nicolasrodeyro | Definir User Story Mapping |
| AURA-38 | AURA-13 | Finalizada | Jeremías Daniel Maldonado Gómez | Definir Backlog Inicial |
| AURA-41 | AURA-13 | Finalizada | Jeremías Daniel Maldonado Gómez | Implementación de Informe de Sprint |
| AURA-42 | AURA-13 | Finalizada | Jeremías Daniel Maldonado Gómez | Definición de Artefactos de Trazabilidad |
| AURA-43 | AURA-13 | Finalizada | Jeremías Daniel Maldonado Gómez | Revisar granularidad del WBS: tratar de desagregar o agrupar las actividades de gestion de proyecto segun se requiera, para poder planificarlas en un diagrama de gantt o calendario correctamente |
| AURA-44 | AURA-28 | Finalizada | Haik Kilic | Revisar correcciones de los requerimientos funcionales y no funcionales |
| AURA-45 | AURA-13 | Finalizada | Mateo Romero Plaza | Agregar flujo de fondos |
| AURA-46 | AURA-13 | Finalizada | Octavio Escudero | Agregar cronograma |
| AURA-47 | AURA-13 | Finalizada | nicolasrodeyro | Agregar US |
| AURA-48 | (sin épica) | Finalizada | — | Agregar glosario general del proyecto |
| AURA-49 | AURA-13 | Finalizada | Octavio Escudero | Buscar una forma mas linda de mostrar el analisis de costos |
| AURA-50 | AURA-13 | Finalizada | Mateo Romero Plaza | Crear un glosario en el documento de entrega a la profe |
| AURA-51 | AURA-13 | Finalizada | Haik Kilic | Investigar un carrito de compras para un prototipo de Aurora Home. |
| AURA-52 | AURA-31 | Finalizada | Jeremías Daniel Maldonado Gómez | Sub RAG para flujo de información entre Jira y Obsidian |
| AURA-53 | AURA-15 | Finalizada | Mateo Romero Plaza | Diseño de BD |
| AURA-54 | AURA-18 | Finalizada | Mateo Romero Plaza | Login - Aurora Care |
| AURA-55 | AURA-18 | Finalizada | Mateo Romero Plaza | Modulo Paciente - Aurora Care |
| AURA-56 | AURA-18 | Finalizada | nicolasrodeyro | Módulo Terapias Cognitivas |
| AURA-57 | AURA-18 | Finalizada | Mateo Romero Plaza | Módulo Recordatorios |
| AURA-58 | AURA-18 | Finalizada | Mateo Romero Plaza | Módulo Recetario |
| AURA-59 | AURA-29 | Finalizada | nicolasrodeyro | Vistas Paciente UI |
| AURA-60 | AURA-29 | Finalizada | nicolasrodeyro | Vistas Terapias UI |
| AURA-61 | AURA-29 | Finalizada | Jeremías Daniel Maldonado Gómez | Vistas Recordatorio UI |
| AURA-62 | AURA-29 | Finalizada | Jeremías Daniel Maldonado Gómez | Vistas Recetario UI |
| AURA-63 | AURA-18 | Finalizada | Haik Kilic | Implementar Conexión entre Care y la BD |
| AURA-64 | AURA-19 | Finalizada | Haik Kilic | Investigación Pulsera para Aurora Band |
| AURA-65 | AURA-29 | Finalizada | Jeremías Daniel Maldonado Gómez | Design System — tokens, componentes y verificación WCAG AA |
| AURA-66 | AURA-29 | Finalizada | Jeremías Daniel Maldonado Gómez | Manual de UX/UI Aurora (11 capítulos) |
| AURA-67 | AURA-29 | Finalizada | Jeremías Daniel Maldonado Gómez | Prototipo navegable de Aurora Care + wiring para Figma |
| AURA-68 | AURA-29 | Finalizada | Mateo Romero Plaza | Vistas Auth y Onboarding UI |
| AURA-69 | AURA-29 | Finalizada | Mateo Romero Plaza | Vistas Alertas y Actividad UI |
| AURA-70 | AURA-29 | Finalizada | nicolasrodeyro | Vistas Ajustes UI |
| AURA-71 | AURA-29 | Finalizada | nicolasrodeyro | Vistas Dispositivo — Aurora Home Display UI |
| AURA-72 | AURA-29 | Finalizada | Mateo Romero Plaza | Vistas Desktop — Aurora Care (1440) UI |
| AURA-73 | AURA-29 | Finalizada | Jeremías Daniel Maldonado Gómez | Wireframes de Visión (V1–V6) |
| AURA-74 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | US-D1 — Sesión guiada de terapia |
| AURA-75 | AURA-18 | Finalizada | Mateo Romero Plaza | US-D2 — Biblioteca de actividades terapéuticas |
| AURA-76 | AURA-15 | En curso | Jeremías Daniel Maldonado Gómez | US-D3 — Descubrimientos con validación |
| AURA-77 | AURA-15 | Finalizada | nicolasrodeyro | US-D4 — Dificultad adaptativa |
| AURA-78 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Registro y perfil del paciente |
| AURA-79 | AURA-18 | Finalizada | Mateo Romero Plaza | Gestión de rutinas y recordatorios (interfaz del cuidador) |
| AURA-80 | AURA-18 | Finalizada | Mateo Romero Plaza | Gestión de medicación y recetario (interfaz del cuidador) |
| AURA-82 | AURA-20 | Finalizada | Haik Kilic | Integración Auth0: autenticación JWT en AuroraCore |
| AURA-83 | AURA-81 | Finalizada | Octavio Escudero | Setup inicial del proyecto AuroraCore (estructura, BD, entorno) |
| AURA-84 | AURA-81 | Finalizada | Octavio Escudero | API REST: CRUD de Paciente (perfil, biografía, preferencias) |
| AURA-85 | AURA-81 | Finalizada | Octavio Escudero | API REST: Dashboard del Cuidador (estado actual del paciente) |
| AURA-86 | AURA-81 | Finalizada | Octavio Escudero | API REST: CRUD de Zonas Seguras (geofencing por paciente) |
| AURA-87 | AURA-17 | Finalizada | Octavio Escudero | API REST: CRUD de Rutinas del Paciente |
| AURA-88 | AURA-17 | Finalizada | Octavio Escudero | API REST: CRUD de Medicación y Recetario del Paciente |
| AURA-89 | AURA-17 | Finalizada | Octavio Escudero | API REST: Registro de Cumplimiento de Rutinas y Toma de Medicación |
| AURA-90 | AURA-14 | Finalizada | Mateo Romero Plaza | AH-M01 - Crear base inicial del repositorio Aurora Home |
| AURA-91 | AURA-14 | Finalizada | Mateo Romero Plaza | AH-M02 - Definir contratos v1 y simulador local Home-Core |
| AURA-92 | AURA-81 | Finalizada | Jeremías Daniel Maldonado Gómez | Deploy de AuroraCareBack en Render (entorno dev) |
| AURA-93 | AURA-20 | Finalizada | Octavio Escudero | ADR formal de cifrado de PII (Ley 25.326) |
| AURA-94 | AURA-81 | Finalizada | Octavio Escudero | Endpoint GET/api/v1/auth/me (perfil del cuidador autenticado) |
| AURA-95 | AURA-14 | Finalizada | Mateo Romero Plaza | AH-M03 — Fundación local resiliente (SQLite, outbox y resiliencia ante reinicios) |
| AURA-96 | AURA-16 | Finalizada | Octavio Escudero | API REST: Acuse de recibo de alertas por el cuidador (endpoint acknowledge) |
| AURA-97 | AURA-78 | Finalizada | Octavio Escudero | Resolucion el mecanismo/ADR formal de cifrado de PII (DNI y nombre) conforme a Ley 25.326, |
| AURA-98 | AURA-78 | Finalizada | Octavio Escudero | Resolucion Back.  una API operativa de consentimiento informado para registrar y consultar consent_records desde el onboarding. |
| AURA-99 | AURA-74 | Finalizada | Haik Kilic | Asistencia Back Aurora-74 |
| AURA-100 | (sin épica) | Finalizada | Haik Kilic | Revisar cambios backend de facture/notifications-aurora vs main |
| AURA-101 | AURA-76 | Finalizada | Octavio Escudero | Implementacion del Backkend |
| AURA-102 | AURA-14 | Finalizada | Haik Kilic | CORE-012 · Normalizar contrato OpenAPI y contract tests de Aurora Home |
| AURA-103 | AURA-14 | Finalizada | Mateo Romero Plaza | HOME-0409 · Ejecutar E2E real de configuración y eventos Aurora Home ↔ Core |
| AURA-104 | AURA-15 | In Revision | Jeremías Daniel Maldonado Gómez | CORE-MEM01 — Schema de memoria contextual del paciente en AuroraCore |
| AURA-105 | AURA-15 | Finalizada | Octavio Escudero | CORE-MEM02 — Endpoint RAG: consulta de contexto del paciente con LLM |
| AURA-106 | AURA-16 | Finalizada | Octavio Escudero | API REST: Envío proactivo de alertas push al cuidador |
| AURA-107 | AURA-18 | Finalizada | Haik Kilic | Vista de alertas en tiempo real — panel del cuidador (AuroraCare) |
| AURA-108 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Conectar pantallas de AuroraCare con endpoints reales de AuroraCore |
| AURA-109 | AURA-20 | In Revision | Jeremías Daniel Maldonado Gómez | Pantalla de Privacidad y datos (Aurora Care) |
| AURA-110 | AURA-18 | Tareas por hacer | — | Inicio muestra «todo en orden» cuando falla la carga del resumen del hogar |
| AURA-111 | AURA-18 | Tareas por hacer | — | «Alerta atendida» muestra datos de demostración en vez del cierre real |
| AURA-112 | AURA-18 | Finalizada | Mateo Romero Plaza | El campo de fecha de nacimiento no funciona en web y no permite tipear |
| AURA-113 | AURA-18 | Finalizada | Mateo Romero Plaza | El selector de etapa de enfermedad es ilegible en modo oscuro |
| AURA-115 | AURA-18 | Finalizada | — | El CRUD de rutinas apunta a una ruta inexistente y la pantalla nunca carga |
| AURA-116 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Layout desktop con sidebar de navegación global |
| AURA-117 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Aislamiento web/native de servicios de plataforma |
| AURA-118 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Botón de llamada al cuidador — implementación real con Linking |
| AURA-120 | AURA-20 | Finalizada | Jeremías Daniel Maldonado Gómez | Control de acceso: /auth/me revocado→403 y write sin hogar→403 |
| AURA-121 | AURA-20 | Finalizada | Jeremías Daniel Maldonado Gómez | Tests de onboarding: buscar por name_hash según ADR-010 (cifrado PII) |
| AURA-122 | AURA-14 | Finalizada | Octavio Escudero | HOME-0409 · Alinear evidencia reproducible y documentación del E2E Home ↔ Core |
| AURA-123 | AURA-14 | Finalizada | Mateo Romero Plaza | HOME-0606 · Consolidar evidencia y cierre del turno conversacional local en runtime |
| AURA-129 | AURA-14 | Finalizada | Octavio Escudero | CORE-004 · Publicar heartbeat autenticado y telemetría mínima para Aurora Home |
| AURA-130 | AURA-14 | Finalizada | Octavio Escudero | CORE-011 · Implementar revocación, reemplazo y rotación segura de Aurora Home |
| AURA-131 | AURA-14 | Finalizada | Octavio Escudero | CORE-007 · Implementar comandos autenticados, ack durable y WSS para Aurora Home |
| AURA-134 | AURA-14 | In Revision | Jeremías Daniel Maldonado Gómez | CORE-010 · Implementar Drop In en vivo (LiveKit) autorizado para Aurora Home |
| AURA-136 | AURA-77 | Finalizada | Octavio Escudero | Backend |
| AURA-137 | AURA-14 | Finalizada | Octavio Escudero | CORE-009 · Publicar planes de terapia y assets versionados para Aurora Home |
| AURA-140 | AURA-139 | Finalizada | Jeremías Daniel Maldonado Gómez | Provisioning y hardening del VPS Hostinger |
| AURA-141 | AURA-139 | Finalizada | Jeremías Daniel Maldonado Gómez | Reverse proxy + TLS + DNS para staging |
| AURA-142 | AURA-139 | Finalizada | Octavio Escudero | Dockerización de AuroraCore |
| AURA-144 | AURA-139 | Finalizada | Octavio Escudero | Stack docker-compose de staging en el VPS |
| AURA-145 | AURA-139 | Finalizada | Jeremías Daniel Maldonado Gómez | n8n self-hosted en el VPS |
| AURA-146 | AURA-139 | Finalizada | Octavio Escudero | Pipeline CD con GitHub Actions (build → GHCR → SSH deploy) |
| AURA-147 | AURA-139 | Tareas por hacer | — | Gestión de secrets y variables de entorno |
| AURA-148 | AURA-139 | Tareas por hacer | — | Backups, monitoreo de recursos y runbook operativo |
| AURA-149 | AURA-17 | Finalizada | Octavio Escudero | Generacion de Interracciones/Sesiones diarias |
| AURA-151 | AURA-14 | Finalizada | Mateo Romero Plaza | HOME-0509 · Componer recordatorios automáticos, respuesta y Outbox en runtime |
| AURA-152 | AURA-14 | Finalizada | Mateo Romero Plaza | PM-2026/HOME-04 · HomeRuntime y systemd |
| AURA-153 | AURA-14 | Finalizada | Mateo Romero Plaza | PM-2026/HOME-05 · Hardware real y diagnósticos |
| AURA-154 | AURA-14 | Finalizada | Mateo Romero Plaza | PM-2026/HOME-06 · Pipeline de voz local |
| AURA-155 | AURA-14 | Finalizada | Mateo Romero Plaza | PM-2026/HOME-07 · Conversación e intenciones locales |
| AURA-156 | AURA-14 | Finalizada | Mateo Romero Plaza | PM-2026/HOME-08 · Recordatorios offline |
| AURA-157 | AURA-81 | Finalizada | Octavio Escudero | CORE-009 · Propuesta de contrato ActivityPlan para Home (requerido por PM-2026/HOME-10) |
| AURA-158 | AURA-14 | Finalizada | Mateo Romero Plaza | Home anuncia dosis vencidas tras un arranque con el reloj sin sincronizar |
| AURA-159 | AURA-14 | Finalizada | Mateo Romero Plaza | Un fallo de captura ALSA a mitad de la escucha dejaba el recordatorio colgado para siempre |
| AURA-160 | (sin épica) | Finalizada | Haik Kilic | [Backend] Registrar ConsentRecord atómicamente en POST /households/setup/ |
| AURA-161 | (sin épica) | Finalizada | Haik Kilic | Optimizacion Carga inicial de paciente - Front |
| AURA-162 | (sin épica) | Finalizada | Octavio Escudero | El alta del hogar tiene que aceptar varios recuerdos iniciales |
| AURA-163 | (sin épica) | Finalizada | Octavio Escudero | Fotos en los recuerdos |
| AURA-164 | (sin épica) | En curso | Haik Kilic | Compliance endpoint sin filtro de fecha: Care infiere "hoy" por paginación y oculta estados reales |
| AURA-165 | AURA-14 | Finalizada | Mateo Romero Plaza | HOME · Publicar heartbeat real hacia Core (consumir CORE-004 / AURA-129) |
| AURA-166 | AURA-14 | Finalizada | Mateo Romero Plaza | HOME · Canal de comandos de Core: WS control, safe mode, rotación de credenciales y ack (consume CORE-011/CORE-007 · AURA-130/AURA-131) |
| AURA-167 | AURA-18 | In Revision | Jeremías Daniel Maldonado Gómez | Módulo de Métricas y Estadísticas (determinista) — Panel del Cuidador |
| AURA-168 | AURA-18 | In Revision | Jeremías Daniel Maldonado Gómez | Módulo de Métricas Inteligentes (insights por IA) — Panel del Cuidador |
| AURA-169 | AURA-20 | Finalizada | Haik Kilic | [Frontend] Enviar el consentimiento en el alta del hogar y confirmar con consent_record |
| AURA-170 | AURA-20 | Finalizada | Haik Kilic | [Backend] Hacer obligatorio consent en POST /households/setup/ |
| AURA-171 | AURA-14 | Finalizada | Mateo Romero Plaza | HOME · Integrar patient-query de Core (memoria del paciente) como responder de conversación |
| AURA-172 | AURA-14 | Finalizada | Octavio Escudero | HOME · Ejecutar sesiones cognitivas diarias de Core y reportar activity.started/completed |
| AURA-173 | AURA-12 | Tareas por hacer | Haik Kilic | El cuidador principal se auto-provisiona sin can_drop_in, bloqueando Drop-in por defecto |
| AURA-174 | AURA-18 | Finalizada | Mateo Romero Plaza | Falta UI en el frontend para autorizar un Aurora Home para Drop-in |
| AURA-175 | AURA-18 | Tareas por hacer | — | Botón «Llamar» del detalle de alerta está siempre deshabilitado |
| AURA-176 | AURA-18 | Tareas por hacer | — | Carga de pantallas con Promise.all cae entera ante falla parcial (migrar a allSettled) |
| AURA-177 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Etiquetas de evento y ánimo aparecen en inglés en el dashboard (enums del back sin traducir) |
| AURA-178 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Duración media de «Asistencia por voz» muestra valor negativo (-18864 min) |
| AURA-179 | AURA-18 | Finalizada | Jeremías Daniel Maldonado Gómez | Onboarding a prueba de errores: no quedar trabado si falta el consentimiento de privacidad |
| AURA-180 | AURA-14 | In Revision | Jeremías Daniel Maldonado Gómez | Acortar cadencia de reconfirmación de recordatorios a 3/5/10 min escalonado |
| AURA-181 | AURA-139 | Finalizada | Jeremías Daniel Maldonado Gómez | Destrabar promoción staging→main: gitleaks, test auth_me y gate de compatibilidad Home |
| AURA-182 | AURA-18 | Finalizada | Mateo Romero Plaza | Pairing en producción: pantalla de WiFi para vincular Aurora Home (AURA-134) |
| AURA-183 | AURA-18 | Finalizada | Mateo Romero Plaza | Conectar la carga de fotos en recuerdos (AuroraCare y Aurora Core) |
| AURA-184 | AURA-81 | Finalizada | Mateo Romero Plaza | Terapias cognitivas: catálogo de la psicopedagoga |
| AURA-185 | AURA-18 | Finalizada | Mateo Romero Plaza | Deploy Staging Frontend |
| AURA-186 | AURA-13 | Finalizada | Mateo Romero Plaza | Actualizar la documentación del proyecto en el Docs y en el repositorio (correcciones de la cátedra del 12/10/2026) |
| AURA-187 | AURA-13 | Tareas por hacer | — | Instancia 5 · Documentación del proceso actualizado post-implementación |
| AURA-188 | AURA-13 | Tareas por hacer | — | Instancia 5 · Instructivos de uso (Aurora Care y Aurora Home) |
| AURA-189 | AURA-13 | Tareas por hacer | — | Instancia 5 · Manual de instalación y operación |
| AURA-190 | AURA-13 | Tareas por hacer | — | Instancia 5 · Análisis de impacto ambiental |
| AURA-191 | AURA-13 | Tareas por hacer | — | Instancia 5 · Retrospectiva de proyecto |
| AURA-192 | AURA-13 | Tareas por hacer | — | Instancia 5 · Presentación y demostración final (05/11) |
| AURA-193 | AURA-18 | In Revision | Mateo Romero Plaza | Reporte de errores de Aurora Care a Aurora Core (sin datos de la persona) |
| AURA-194 | (sin épica) | Finalizada | Octavio Escudero | Taxonomía de dos niveles y anclaje temporal de los recuerdos |
| AURA-195 | AURA-15 | Finalizada | Octavio Escudero | CORE-024 · Endpoint daily-digest y conversión a contribución pendiente |
| AURA-196 | AURA-15 | Finalizada | Octavio Escudero | CORE-025 · payload.daily_memory en el snapshot con anclas configurables |
| AURA-197 | AURA-15 | Finalizada | Octavio Escudero | CORE-026 · Modelo de personas de la vida del paciente |
| AURA-198 | AURA-15 | Finalizada | Octavio Escudero | CORE-027 · Lectura para Care: línea de tiempo con cursor y cobertura biográfica |
| AURA-199 | AURA-15 | Finalizada | Octavio Escudero | CORE-028 · Guardia de sanitización ampliada a nombres de terceros |
| AURA-200 | AURA-15 | Finalizada | Octavio Escudero | CORE-MEM03 · Worker IA: /v1/daily-memory y modelo Memory extendido |
| AURA-201 | AURA-18 | Finalizada | Octavio Escudero | Vista de línea de tiempo de recuerdos (Aurora Care) |
| AURA-202 | AURA-18 | Finalizada | Octavio Escudero | Ficha de persona y validación uno a uno de recuerdos (Aurora Care) |
| AURA-203 | AURA-14 | Finalizada | Octavio Escudero | HOME-20 · Buffer de corto plazo, digest diario y anclas configurables |
| AURA-204 | AURA-13 | In Revision | Octavio Escudero | Formalizar los ADR y las historias de usuario de recuerdos en el vault de Obsidian |
| AURA-205 | AURA-18 | Finalizada | Mateo Romero Plaza | Celular del paciente: vinculación por código y credencial de dispositivo |
| AURA-206 | AURA-18 | Finalizada | Mateo Romero Plaza | Modo paciente: juegos y actividades cognitivas desde el celular vinculado |
| AURA-207 | AURA-18 | In Revision | Mateo Romero Plaza | Botón "Necesito ayuda" del paciente con ubicación puntual y consentimiento |
| AURA-208 | AURA-18 | Finalizada | Mateo Romero Plaza | Zonas seguras en Aurora Care: pantalla de zonas y cobertura real del aviso |
| AURA-209 | AURA-18 | Finalizada | Mateo Romero Plaza | Seguridad: GeofenceZoneViewSet no verificaba el hogar al listar/leer/activar zonas |
| AURA-210 | AURA-18 | Finalizada | Mateo Romero Plaza | CORE: ubicación en vivo del celular y detección de salida de zona en el servidor |
| AURA-211 | AURA-18 | Finalizada | Mateo Romero Plaza | CARE: ubicación en vivo en segundo plano en el celular del paciente |
| AURA-212 | AURA-18 | Finalizada | Mateo Romero Plaza | CARE: pantalla "Dónde está" para ver la ubicación del paciente |
| AURA-213 | AURA-18 | Tareas por hacer | Mateo Romero Plaza | CORE: alerta "Perdimos la señal del celular" (barrido de silencio) y programarlo en n8n |
| AURA-214 | AURA-18 | In Revision | Mateo Romero Plaza | Despliegue y QA en celulares reales de la ubicación en vivo |
| AURA-215 | AURA-18 | Tareas por hacer | Mateo Romero Plaza | Validación legal de los consentimientos y encuadre documental de ubicación y geofencing |
| AURA-216 | AURA-18 | In Revision | Mateo Romero Plaza | Celular del paciente: mejora de juegos y terapias (Fases 0 a 4) — contenido, juegos nuevos, sonido suave y seguimiento del cuidador |
| AURA-217 | AURA-18 | Tareas por hacer | — | Validar con psicopedagoga las frases de la Fase 4 de razonamiento guiado |
| AURA-218 | AURA-18 | Tareas por hacer | — | Care: UI de preguntas abiertas en terapias (fase posterior razonamiento guiado) |
| AURA-219 | AURA-15 | Tareas por hacer | — | Validar en la Pi el fix de selección de contexto RAG (PR #145) |
| AURA-220 | AURA-13 | Tareas por hacer | — | Cerrar y archivar 5 changes de openspec ya entregados (verificar tareas restantes) |

