---
name: artefacto-trazabilidad
description: Genera el "artefacto de trazabilidad" de una historia del backlog de Aurora en el formato que pide la cátedra (conecta la historia con sus decisiones de diseño/ADR, modelo de datos/DER, diagramas de modelado, código y casos de prueba con resultados). Soporta un modo "task-first": derivar la Historia de Usuario a partir de una o varias Tareas/Análisis ya hechas (agrupándolas), crearla en Jira bajo su épica y enlazar las tareas, y recién después generar el artefacto. Recopila lo que ya exista en el repo y en Jira y deja scaffolding de lo faltante; no inventa. Salida en markdown bajo Document Hub/Trazabilidad/ y resumen/enlace en el ticket de Jira. Usar cuando el usuario pida "artefacto de trazabilidad", "trazabilidad de la historia/US", "documentar/trazar la historia AURA-XX", "artefacto de la historia", "derivar/generar una historia desde una tarea o análisis", "agrupar estas tareas en una historia y trazarla".
version: 0.1.0
---

# Skill: artefacto-trazabilidad

Genera el **artefacto de trazabilidad** de una Historia de Usuario del proyecto Aurora, en el formato exigido por la cátedra (UTN-FRC). El artefacto conecta cada historia con sus **decisiones de diseño (ADR)**, **modelo de datos (DER)**, **diagramas de modelado** (clases / secuencia / estados), **código** y **casos de prueba** (precondición, pasos, resultado esperado y resultado de ejecución).

Principio de operación: **recopilar lo que ya exista** (Jira, ADRs, código, tests, git) y dejar un **scaffolding** claro —checklist + placeholders marcados— de lo que el equipo debe completar. **No inventar** resultados de pruebas, ADRs ni código que no existan.

> La definición completa de la cátedra, la guía por sección, el cheatsheet de Mermaid y el formato de casos de prueba están en `references/guia-catedra.md`. La estructura del documento de salida está en `assets/plantilla-artefacto.md`.

## Cómo usar

```
/artefacto-trazabilidad
→ "generá el artefacto de trazabilidad de AURA-60"           # historia existente
→ "derivá una historia desde las tareas AURA-60 y AURA-61"   # modo task-first
→ "trazabilidad de esta historia: <pego la historia>"        # manual
→ "documentá la historia del archivo docs/historia-login.md" # archivo
```

Modos de entrada: **historia existente** (key de Jira tipo Historia), **task-first** (uno o varios keys de Tarea/Análisis → derivar la historia), o **historia manual/archivo**. Si no se indica nada, preguntar qué documentar.

## Modo task-first (derivar la historia desde tareas)

El equipo trabaja con **tareas técnicas**; este modo deriva la Historia de Usuario *después* de hacer el trabajo, sin cambiar el ritmo. Aplica solo a tareas que **construyen el producto** (código/diseño/pruebas), no a tareas de gestión/documentación. Por defecto se **agrupan varias tareas relacionadas en UNA historia** (1 tarea = 1 historia fragmenta el backlog; evitarlo salvo que el usuario lo pida).

1. **Entrada:** uno o varios keys de Tarea/Análisis relacionados (ej. "desde AURA-60 y AURA-61").
2. **Traer las tareas** con `mcp__atlassian__getJiraIssue` (summary, description, comments) y entender qué hicieron; sumar evidencia de código/tests/git si existe.
3. **Buscar Historia existente antes de proponer una nueva.** Usando `mcp__atlassian__searchJiraIssuesUsingJql` con `jql = "project = AURA AND issuetype = Historia AND parent = <ÉPICA> ORDER BY created DESC"`, verificar si ya existe una Historia en la misma épica que cubra el trabajo de las tareas. Si existe: usar esa Historia como base (modo historia existente) e informar al usuario. Solo si no existe, proceder a proponer una nueva.
4. **Proponer la Historia** en formato **user-centric**: *Como `<rol usuario: cuidador/paciente>` quiero `<objetivo>` para `<beneficio>`* + criterios de aceptación derivados de lo hecho. **No** redactar desde la mirada del desarrollador (ver `references/guia-catedra.md`). Identificar la **épica** (módulo) y los **RF** vía `Document Hub/Trazabilidad RF-Épicas.md`.
5. **Mostrar la historia propuesta y esperar aprobación/edición.** No crear nada en Jira sin OK explícito.
5. Tras el OK, **crear la Historia en Jira**: `mcp__atlassian__createJiraIssue` con `issueTypeName: "Historia"`, `projectKey: "AURA"`, `parent: "<ÉPICA>"` (la épica de producto del módulo, AURA-14…22), label `derivada-de-tarea`.
6. **Enlazar cada tarea** a la historia con `mcp__atlassian__createIssueLink` tipo **`Relates`** (este proyecto no tiene "is implemented by"; `Relates` es el más cercano).
7. Continuar con el **Proceso** de abajo para generar el artefacto, ya con la historia creada.

> Jerarquía: "Tarea" e "Historia" están al mismo nivel (ambas cuelgan de la épica), así que la tarea **no** puede ser hija de la historia; se vinculan con issue link y se referencian en el artefacto.

## Proceso

### Paso 1 — Identificar la historia
- **Modo task-first** (uno o más keys de Tarea/Análisis): ejecutar primero la sección "Modo task-first" para obtener/crear la historia, y luego seguir.
- **Key de Jira de una Historia** (`AURA-XX`): traer la historia con `mcp__atlassian__getJiraIssue` (cloudId y proyecto en `CLAUDE.md`), campos `["summary","description","issuetype","status","parent","labels","comment"]`, formato markdown. Tomar título, descripción, criterios de aceptación, épica padre.
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
- **Código**: `Glob`/`Grep` en `Backend/` y `Frontend/` por entidades, endpoints o componentes de la historia. Si esas carpetas están vacías, buscar repos hermanos del vault (ej. `../AuroraCareFront`, `../AuroraCore`) con `find` desde el directorio padre. Listar archivos/paths reales. Si aún no hay código, dejar placeholder.
- **Compliance RF-76/79/81**: si la historia toca alguno de estos RF (autenticación, cifrado, consentimiento), leer automáticamente `Document Hub/INSTANCIA 3 — Sprints 1 a N/Investigación — Almacenamiento de Datos y Ley 25.326.md` para referenciar la decisión técnica relevante en el artefacto (sección ADR y criterios de aceptación).
- **Tests**: buscar tests relacionados (`*test*`, `*spec*`). Extraer casos existentes; nunca inventar resultados de ejecución.
- **Git**: `git log --oneline --all --grep <KEY>` para commits/PRs que referencien la historia.

### Paso 3.5 — Inferir qué secciones aplican

Antes de generar, evaluar cada sección según el contenido de la historia y la evidencia recopilada. **Solo generar lo que aplique; omitir lo que no** (no dejar placeholders vacíos para secciones irrelevantes — reemplazar con una línea explicativa: "No aplica — [motivo]").

| Sección | Generar si… | Omitir si… |
| --- | --- | --- |
| **DER** (`erDiagram`) | La historia crea, modifica o elimina entidades/atributos/relaciones en la BD | Es una historia puramente de UI/navegación/configuración sin cambios en el modelo de datos |
| **Diagrama de clases** (`classDiagram`) | La historia introduce o cambia entidades de dominio, servicios o sus relaciones en el código | La lógica es trivial (CRUD directo sin dominio propio) o ya está cubierta por el DER |
| **Diagrama de secuencia** (`sequenceDiagram`) | Hay ≥2 componentes/actores con una interacción que conviene mostrar paso a paso (ej. Care → Core → Supabase) | La historia involucra un solo servicio o la interacción es obvia (una pantalla que llama a un endpoint) |
| **Diagrama de estados** (`stateDiagram-v2`) | Una entidad de la historia tiene un ciclo de vida con estados nombrados y transiciones definidas (ej. Alerta: generada→enviada→atendida→cerrada) | No hay ciclo de vida con estados — la entidad se crea y se modifica sin transiciones formalizadas |

Documentar la decisión con una línea al inicio de cada subsección omitida: ej. `> DTE no aplica: el perfil del paciente no tiene ciclo de vida con estados transicionables.`

### Paso 4 — Generar diagramas de modelado (Mermaid)
Generar solo los diagramas que resultaron **aplicables en Paso 3.5**. Mantener consistencia con los diagramas C4/Mermaid del doc de Arquitectura. Snippets y criterios de "cuándo aplica cada uno" en `references/guia-catedra.md`.

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
