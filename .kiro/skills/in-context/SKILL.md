---
name: in-context
description: Resumen "¿qué me perdí?" del proyecto de tesis Aurora. Hace git fetch en todos los repos (AuroraCareBack, AuroraCareFront, AuroraCore, AuroraHome, ObsidianAurora), revisa PRs y movimiento en GitHub, chequea el avance del proyecto AURA en Jira, y sintetiza qué se hizo, cómo avanzó Jira y recomendaciones para seguir. Read-only por defecto; puede hacer pull sólo con confirmación explícita. Usar cuando el usuario pida "/in-context", "qué estuvo pasando", "resumime el proyecto", "qué me perdí" o "actualizá los repos y resumí".
---

# in-context — resumen del estado de la tesis Aurora

Skill de contexto rápido para el proyecto de tesis **Aurora** (NO Craftech). Junta git + GitHub + Jira en un solo resumen accionable.

`$ARGUMENTS` puede traer una ventana temporal (`7d` por defecto; acepta `1d`, `3d`, `14d`) y/o el nombre de un repo para acotar el análisis (aun así se reporta Jira).

## Datos fijos del proyecto

- **Repos** (working dir: `/home/jeremaldonado/Escritorio/Tesis-Obsidian`):
  - `AuroraCareBack` → `AuroraMemory/AuroraCareBack`
  - `AuroraCareFront` → `AuroraMemory/AuroraCareFront`
  - `AuroraCore` → `AuroraMemory/AuroraCore`
  - `AuroraHome` → `AuroraMemory/AuroraHome`
  - `ObsidianAurora` → `NicolasRodeyro/ObsidianAurora`
- **Jira:** project key `AURA`, cloudId `90fd6939-9992-4dac-a29c-53321dda6031`, site `project-aurora-alz.atlassian.net`.
- **Contexto de épicas y tickets:** `ObsidianAurora/CLAUDE.md` (mapa de épicas ↔ módulos ↔ RF) y `ObsidianAurora/jira/snapshot.json` (snapshot del board).
- **Cuenta de GitHub:** los repos de `AuroraMemory/*` son privados y sólo los ve el usuario `SantoriniRings`.

## Flujo

### 1. Git — estado local + fetch (read-only)

Para cada repo (o el indicado en `$ARGUMENTS`):

```bash
git fetch --all --prune          # NUNCA pull en este paso
git status -sb                    # rama actual, ahead/behind, working tree sucio
git log --oneline -15 --since="<ventana>" @{u} 2>/dev/null   # commits nuevos en upstream
git log --oneline @{u}..HEAD 2>/dev/null                     # commits locales sin pushear
```

Usá el argumento `working_dir` de la shell para cada repo en vez de `cd`.

Reportá por repo: rama actual, si está adelante/atrás del upstream, commits nuevos remotos en la ventana, working tree sucio, y commits locales sin pushear.

### 2. GitHub — PRs y actividad

**Antes de cualquier comando `gh`**, asegurá la cuenta con acceso a la org privada AuroraMemory:

```bash
gh auth switch --user SantoriniRings   # switch permanente; sin esto gh no ve los repos privados
```

Para cada repo:

```bash
gh pr list -R <owner/repo> --state open --json number,title,author,updatedAt,isDraft,reviewDecision
gh pr list -R <owner/repo> --search "review-requested:@me" --state open --json number,title,url
```

Reportá: PRs abiertas (título, autor, draft, estado de review) y **PRs esperando tu review**. Si hay CI corriendo o fallando en PRs relevantes, marcalo.

### 3. Jira — avance del proyecto AURA

Vía MCP de Atlassian (`searchJiraIssuesUsingJql`) con el cloudId de arriba:

```
project = AURA AND updated >= -<ventana> ORDER BY updated DESC
```

Pedí `fields` reducidos (`summary`, `status`, `issuetype`, `parent`, `labels`, `assignee`): la consulta sobre todo el proyecto con todos los campos excede el límite de tokens y se vuelca a un archivo.

Reportá agrupando por épica cuando ayude: tickets que cambiaron de estado, comentarios y asignaciones nuevas, y qué se movió a Finalizada / In Revision / PAUSED-BLOCKED. Cruzá con `ObsidianAurora/CLAUDE.md` para dar contexto (qué épica y módulo es cada ticket).

### 4. Síntesis (el output que importa)

Entregá, en español neutro, en este orden:

1. **Qué se hizo** — 3-6 bullets combinando commits + PRs mergeadas + tickets cerrados. Concreto, no un log crudo.
2. **Cómo avanzó Jira** — estado de épicas activas y tickets clave que se movieron.
3. **Atención / bloqueos** — working trees sucios sin commitear, PRs esperando review, commits locales sin pushear, tickets bloqueados.
4. **Recomendaciones para seguir** — priorizadas, con qué desbloquea qué. No inventes tickets ni datos: si falta info, marcá el placeholder o preguntá.

### 5. Guardar el resultado en el vault

Además de mostrarlo en el chat, **escribí el resumen como nota en el vault de Obsidian**:

- Ruta: `in-context/<AAAA-MM-DD>.md` (creá la carpeta `in-context/` si no existe).
- Una nota por día: si ya existe la del día, **sobreescribila** con la corrida más reciente.
- Frontmatter arriba para que Obsidian la indexe:

```markdown
---
fecha: <AAAA-MM-DD>
ventana: <ej. 7d>
tipo: in-context
---
```

- Debajo, las 4 secciones de la síntesis en markdown. Usá wikilinks `[[...]]` cuando referencies notas existentes del vault.
- Confirmá en el chat la ruta del archivo escrito.

## Reglas de escritura (importante)

- **Read-only por defecto.** Los pasos 1-4 sólo hacen `fetch`, `status`, `log`, `gh ... list` y lecturas de Jira. Nunca `pull`, `merge`, `push`, ni escrituras en Jira.
- **Pull sólo con confirmación.** Si un repo está *behind* del upstream, ofrecelo al final: listá qué repos se pueden actualizar y esperá confirmación explícita antes de correr `git pull` en cada uno. No hagas pull si el working tree está sucio — avisá primero.
- No inventes datos internos (tickets, autores, fechas): pedilos o marcalos como placeholder.
