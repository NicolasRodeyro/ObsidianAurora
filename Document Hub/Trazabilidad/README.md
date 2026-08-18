---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-06-19T19:40:00
---
# Trazabilidad — Artefactos por Historia

Esta carpeta contiene un **artefacto de trazabilidad por Historia de Usuario** (formato de la cátedra): conecta cada historia con sus decisiones de diseño (ADR), modelo de datos (DER), diagramas de modelado, código y casos de prueba.

- Generar cada artefacto con la skill **`/artefacto-trazabilidad`** (en `ObsidianAurora/.claude/skills/`; abrir Claude Code parado en `ObsidianAurora/` para que quede registrada).
- Nomenclatura: `<KEY> - <título>.md` (ej. `AURA-78 - Registro y perfil del paciente.md`).
- Para la trazabilidad a nivel **requerimiento → épica**, ver [[Trazabilidad RF-Épicas]].

## Artefactos existentes
- [[AURA-74 - Sesión guiada de terapia]] — AURA-74 (US-D1) · épica AURA-18
- [[AURA-78 - Registro y perfil del paciente]] — AURA-78 · épica AURA-18 (formaliza la US 1.1 de ejemplo)
- [[AURA-79 - Gestión de rutinas y recordatorios]] — AURA-79 · épica AURA-18
- [[AURA-80 - Gestión de medicación y recetario]] — AURA-80 · épica AURA-18

> Los 4 tienen el diseño trazado; código y ejecución de pruebas quedan como scaffolding hasta que exista implementación (`Backend/`, `Frontend/`). El archivo `US 1.1 - … (EJEMPLO).md` quedó **superado** por AURA-78 (puede archivarse).
