---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-07-18T12:00:00
---
# Tablero Jira — Proyecto AURA (snapshot)

Snapshot legible del board de Jira para consulta rápida y trazabilidad. El espejo machine-readable está en `jira/snapshot.json`. Cómo refrescar: ver [[CLAUDE]].

> **Sitio:** project-aurora-alz.atlassian.net · **Proyecto:** AURA · **Último sync:** 2026-07-19 · **75 issues** (17 épicas · 47 tareas · 7 historias · 4 análisis).
> Relacionados: [[Índice Aurora]] · [[Trazabilidad RF-Épicas]] · [[Requerimientos]] · [[Diseño UX-UI/Handoff y Backlog de Diseño|Handoff de Diseño]].

## Épicas de producto (9)

| Épica | Nombre | Componente | RF | Scope |
| --- | --- | --- | --- | --- |
| AURA-14 | Interacción y Asistencia por Voz | Aurora Home | RF-01–14 | `mvp` |
| AURA-19 | Monitoreo Biométrico | Aurora Band | RF-15–23 | `mvp` |
| AURA-22 | Detección de Eventos y Riesgos | Aurora Core | RF-24–35 | `mvp` |
| AURA-16 | Alertas y Comunicación con el Cuidador | Aurora Core/Care | RF-36–46 | `mvp` |
| AURA-15 | Motor de IA y Memoria del Paciente | Aurora Core | RF-47–54 | `mvp` |
| AURA-21 | Orquestación y Automatización | Aurora Core (n8n) | RF-55–59 | `vision` |
| AURA-18 | Panel del Cuidador (Aurora Care) | Aurora Care | RF-60–75 | `mvp` |
| AURA-20 | Seguridad, Privacidad y Cumplimiento | Transversal | RF-76–81 | `mvp` |
| AURA-17 | Administración de Rutinas y Medicación | Aurora Care/Core | RF-82–91 | `mvp` |

## Épicas de gestión (5)

| Épica | Nombre | Labels | Tareas hijas |
| --- | --- | --- | --- |
| AURA-12 | Configuraciones Iniciales | `gestion` `sprint-0` | 8 |
| AURA-13 | Documentación para Proyecto | `gestion` | 16 |
| AURA-28 | Requerimientos Funcionales y No Funcionales | `gestion` | 2 |
| AURA-29 | Branding Inicial y UX | `gestion` `diseno` | 14 |
| AURA-31 | Automatización IA (tooling) | `gestion` `tooling` | 2 |

> **AURA-29 (Diseño)** pasó de 1 a 14 hijas: el trabajo de diseño (design system, manual UX/UI, prototipo, vistas MVP y wireframes de visión) quedó ticketeado y en `In Revision`. Detalle en [[Diseño UX-UI/Handoff y Backlog de Diseño|Handoff de Diseño]].

## Épicas deprecadas (cerradas — pendientes de borrado manual)

| Épica | Nombre |
| --- | --- |
| AURA-23 | [OBSOLETA] Detección de comportamiento anómalo → AURA-22 |
| AURA-24 | [OBSOLETA] Detección de estados fisiológicos/emocionales → AURA-22 |
| AURA-25 | [OBSOLETA] Sistema de geolocalización inteligente → AURA-22 |

## Tareas, historias y análisis (por key)

| Issue | Épica | Estado | Responsable | Resumen |
| --- | --- | --- | --- | --- |
| AURA-1 | AURA-12 | Finalizada | Mateo | Terminar de definir el alcance del proyecto |
| AURA-2 | AURA-12 | Finalizada | Mateo | Terminar de definir funcionalidades del sistema |
| AURA-5 | AURA-12 | Finalizada | Octavio | Definir arquitectura del proyecto |
| AURA-6 | AURA-12 | Finalizada | Haik | (Análisis) Investigar sobre demencia y enfermedades similares |
| AURA-7 | AURA-12 | Finalizada | Jeremías | (Análisis) Contacto con profesional - Parte 1 |
| AURA-8 | AURA-12 | In Revision | Jeremías | Definir las Épicas |
| AURA-9 | AURA-12 | Finalizada | Nicolás | Crear y configurar repos de GitHub |
| AURA-10 | AURA-12 | Finalizada | Octavio | Definir roles y horas por semana por miembro |
| AURA-26 | AURA-28 | Finalizada | Mateo | Documento de objetivo y funcionalidades |
| AURA-27 | AURA-29 | Finalizada | Nicolás | Definir branding |
| AURA-30 | AURA-31 | En curso | Haik | Skills/rules para diseño - Parte 1 |
| AURA-32 | AURA-13 | Finalizada | Jeremías | Crear Project Charter / Plan de Proyecto |
| AURA-33 | AURA-13 | Finalizada | Haik | Crear documento Working Agreement |
| AURA-34 | AURA-13 | Finalizada | Nicolás | Crear documento de Gestión de la Configuración |
| AURA-35 | AURA-13 | Finalizada | Octavio | Definir documento de Arquitectura y Stack Tecnológico |
| AURA-36 | AURA-13 | Finalizada | Haik | Definir documento de Plan de Testing |
| AURA-37 | AURA-13 | Finalizada | Nicolás | Definir User Story Mapping |
| AURA-38 | AURA-13 | Finalizada | Jeremías | Definir Backlog Inicial |
| AURA-41 | AURA-13 | In Revision | Jeremías | Implementación de Informe de Sprint |
| AURA-42 | AURA-13 | In Revision | Jeremías | Definición de Artefactos de Trazabilidad |
| AURA-43 | AURA-13 | En curso | Jeremías | Revisar granularidad del WBS (Gantt/calendario) |
| AURA-44 | AURA-28 | Finalizada | Haik | Revisar correcciones de requerimientos funcionales y no funcionales |
| AURA-45 | AURA-13 | Finalizada | Mateo | Agregar flujo de fondos |
| AURA-46 | AURA-13 | Finalizada | Octavio | Agregar cronograma |
| AURA-47 | AURA-13 | Tareas por hacer | Nicolás | Agregar US |
| AURA-48 | (sin épica) | Finalizada | — | Agregar glosario general del proyecto |
| AURA-49 | AURA-13 | Finalizada | Octavio | Mejorar presentación del análisis de costos |
| AURA-50 | AURA-13 | Finalizada | Mateo | Crear glosario en el documento de entrega a la profe |
| AURA-51 | AURA-13 | Finalizada | Haik | (Análisis) Investigar carrito de compras para prototipo de Aurora Home |
| AURA-52 | AURA-31 | In Revision | Jeremías | Sub RAG para flujo de información entre Jira y Obsidian |
| AURA-53 | AURA-15 | Finalizada | Mateo | Diseño de BD |
| AURA-54 | AURA-18 | Tareas por hacer | Octavio | Login - Aurora Care · _diseño listo (AURA-68), impl pendiente_ |
| AURA-55 | AURA-18 | Tareas por hacer | Nicolás | Módulo Paciente - Aurora Care · _diseño listo (AURA-59), impl pendiente_ |
| AURA-56 | AURA-18 | En curso | Nicolás | Módulo Terapias Cognitivas · _diseño listo (AURA-60), impl pendiente_ |
| AURA-57 | AURA-18 | Tareas por hacer | Nicolás | Módulo Recordatorios · _diseño listo (AURA-61), impl pendiente_ |
| AURA-58 | AURA-18 | Tareas por hacer | Octavio | Módulo Recetario · _diseño listo (AURA-62), impl pendiente_ |
| AURA-59 | AURA-29 | In Revision | Nicolás | Vistas Paciente UI ✅ diseño |
| AURA-60 | AURA-29 | In Revision | Nicolás | Vistas Terapias UI ✅ diseño |
| AURA-61 | AURA-29 | In Revision | Jeremías | Vistas Recordatorio UI ✅ diseño |
| AURA-62 | AURA-29 | In Revision | Jeremías | Vistas Recetario UI ✅ diseño |
| AURA-63 | AURA-18 | PAUSED/BLOCKED | Haik | Implementar conexión entre Care y la BD |
| AURA-64 | AURA-19 | En curso | Haik | (Análisis) Investigación pulsera para Aurora Band |
| AURA-65 | AURA-29 | In Revision | — | Design System — tokens, componentes y verificación WCAG AA ✅ |
| AURA-66 | AURA-29 | In Revision | — | Manual de UX/UI Aurora (11 capítulos) ✅ |
| AURA-67 | AURA-29 | In Revision | — | Prototipo navegable de Aurora Care + wiring para Figma ✅ |
| AURA-68 | AURA-29 | In Revision | — | Vistas Auth y Onboarding UI ✅ diseño |
| AURA-69 | AURA-29 | In Revision | — | Vistas Alertas y Actividad UI ✅ diseño |
| AURA-70 | AURA-29 | In Revision | — | Vistas Ajustes UI ✅ diseño |
| AURA-71 | AURA-29 | In Revision | — | Vistas Dispositivo — Aurora Home Display UI ✅ diseño |
| AURA-72 | AURA-29 | In Revision | — | Vistas Desktop — Aurora Care (1440) UI ✅ diseño |
| AURA-73 | AURA-29 | In Revision | — | Wireframes de Visión (V1–V6) ✅ lo-fi |
| AURA-74 | AURA-18 | Tareas por hacer | — | (Historia) US-D1 — Sesión guiada de terapia |
| AURA-75 | AURA-18 | Tareas por hacer | — | (Historia) US-D2 — Biblioteca de actividades terapéuticas |
| AURA-76 | AURA-15 | Tareas por hacer | — | (Historia) US-D3 — Descubrimientos con validación |
| AURA-77 | AURA-15 | Tareas por hacer | — | (Historia) US-D4 — Dificultad adaptativa |
| AURA-78 | AURA-18 | Tareas por hacer | — | (Historia) Registro y perfil del paciente · trazabilidad ✅ |
| AURA-79 | AURA-18 | Tareas por hacer | — | (Historia) Gestión de rutinas y recordatorios · trazabilidad ✅ |
| AURA-80 | AURA-18 | Tareas por hacer | — | (Historia) Gestión de medicación y recetario · trazabilidad ✅ |
