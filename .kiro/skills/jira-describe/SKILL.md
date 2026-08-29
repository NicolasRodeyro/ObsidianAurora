---
name: jira-describe
description: Genera una descripción estructurada para un ticket de Jira del proyecto Aurora (historia de usuario, contexto, alcance, desglose de tareas, fuera de alcance, consideraciones, criterios de aceptación) y la publica en el ticket. Antes de generar busca contexto en Jira, en el vault de Obsidian (Requerimientos, Arquitectura, Trazabilidad RF-Épicas, diseño) y en el código de los repos. Modo fast (default): genera con supuestos marcados. Modo vibe: interactivo, pregunta antes de generar. Usar cuando el usuario pida documentar, describir o completar un ticket AURA.
---

# jira-describe — documentar tickets del board AURA

Generás descripciones estructuradas para tickets de Jira del proyecto de tesis **Aurora**. Actuás como analista funcional + tech lead del equipo: tenés criterio para inferir alcances, detectar dependencias entre componentes (Home / Band / Care / Core) y decidir si algo está bloqueado por otro ticket.

## Parseo de argumentos

`$ARGUMENTS` tiene el formato:

```
<TICKET_ID> [--fast | --vibe] [contexto adicional libre...]
```

- `TICKET_ID`: obligatorio. Ej: `AURA-109`, `AURA-63`.
- `--fast`: modo rápido (default si no se indica nada). Genera sin preguntar y marca incógnitas como supuestos.
- `--vibe`: modo interactivo. Investigás, presentás hallazgos y gaps, hacés preguntas antes de generar.
- El texto restante es contexto extra que provee el usuario. **Priorizalo** sobre lo que encuentres en las búsquedas.

Si no se pasa modo, usá `--fast`.

## Datos fijos del proyecto

- **cloudId:** `90fd6939-9992-4dac-a29c-53321dda6031` · site `project-aurora-alz.atlassian.net` · proyecto `AURA` (team-managed).
- **Tipos de issue:** Epic, Historia, Tarea, Feature, Error, Análisis, Subtask.
- **Transiciones:** `21` En curso · `31` In Revision · `51` Finalizada · `2` PAUSED/BLOCKED · `11` Por hacer.
- **Épicas ↔ módulos ↔ RF:** ver `ObsidianAurora/CLAUDE.md` y `ObsidianAurora/Document Hub/Trazabilidad RF-Épicas.md`.
- **Repos locales** (working dir `/home/jeremaldonado/Escritorio/Tesis-Obsidian`): `AuroraCareBack`, `AuroraCareFront`, `AuroraCore`, `AuroraHome`, `ObsidianAurora`.

---

## Paso 1: Fetch del ticket

`getJiraIssue` con:

- `issueIdOrKey`: el TICKET_ID
- `fields`: `["summary", "description", "status", "issuetype", "priority", "labels", "components", "assignee", "reporter", "parent", "subtasks", "issuelinks", "comment"]`
- `responseContentFormat`: `"markdown"`

Extraé: título, descripción actual, tipo, prioridad, labels (`aurora-home/band/care/core`, `transversal`, `modulo-N`, `mvp`/`vision`), épica padre, issues vinculados, subtasks y comentarios recientes.

---

## Paso 2: Investigación de contexto

Ejecutá estas búsquedas **en paralelo**.

### 2a. Tickets relacionados en Jira

```
project = AURA AND (
  summary ~ "<palabras clave del título>"
  OR labels in (<labels del ticket>)
) ORDER BY updated DESC
```

Máximo 10 resultados, con `fields` reducidos. Si el ticket tiene épica padre, buscá también sus hermanos:

```
project = AURA AND parent = <epic_key> ORDER BY created DESC
```

Prestá atención a los que estén **In Revision** o **PAUSED/BLOCKED**: suelen ser la dependencia que define el alcance real del ticket.

### 2b. Documentación del vault (reemplaza a Notion)

El vault `ObsidianAurora/` es la fuente autoritativa. Buscá con `grep` / `read` en:

- `Document Hub/Requerimientos.md` — 91 RF + 43 RNF en 9 módulos. **Citá el RF concreto** que el ticket implementa.
- `Document Hub/Arquitectura y Stack Tecnológico.md` — modelo C4 + 9 ADRs + pautas de código.
- `Document Hub/Trazabilidad RF-Épicas.md` — matriz RF ↔ módulo ↔ épica.
- `Document Hub/Funcionalidades del Sistema en el Hogar.md` — componentes por módulo.
- `Document Hub/Diseño UX-UI/` — manual de UX/UI, VUI y accesibilidad.
- `Design/previews/` — las 32 pantallas del MVP en HTML. Si el ticket es de una pantalla de Aurora Care, **identificá el número de pantalla y el archivo de preview**.

Si el ticket toca compliance o datos personales, sumá el marco legal (Ley 25.326) desde los docs de investigación.

### 2c. Estado real del código

No describas trabajo que ya está hecho ni asumas endpoints que no existen. Verificá en los repos:

- **Backend** (`AuroraCareBack`): buscá el modelo, serializer, viewset y ruta. `api-openapi.yaml` lista los endpoints; los routers viven en `apps/*/urls.py`. Ojo: un modelo y un serializer pueden existir **sin viewset ni ruta** — eso es un gap de backend, no algo consumible.
- **Frontend** (`AuroraCareFront`): rutas en `app/`, features en `src/features/<modulo>/` (api + hooks + mocks + `__tests__`). Revisá también `Docs/backend-dependencies/` — ahí se documentan los contratos que bloquean al frontend.
- **Home** (`AuroraHome`) y **Core** (`AuroraCore`) según el label del componente.

Reportá en Consideraciones lo que **ya está construible** y lo que **depende de otro ticket**.

---

## Paso 3: Evaluación de dependencias y bloqueos

Antes de generar, evaluá si el ticket está realmente accionable. Indicadores de que **está bloqueado**:

- El endpoint o contrato que necesita no existe (modelo sin viewset, serializer sin ruta).
- Depende de un ticket en `PAUSED/BLOCKED` o `In Revision` sin mergear.
- Requiere hardware, cuenta o entorno no disponible (pulsera, Render, Raspberry Pi, Figma con plan Education).
- Requisitos funcionales ambiguos o contradictorios entre `Requerimientos.md` y el diseño.

Si hay un bloqueo parcial (parte del ticket es construible y parte no), **partí el alcance**: lo construible en Alcance y el resto en Fuera de Alcance, referenciando el ticket bloqueante. Es preferible a bloquear el ticket entero.

---

## Paso 4: Generación de la descripción

### Fast mode

Generá la descripción completa de una vez:

- `⚠️ SUPUESTO: <texto>` para cualquier asunción no verificable.
- `❓ INCÓGNITA: <texto>` para preguntas abiertas que no bloquean.
- Si la descripción actual del ticket tiene info útil, incorporala y no la pierdas.

### Vibe mode

1. Presentá un resumen de lo que encontraste (ticket + Jira + vault + código).
2. Listá los gaps concretos: qué falta para escribir la descripción bien.
3. Hacé entre 2 y 5 preguntas específicas (no genéricas).
4. Esperá la respuesta.
5. Generá la descripción con las respuestas incorporadas.
6. Mostrá el preview completo y pedí confirmación explícita ("¿Publico esto en el ticket?").

---

## Formato de la descripción

Markdown, estructura fija:

```markdown
## Historia de Usuario

Como **[rol]**, quiero **[acción/funcionalidad]** para **[objetivo/beneficio]**.

## Contexto

[Por qué existe este ticket. RF que implementa, pantalla del diseño si aplica,
tickets/épica relacionados. Máx 3-4 oraciones.]

## Alcance

* [Qué SÍ entra en este ticket]

## Desglose de Tareas _(alto nivel)_

1. [Tarea 1]
2. [Tarea 2]

## Fuera de Alcance

* [Qué NO entra, explícitamente, y qué ticket lo cubre]

## Consideraciones

* [Qué ya está construible hoy: endpoint/ruta/modelo verificado]
* [Dependencia de otro ticket: AURA-NN, con su estado]
* [RF/RNF y marco legal aplicable]
* [⚠️ SUPUESTO: ...] ← si aplica
* [❓ INCÓGNITA: ...] ← si aplica

## Criterios de Aceptación

- [ ] [Criterio concreto y verificable 1]
- [ ] [Criterio concreto y verificable 2]
```

**Reglas de contenido:**

- **Rol de la historia**: el rol real del dominio — *cuidador principal*, *cuidador secundario*, *paciente*, *el sistema*. No uses "usuario" genérico.
- **Tareas**: alto nivel, no pasos de implementación. 3-6 máximo.
- **Criterios de aceptación**: concretos y testeables, redactados desde lo observable por el cuidador o por un test.
- **Trazabilidad**: citá siempre el RF (`RF-81`) y, si es una pantalla, su número y archivo de preview. La cátedra pide trazabilidad; sin el RF la descripción vale menos.
- **Idioma**: español (es-AR), igual que el resto del board.
- No inventes nombres de personas ni fechas. Si algo es necesario y desconocido, `⚠️ SUPUESTO:`.

---

## Paso 5: Publicar en Jira

`editJiraIssue` con:

- `fields`: `{ "description": "<descripción generada>" }`
- `contentFormat`: `"markdown"`

En fast mode: publicá directamente. En vibe mode: sólo después de confirmación explícita.

### ⚠️ Checkboxes: `createJiraIssue` sí, `editJiraIssue` no

La conversión de markdown a ADF **no es la misma** en los dos endpoints:

- En **`createJiraIssue`** (ticket nuevo), `- [ ]` se convierte bien en checkbox de Jira. Usalo tal cual en los Criterios de Aceptación.
- En **`editJiraIssue`** (ticket existente), `- [ ]` y `- [x]` se escapan y quedan literalmente como `* \[ \]` en el ticket, que se ve roto. Verificado el 2026-08-29 en AURA-108.

Por eso, **cuando edites la descripción de un ticket que ya existe**, escribí los criterios con marcadores que no se escapan:

```markdown
## Criterios de Aceptación

* ✅ Criterio ya verificado — con la evidencia al lado
* ⬜ Criterio pendiente
```

Si el ticket ya tenía checkboxes nativos creados desde la UI de Jira, no los reemplaces por emojis: dejá esa sección como está y agregá el estado en el comentario.

### ⚠️ Nada de wikilinks en Jira

Los wikilinks de Obsidian (`[[Documento]]`) también se escapan y quedan como `\[\[Documento\]\]`. Jira no los entiende. Cuando referencies documentación del vault desde un ticket, usá la **ruta del archivo entre backticks** (`` `Document Hub/Pre Estudio Inicial/Requerimientos.md` ``). Los wikilinks son sólo para las notas del vault.

Si el ticket queda bloqueado por otro, además:

- Creá el link con `createIssueLink` (`type: "Blocks"`, `inwardIssue` = el bloqueante, `outwardIssue` = este ticket).
- Si corresponde, transicioná a PAUSED/BLOCKED (`transitionJiraIssue`, id `2`) — pero **avisá antes** de mover el estado.

---

## Paso 6: Resumen final

Después de publicar, mostrá:

```
✅ Descripción publicada en <TICKET_ID>: <título>

📋 Resumen:
- Historia de usuario: [primera oración de la HU]
- RF cubierto: [RF-NN]
- Tareas identificadas: N
- [🔒 Bloqueado por: AURA-NN — <motivo>] ← si aplica

⚠️ Supuestos/Incógnitas:
- [lista si las hay]

🔗 Contexto usado:
- [tickets relacionados]
- [docs del vault]
- [archivos de código verificados]
```

Si no había supuestos ni incógnitas, omití esa sección.

---

## Notas

- Priorizá el contexto del propio proyecto AURA antes de generalizar.
- Si el ticket ya tiene descripción, no la borres sin incorporar su contenido.
- Sé conciso en tareas y alcances — el objetivo es orientar, no escribir la spec completa.
- Ante la duda, en fast mode es mejor un supuesto marcado que una pregunta que bloquea.
- El MCP de Atlassian **no** puede borrar issues: sólo crear, editar, comentar y transicionar.
