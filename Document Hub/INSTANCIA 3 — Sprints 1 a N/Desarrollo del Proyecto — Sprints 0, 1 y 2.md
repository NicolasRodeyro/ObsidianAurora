---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-18
---

# Desarrollo del Proyecto Aurora

## Introducción

Este documento presenta el desarrollo del proyecto Aurora entre abril y noviembre de 2026, organizado por sprint, como pide la Instancia 3 de la guía de documentación de la cátedra. Para cada sprint se incluye su informe (objetivo, Sprint Backlog con la capacidad asumida, Sprint Review, métricas con análisis de tendencia, retrospectiva, backlog repriorizado y riesgos), el desarrollo técnico realizado y los artefactos de trazabilidad de sus historias (decisiones de diseño, modelo de datos, diagramas, código y casos de prueba). Al final se reúnen el registro de riesgos, el estado consolidado del período y el trabajo pendiente.

El equipo trabaja con Scrum, en sprints planificados de 3 semanas, y mide cada sprint con las métricas definidas en el Plan de Proyecto: cumplimiento del sprint, desvío de cierre, carga por integrante, trabajo arrastrado, incidencias abiertas, calidad del código y mejora del proceso.

## Audiencia

Está dirigido a los docentes de la cátedra, para evaluar el proceso además del producto, y al propio equipo, para mejorar. Se asume conocimiento del Plan de Proyecto Aurora, del documento de Arquitectura y Stack Tecnológico y del Plan de Testing de este mismo documento.

## Equipo y capacidad

| **Persona** | **Roles** | **Capacidad semanal** |
| --- | --- | --- |
| Haik Kilic Aslan | Backend, Backend del Worker IA, Analista funcional, Product Owner | 18 h |
| Nicolás Rodeyro Contarino | Frontend, Base de datos, Diseño UX/UI | 22 h |
| Mateo Romero Plaza | Frontend, Base de datos, Aurora Home, Analista funcional | 16 h |
| Octavio Escudero | Backend, Backend del Worker IA, Aurora Home | 15 h |
| Jeremías Maldonado Gómez | Project Manager, DevOps, Diseño UX/UI, Scrum Master | 13 h |

La capacidad declarada del equipo es de 84 horas por semana: 252 horas en un sprint de 3 semanas, o unas 202 horas si se descuenta el 20 % de margen para imprevistos que fija el Plan de Proyecto. Los tickets no se estimaron en horas durante el desarrollo; por eso las métricas de carga se expresan como la distribución de tickets frente a la distribución de la capacidad. La sponsor del proyecto es Virginia Santos; el cierre de la ejecución fue el 05/10/2026 y la entrega final es el 05/11/2026.

## Numeración de los sprints y equivalencia con Jira

La gestión de los sprints en Jira fue irregular y su numeración no coincide con la de la documentación. El «Sprint 3» de Jira se abrió y se cerró sin tickets, y el «Sprint 2» de Jira se mantuvo abierto hasta el 02/08/2026. Para evitar confusiones, este documento usa la numeración propia del proyecto, que sigue el calendario real del trabajo, e indica en cada sprint la iteración de Jira que le corresponde.

| **Sprint** | **Iteración de Jira** | **Período planificado** | **Cierre real** | **Trabajo principal** |
| --- | --- | --- | --- | --- |
| Sprint 0 | «SCRUM Sprint 0» (dos iteraciones) | 21/04 a 26/05 | 07/06 | Definición y puesta en marcha, sin código |
| Sprint 1 | «SCRUM Sprint 2» | 17/06 a 08/07 | 02/08 | Modelo de datos y primeras pantallas de Aurora Care |
| Sprint 2 | «SCRUM Sprint 3» (sin tickets) | 08/07 a 04/08 | 04/08 | Diseño de producto y arranque de los repositorios de código |
| Sprint 3 | «SCRUM Sprint 4» | 04/08 a 25/08 | 28/08 | Backend operativo y base de Aurora Home |
| Sprint 4 | «SCRUM Sprint 5» | 27/08 a 16/09 | 17/09 | Aurora Home con voz local, memoria del paciente y alertas |
| Sprint 5 | «SCRUM Sprint 6» | 16/09 a 07/10 | 14/10 | MVP en staging de punta a punta |
| Sprint 6 | «SCRUM Sprint 7» | 14/10 a 05/11 | en curso | Cierre del MVP y entrega final |

La inconsistencia de la numeración y los sprints que se estiran son en sí mismos hallazgos de proceso, y se analizan en la sección «Estado consolidado y tendencias».

## Stack tecnológico del ecosistema

El ecosistema Aurora se compone de cuatro componentes de producto (Aurora Home, Aurora Care, Aurora Core y Aurora Worker IA); Aurora Band quedó fuera del MVP. El stack se definió en el Sprint 0 (ver documento "Arquitectura y Stack Tecnológico", 12 ADR).

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


## Mapa del desarrollo

Cada sprint tiene su informe y los artefactos de trazabilidad de sus historias en su carpeta. La numeración es la del proyecto (ver la equivalencia con Jira arriba).

| Sprint | Informe | Artefactos de trazabilidad |
| --- | --- | --- |
| Sprint 0 — Fundación | [[Informe Sprint 0]] | No aplica (sin código de producto) |
| Sprint 1 — Modelo de datos y primeras pantallas | [[Informe Sprint 1]] | `Sprint 1/AURA-54` a `AURA-58` |
| Sprint 2 — Diseño de producto y arranque del código | [[Informe Sprint 2]] | Investigaciones del sprint (ver abajo) |
| Sprint 3 — Backend operativo y base de Aurora Home | [[Informe Sprint 3]] | `Sprint 3/AURA-82`, `84`, `87`, `88`, `89`, `90-95` y [[Historias de producto AURA-74 a 80]] |
| Sprint 4 — Aurora Home local, memoria y alertas | [[Informe Sprint 4]] | `Sprint 4/AURA-77`, `85`, `86`, `151-156` y [[Decisión de Alcance — Aurora Band fuera del MVP]] |
| Sprint 5 — MVP en staging de punta a punta | [[Informe Sprint 5]] | `Sprint 5/AURA-98`, `105`, `106`, `131`, `134`, `149` y `163` |
| Sprint 6 — Cierre del MVP y entrega final (en curso) | [[Informe Sprint 6]] | Previstos al cierre |

Documentos transversales: [[Registro de Riesgos]], [[Estado consolidado y tendencias]], [[Trabajo pendiente y próximos pasos]] y [[Anexos del desarrollo del proyecto]]. Investigaciones del período: [[Investigación — Almacenamiento de Datos y Ley 25.326]] e [[Investigación — Despliegue e Infraestructura]].

> [!note] Espejo en el Google Doc
> Este conjunto de documentos se publica unificado en el Google Doc del proyecto, que es lo que ve la docente. Cualquier cambio acá debe reflejarse allí.
>
> La versión del Doc es la **compacta** (19/10/2026): en las fichas de trazabilidad no repite el párrafo «Para qué», el checklist de completitud, las notas al pie de ejecución ni los diagramas que no aplican, y reemplaza el mini-DER por la lista de entidades. Las fichas de este vault conservan el detalle completo.
>
> Del mismo modo, las dos investigaciones del Sprint 2 ([[Investigación — Almacenamiento de Datos y Ley 25.326]] e [[Investigación — Despliegue e Infraestructura]]) figuran en el Doc como síntesis de una página cada una; el texto completo está en la pestaña «Anexos» del Doc (Anexos C y D) y acá en el vault. En el Estudio Inicial del Doc, los esquemas AS-IS/TO-BE aparecen una sola vez, en el «Mapa global de procesos del Entorno».
