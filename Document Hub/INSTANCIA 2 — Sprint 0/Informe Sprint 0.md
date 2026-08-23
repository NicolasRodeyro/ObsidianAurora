---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
sprint: 0
jira_sprint: "SCRUM Sprint 0 (ids 1 y 2)"
fecha_inicio: "2026-04-21"
fecha_cierre: "2026-06-07"
tipo: informe-sprint
---

# Informe de Sprint 0 — Fundación

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 0 (aparece dividido en dos iteraciones: id 2 y id 1) |
| Inicio | 2026-04-21 |
| Cierre real | 2026-06-07 |
| Goal | "Ponernos de acuerdo y configurar todo" → "Comenzar el proyecto a full" |

> [!note] Nota sobre la trazabilidad de sprints
> La gestión de sprints en Jira durante el arranque fue irregular: "Sprint 0" figura como **dos iteraciones** distintas y varios de estos tickets de fundación aparecen luego **reasignados a sprints posteriores** por arrastre. Este informe los consolida por su naturaleza (trabajo fundacional) y por la ubicación de sus entregables en `INSTANCIA 1` y `INSTANCIA 2`. La inconsistencia es en sí un hallazgo para la [[Mega Retro Sprints 0-2]].

## Equipo

| Persona | Roles |
| --- | --- |
| Jeremías Maldonado Gómez | PM · DevOps · UX/UI |
| Mateo Romero Plaza | Backend · DBA · Analista Funcional |
| Haik Kilic Aslan | Backend · Analista Funcional |
| Nicolás Rodeyro Contarino | UX/UI · DBA · AI · Frontend |
| Octavio Escudero | DevOps · Frontend · QA |

## Tickets completados

| Key | Tipo | Resumen |
|---|---|---|
| AURA-1 | Tarea | Definir el Alcance del Proyecto |
| AURA-2 | Tarea | Definir Funcionalidades del Sistema |
| AURA-5 | Tarea | Definir Arquitectura del Proyecto |
| AURA-6 | Análisis | Investigar sobre Demencia y enfermedades similares |
| AURA-7 | Análisis | Contacto con Profesional - Parte 1 |
| AURA-8 | Tarea | Definir las Épicas (9 épicas de producto ↔ 9 módulos) |
| AURA-9 | Tarea | Crear y Configurar Repos de GitHub |
| AURA-10 | Tarea | Definir Roles y Tiempo por semana por miembro |
| AURA-26 | Tarea | Documento de Objetivo y Funcionalidades |
| AURA-27 | Tarea | Definir Branding |
| AURA-32 | Tarea | Project Charter / Plan de Proyecto |
| AURA-33 | Tarea | Working Agreement |
| AURA-34 | Tarea | Gestión de la Configuración |
| AURA-35 | Tarea | Arquitectura y Stack Tecnológico |
| AURA-36 | Tarea | Plan de Testing |
| AURA-37 | Tarea | User Story Mapping |
| AURA-38 | Tarea | Backlog Inicial |

## Artefactos producidos

- [[Project Charter]] (AURA-32)
- [[Working Agreement]] (AURA-33)
- [[Gestion de la Configuracion]] (AURA-34)
- [[Arquitectura y Stack Tecnológico]] (AURA-35) — modelo C4 + 9 ADRs
- [[Plan de Testing]] (AURA-36)
- [[User Story Map]] (AURA-37)
- [[Product Backlog Inicial]] (AURA-38)
- [[Requerimientos]] — 91 RF + 43 RNF en 9 módulos
- [[Estudio Inicial Aurora]], [[Investigacion sobre neurologia]]

## Hitos y decisiones

- Definición de las **9 épicas de producto** alineadas 1:1 con los 9 módulos funcionales (AURA-8)
- Elección de **stack**: Python/Django-DRF · React Native + Expo · Supabase (PostgreSQL + pgvector) · Auth0 · n8n · Whisper.cpp
- Creación de los **5 repositorios** (AuroraCore, AuroraCareBack, AuroraCareFront, AuroraHome, ObsidianAurora)
- **Deprecación** de las épicas AURA-23/24/25 (absorbidas por AURA-22 por solapamiento)

## Retrospectiva

> [!info] La retrospectiva de este sprint se consolidó en la **[[Mega Retro Sprints 0-2]]** (retro combinada de los 3 sprints). Ver ahí hallazgos, aprendizajes y acciones.
