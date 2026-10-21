---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: "2026-10-17T00:00:00"
---
# Historias de producto AURA-74 a AURA-80: dónde está su trazabilidad

Las historias AURA-74 a AURA-80 se escribieron el 18/07/2026, antes de que existiera el código, y se tomaron en el Sprint 3. Son historias de producto que se resuelven con trabajo repartido entre varios sprints, por eso su trazabilidad (decisiones, modelo de datos, diagramas, código y pruebas) vive en los artefactos de las historias técnicas que las implementan, y no en un artefacto aparte. La tabla indica dónde buscar cada una. En la columna de estado, «Finalizada (Sprint N)» es el sprint en que la historia pasó a Finalizada en Jira (cierre administrativo), que puede ser posterior al sprint en que se terminó el código.

| Historia | Estado | Dónde está su trazabilidad |
| --- | --- | --- |
| AURA-74 — Sesión guiada de terapia | Finalizada (cerrada el 17/10 en el Sprint 6, al depurar el tablero) | Módulo de Terapias de Aurora Care: artefacto de AURA-56 (Sprint 1). Sesiones diarias generadas por Core y ejecutadas por Aurora Home: artefacto de AURA-149 (Sprint 5) |
| AURA-75 — Biblioteca de actividades terapéuticas | Finalizada (Sprint 3) | Módulo de Terapias: artefacto de AURA-56 (Sprint 1). Catálogo de terapias validado por la psicopedagoga: artefacto de AURA-149 (Sprint 5) |
| AURA-76 — Descubrimientos con validación | En curso | Falta demostrarla; su artefacto se completa cuando se cierre |
| AURA-77 — Dificultad adaptativa | Finalizada (cerrada en el Sprint 5; el código se terminó en el Sprint 4) | Artefacto de AURA-77 (Sprint 4) |
| AURA-78 — Registro y perfil del paciente | Finalizada (cerrada el 17/10 en el Sprint 6, al depurar el tablero) | Módulo Paciente de Aurora Care: artefacto de AURA-55 (Sprint 1). API de paciente: artefacto de AURA-84 (Sprint 3). Consentimiento informado: artefacto de AURA-98 (Sprint 5) |
| AURA-79 — Gestión de rutinas y recordatorios | Finalizada (Sprint 3) | Módulo de Rutinas de Aurora Care: artefacto de AURA-57 (Sprint 1). API de rutinas y cumplimiento: artefactos de AURA-87 y AURA-89 (Sprint 3) |
| AURA-80 — Gestión de medicación y recetario | Finalizada (Sprint 3) | Módulo de Medicación de Aurora Care: artefacto de AURA-58 (Sprint 1). API de medicación y cumplimiento: artefactos de AURA-88 y AURA-89 (Sprint 3) |

> [!note] Otras historias del sprint
> - **AURA-83** (setup inicial de Aurora Core) es la estructura del proyecto del backend y no tiene lógica de dominio propia; se describe en el desarrollo técnico del sprint.
> - **AURA-85 y AURA-86** (dashboard del cuidador y zonas seguras) se terminaron en el Sprint 4 y tienen su artefacto en ese sprint.
> - **AURA-96** (acuse de recibo de alertas) está cubierta por el artefacto de AURA-106 (alertas push y en tiempo real, Sprint 5).
