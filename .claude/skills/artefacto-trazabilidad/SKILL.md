---
name: artefacto-trazabilidad
description: Genera el "artefacto de trazabilidad" de una historia del backlog de Aurora en el formato que pide la cátedra (conecta la historia con sus decisiones de diseño/ADR, modelo de datos/DER, diagramas de modelado, código y casos de prueba con resultados). Recopila lo que ya exista en el repo y en Jira y deja scaffolding de lo faltante; no inventa. Salida en markdown bajo Document Hub/Trazabilidad/ y resumen/enlace en el ticket de Jira. Usar cuando el usuario pida "artefacto de trazabilidad", "trazabilidad de la historia/US", "documentar/trazar la historia AURA-XX", "artefacto de la historia".
version: 0.1.0
---

# Skill: artefacto-trazabilidad

Genera el **artefacto de trazabilidad** de una Historia de Usuario del proyecto Aurora, en el formato exigido por la cátedra (UTN-FRC). El artefacto conecta cada historia con sus **decisiones de diseño (ADR)**, **modelo de datos (DER)**, **diagramas de modelado** (clases / secuencia / estados), **código** y **casos de prueba** (precondición, pasos, resultado esperado y resultado de ejecución).

Principio de operación: **recopilar lo que ya exista** (Jira, ADRs, código, tests, git) y dejar un **scaffolding** claro —checklist + placeholders marcados— de lo que el equipo debe completar. **No inventar** resultados de pruebas, ADRs ni código que no existan.

> La definición completa de la cátedra, la guía por sección, el cheatsheet de Mermaid y el formato de casos de prueba están en `references/guia-catedra.md`. La estructura del documento de salida está en `assets/plantilla-artefacto.md`.

## Cómo usar

```
/artefacto-trazabilidad
→ "generá el artefacto de trazabilidad de AURA-60"
→ "trazabilidad de esta historia: <pego la historia>"
→ "documentá la historia del archivo docs/historia-login.md"
```

Acepta dos modos de entrada: **key de Jira** (ej. `AURA-60`) o **historia manual/archivo**. Si no se indica la historia, preguntar cuál documentar.

## Proceso

### Paso 1 — Identificar la historia
- **Key de Jira** (`AURA-XX`): traer la historia con `mcp__atlassian__getJiraIssue` (cloudId y proyecto en `CLAUDE.md`), campos `["summary","description","issuetype","status","parent","labels","comment"]`, formato markdown. Tomar título, descripción, criterios de aceptación, épica padre.
- **Manual / archivo**: usar el texto provisto o leer el archivo con `Read`.
- Si falta la historia o es ambigua, preguntar antes de seguir.

### Paso 2 — Cargar contexto del proyecto
Leer, en este orden y solo lo necesario:
- `CLAUDE.md` (raíz): acceso a Jira (cloudId `90fd6939-9992-4dac-a29c-53321dda6031`, proyecto `AURA`), mapa **módulo ↔ épica**.
- `Document Hub/Trazabilidad RF-Épicas.md`: a qué **RF y épica** pertenece la historia.
- `Document Hub/Requerimientos.md`: texto de los RF/RNF involucrados.
- `Document Hub/Arquitectura y Stack Tecnológico.md`: **ADRs** (ADR-001…009) y modelo de datos.

### Paso 3 — Recopilar evidencia (lo que exista)
- **ADR**: buscar en el doc de Arquitectura ADRs que apliquen a la historia (`Grep` por palabras clave). Si la historia implicó una **decisión técnica nueva** que aún no tiene ADR, anotarlo como pendiente (proponer crear ADR-0XX), no inventarlo.
- **DER / modelo de datos**: si la historia toca datos, reflejar el modelo afectado (`erDiagram` Mermaid). Si no modifica datos, marcar "sin cambios en el modelo".
- **Código**: `Glob`/`Grep` en `Backend/` y `Frontend/` por entidades, endpoints o componentes de la historia. Listar archivos/paths reales. Si aún no hay código, dejar placeholder.
- **Tests**: buscar tests relacionados (`*test*`, `*spec*`). Extraer casos existentes; nunca inventar resultados de ejecución.
- **Git**: `git log --oneline --all --grep <KEY>` para commits/PRs que referencien la historia.

### Paso 4 — Generar diagramas de modelado (Mermaid)
Generar solo los que apliquen a la historia: `classDiagram`, `sequenceDiagram`, `stateDiagram-v2`, `erDiagram`. Mantener consistencia con los diagramas C4/Mermaid del doc de Arquitectura. Snippets y criterios de "cuándo aplica cada uno" en `references/guia-catedra.md`.

### Paso 5 — Armar el artefacto
Partir de `assets/plantilla-artefacto.md`. Completar cada sección con lo recopilado. Marcar lo faltante de forma inequívoca con bloques `> [!todo]` y con la **checklist de completitud** al final. Conservar el frontmatter (para que aparezca en la base de Obsidian y el grafo).

### Paso 6 — Guardar en el vault
Escribir en `Document Hub/Trazabilidad/<KEY> - <slug-del-título>.md` (crear la carpeta si no existe). Para historia manual sin key, usar un slug del título.

### Paso 7 — Publicar en Jira (con confirmación)
Proponer un resumen breve + el enlace al artefacto y, **solo tras confirmación explícita**, publicarlo con `mcp__atlassian__addCommentToJiraIssue` en el ticket de la historia. Nunca escribir en Jira sin OK del usuario.

### Paso 8 — Reportar
Resumir qué secciones se completaron con evidencia real y cuáles quedaron como pendientes (la checklist), para que el equipo sepa qué falta.

## Reglas estrictas
1. **No inventar** resultados de pruebas, ADRs, código ni datos. Lo no verificable va como placeholder/pendiente.
2. **Confirmar antes de escribir en Jira** o de sobreescribir un artefacto existente.
3. Diagramas siempre en **Mermaid** (coherente con el doc de Arquitectura).
4. Reusar la numeración de RF/ADR existente; no renumerar.
5. Cada artefacto debe poder mapear la historia a: ADR ↔ DER ↔ diagramas ↔ código ↔ tests (sección de trazabilidad de la plantilla).

## Recursos
- **`assets/plantilla-artefacto.md`** — estructura del documento de salida (copiar y completar).
- **`references/guia-catedra.md`** — definición de la cátedra, guía por sección, cheatsheet Mermaid y formato de casos de prueba.
