# CLAUDE.md — Contexto del proyecto Aurora

Archivo de contexto para agentes de IA (Claude Code) y onboarding del equipo. Resume qué es Aurora, dónde vive cada cosa y cómo conectarse a Jira. La documentación viva está en `Document Hub/` (vault de Obsidian); el punto de entrada navegable es [[Índice Aurora]].

## Qué es Aurora

Ecosistema de software + hardware para **acompañar y monitorear pacientes con Alzheimer** (nivel ≤5 en escala FAST) en el hogar, extendiendo su autonomía y reduciendo la carga del cuidador. Tesis de grado UTN-FRC, 2026. Metodología Scrum, sprints de 3 semanas.

### Componentes
- **Aurora Home** — asistente de voz en el hogar (Raspberry Pi; STT/TTS en el borde).
- **Aurora Band** — wearable biométrico comercial (HR, movimiento, GPS); se consume su API, no se modifica su firmware.
- **Aurora Care** — app web/móvil para cuidadores (monitoreo, configuración, alertas).
- **Aurora Core** — backend/orquestación en la nube (IA, RAG, detección de eventos, integración).

### Stack (ver ADRs en `Document Hub/Arquitectura y Stack Tecnológico.md`)
Backend **Python + Django/DRF** · Frontend **React + Next.js 14 (PWA)** · DB **Supabase (PostgreSQL + pgvector)** · Auth **Auth0** · Orquestación **n8n** · STT local **Whisper.cpp** · Infra **Hostinger VPS + AWS + Redis en RPi** · Observabilidad **Loki + Prometheus**.

## Equipo
| Persona | Roles |
| --- | --- |
| Jeremías Maldonado Gómez | PM · DevOps · UX/UI |
| Mateo Romero Plaza | Backend · DBA · Analista Funcional |
| Haik Kilic Aslan | Backend · Analista Funcional |
| Nicolás Rodeyro Contarino | UX/UI · DBA · AI · Frontend |
| Octavio Escudero | DevOps · Frontend · QA |

Sponsor: Virginia Santos. Cierre de ejecución: 05/10/2026 · Entrega final: 05/11/2026.

## Estructura del repositorio
```
ObsidianAurora/            # vault de Obsidian, versionado en git
├── CLAUDE.md              # este archivo
├── Document Hub/          # toda la documentación (.md + PDFs + .base)
├── Backend/               # placeholder (vacío)
├── Frontend/              # placeholder (vacío)
└── jira/snapshot.json     # snapshot machine-readable del board AURA
```

### Documentos clave (`Document Hub/`)
- **Project Charter** — alcance, presupuesto, riesgos, stakeholders, WBS.
- **Requerimientos** — 91 RF + 43 RNF en 9 módulos funcionales (fuente autoritativa).
- **Arquitectura y Stack Tecnológico** — modelo C4 + 9 ADRs + pautas de código.
- **Funcionalidades del Sistema en el Hogar** — componentes por módulo.
- **Product Backlog Inicial** — épicas/historias iniciales (parcial).
- **Estudio Inicial**, **Investigacion sobre neurologia**, **Diseño del Prototipo**, **Boceto de Arquitectura**, **Presentación del Proyecto**, **Brainstorm de Nombres**, **Documento Presentacion Sprint 0**, **Horarios y Roles de los Miembros**.
- **Trazabilidad RF-Épicas** — matriz RF ↔ módulo ↔ épica (generada).
- **Tablero Jira** — snapshot legible del board.

## Jira

- **Sitio:** `https://project-aurora-alz.atlassian.net` (cuenta personal/académica; NO es el sitio corporativo `craftech.atlassian.net`).
- **cloudId:** `90fd6939-9992-4dac-a29c-53321dda6031`
- **Proyecto:** `AURA` (id `10000`, team-managed / next-gen).
- **Tipos de issue:** Epic, Historia, Tarea, Feature, Error, Análisis, Subtask.
- **Transición a Finalizada:** id `51`.

### Estructura de épicas
9 épicas de **producto** alineadas 1:1 con los 9 módulos de `Requerimientos.md` (ver [[Trazabilidad RF-Épicas]]), + épicas de **gestión** (AURA-12/13/28/29/31). Labels: `mvp` / `vision`, componente (`aurora-home/band/care/core`, `transversal`), `modulo-N`. Definición completa en el ticket **AURA-8**.

| Épica | Módulo | RF | Scope |
| --- | --- | --- | --- |
| AURA-14 Interacción y Asistencia por Voz | 1 | RF-01–14 | mvp |
| AURA-19 Monitoreo Biométrico | 2 | RF-15–23 | mvp |
| AURA-22 Detección de Eventos y Riesgos | 3 | RF-24–35 | mvp |
| AURA-16 Alertas y Comunicación con el Cuidador | 4 | RF-36–46 | mvp |
| AURA-15 Motor de IA y Memoria del Paciente | 5 | RF-47–54 | mvp |
| AURA-21 Orquestación y Automatización | 6 | RF-55–59 | vision |
| AURA-18 Panel del Cuidador (Aurora Care) | 7 | RF-60–75 | mvp |
| AURA-20 Seguridad, Privacidad y Cumplimiento | 8 | RF-76–81 | mvp |
| AURA-17 Administración de Rutinas y Medicación | 9 | RF-82–91 | mvp |

### Acceso vía MCP de Atlassian
El MCP se autentica con la cuenta `jeremias.gomez@craftech.io`, invitada al proyecto AURA. Si una sesión nueva no ve el sitio, re-autenticar con `/mcp` incluyendo `project-aurora-alz.atlassian.net` en el consentimiento.

> ⚠️ **Payloads grandes:** `searchJiraIssuesUsingJql` sobre todo el proyecto excede el límite de tokens y se guarda a un archivo. Pedir `fields` reducidos y/o procesar el archivo con `jq`. El MCP **no** puede borrar issues (solo crear/editar/comentar/transicionar).

### Cómo refrescar el snapshot de Jira
1. `searchJiraIssuesUsingJql` con `jql = "project = AURA ORDER BY issuetype, key"`, `fields = ["summary","status","issuetype","assignee","parent","labels"]`.
2. Si se guarda a archivo, transformar con `jq` al esquema de `jira/snapshot.json` (claves: `key, type, status, statusCategory, assignee, parent, labels, summary`) y actualizar `lastSynced`.
3. Regenerar la tabla de [[Tablero Jira]] a partir del JSON. Commit.

## Convenciones del vault
- Cada doc en `Document Hub/` usa **frontmatter YAML** (`base: "[[Document Hub.base]]"`, `Category`, timestamps). `Document Hub.base` es una vista-tabla de Obsidian que cataloga los docs.
- Enlazar documentos con **wikilinks** `[[Nombre del documento]]` para alimentar el grafo de Obsidian.
- Idioma: español (es-AR).
