---
sprint: 2
jira_sprint: "Sprint activo (abierto)"
fecha_inicio: "2026-07-08"
fecha_fin_planificada: "2026-07-29"
fecha_cierre: null
tipo: informe-sprint
---

# Informe de Sprint 2

| Campo | Valor |
|---|---|
| Sprint Jira | Sprint activo — abierto al 2026-08-23 |
| Inicio | ~2026-07-08 |
| Fin planificado | ~2026-07-29 |
| Cierre real | *en curso* |
| Goal | *(completar interfaces y arrancar backend)* |

## Equipo

> [!todo] Completar con los integrantes que participaron activamente en este sprint y sus roles.

## Tickets finalizados

| Key | Tipo | Resumen |
|---|---|---|
| AURA-82 | Historia | Integración Auth0: autenticación JWT en AuroraCore → [[Trazabilidad/AURA-82 - Integración Auth0\|artefacto]] *(pendiente)* |
| AURA-87 | Historia | API REST: CRUD de Rutinas del Paciente |
| AURA-88 | Historia | API REST: CRUD de Medicación y Recetario del Paciente |
| AURA-89 | Historia | API REST: Registro de Cumplimiento |
| AURA-90 | Tarea | AH-M01 — Base inicial repositorio Aurora Home |
| AURA-91 | Tarea | AH-M02 — Contratos v1 y simulador Home-Core |

## Tickets en curso

| Key | Tipo | Resumen |
|---|---|---|
| AURA-64 | Análisis | Investigación Pulsera Aurora Band *(arrastrado de Sprint 1)* |
| AURA-74 | Historia | US-D1 — Sesión guiada de terapia → [[Trazabilidad/AURA-74 - Sesión guiada de terapia\|artefacto]] |
| AURA-75 | Historia | US-D2 — Biblioteca de actividades terapéuticas → [[Trazabilidad/AURA-75 - Biblioteca de actividades terapéuticas\|artefacto]] |
| AURA-78 | Historia | Registro y perfil del paciente → [[Trazabilidad/AURA-78 - Registro y perfil del paciente\|artefacto]] |
| AURA-79 | Historia | Gestión de rutinas y recordatorios → [[Trazabilidad/AURA-79 - Gestión de rutinas y recordatorios\|artefacto]] |
| AURA-80 | Historia | Gestión de medicación y recetario → [[Trazabilidad/AURA-80 - Gestión de medicación y recetario\|artefacto]] |
| AURA-95 | Tarea | AH-M03 — Fundación local resiliente (SQLite, outbox, resiliencia) |

## Tickets pendientes (plannificados, sin iniciar)

| Key | Tipo | Resumen |
|---|---|---|
| AURA-83 | Historia | Setup inicial AuroraCore |
| AURA-84 | Historia | API REST: CRUD de Paciente |
| AURA-85 | Historia | API REST: Dashboard del Cuidador |
| AURA-86 | Historia | API REST: CRUD Zonas Seguras (geofencing) |
| AURA-92 | Tarea | Deploy AuroraCareBack en Render (dev) |
| AURA-93 | Tarea | ADR formal de cifrado de PII (Ley 25.326) |
| AURA-94 | Tarea | Endpoint GET /api/me |
| AURA-96 | Historia | API REST: Acuse de recibo de alertas (acknowledge) |

## Bloqueados

| Key | Estado | Desbloquea con |
|---|---|---|
| AURA-63 | PAUSED/BLOCKED | Conexión Care ↔ BD — desbloquea con AURA-82 ✅ + AURA-83 |

## Artefactos de trazabilidad producidos en este sprint

- [[Trazabilidad/AURA-74 - Sesión guiada de terapia|AURA-74 — US-D1 Sesión guiada de terapia]]
- [[Trazabilidad/AURA-75 - Biblioteca de actividades terapéuticas|AURA-75 — US-D2 Biblioteca de actividades]]
- [[Trazabilidad/AURA-76 - descubrimientos-con-validacion|AURA-76 — US-D3 Descubrimientos con validación]]
- [[Trazabilidad/AURA-77 - Dificultad Adaptativa|AURA-77 — US-D4 Dificultad adaptativa]]
- [[Trazabilidad/AURA-78 - Registro y perfil del paciente|AURA-78 — Registro y perfil del paciente]]
- [[Trazabilidad/AURA-79 - Gestión de rutinas y recordatorios|AURA-79 — Rutinas y recordatorios]]
- [[Trazabilidad/AURA-80 - Gestión de medicación y recetario|AURA-80 — Medicación y recetario]]
- [[INSTANCIA 3 — Sprints 1 a N/Investigación — Almacenamiento de Datos y Ley 25.326|Investigación Ley 25.326]]
- [[INSTANCIA 3 — Sprints 1 a N/Investigación — Despliegue e Infraestructura|Investigación Infraestructura]]

## Retrospectiva

> [!todo] Completar al cierre del sprint con:
> - **Qué salió bien**
> - **Qué mejorar**
> - **Impedimentos** encontrados
> - **Velocidad real** vs planificada
