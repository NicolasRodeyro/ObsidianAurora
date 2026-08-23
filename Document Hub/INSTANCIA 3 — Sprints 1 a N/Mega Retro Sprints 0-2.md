---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
tipo: retrospectiva
alcance: "Sprints 0, 1 y 2"
tecnica: "Timeline + 4 L's"
fecha_sesion: null
estado: preparada
---

# Mega Retro — Sprints 0, 1 y 2

Retrospectiva combinada de los tres sprints ejecutados hasta la fecha. Se hace una sola sesión (mega retro) porque las retros individuales quedaron pendientes. Técnica: **Timeline** para reconstruir qué pasó + **4 L's** (Liked / Learned / Lacked / Longed for) para converger a acciones.

Informes de sprint relacionados: [[Informe Sprint 0]] · [[Informe Sprint 1]] · [[Informe Sprint 2]]

---

## 1. Logística de la sesión

| Campo | Valor |
|---|---|
| Duración estimada | ~90 min |
| Facilitador | *(asignar — sugerido: TL / PM)* |
| Participantes | *(marcar presentes)* Jeremías · Mateo · Haik · Nicolás · Octavio |
| Fecha | *(completar)* |

**Reglas de la sesión** (Prime Directive de Norm Kerth):
> "Independientemente de lo que descubramos, entendemos y creemos verdaderamente que todos hicieron el mejor trabajo posible, dado lo que sabían en ese momento, sus habilidades y recursos, y la situación."

- Se mira **el proceso, no a las personas**.
- Todo lo que se dice en la retro, queda en la retro.
- Se busca salir con **acciones concretas con dueño**, no con una lista de quejas.

---

## 2. Timeline — reconstrucción de los 3 sprints

Pre-cargada con los hitos reconstruidos de Jira + git + documentación. En la sesión, cada integrante **agrega lo que falte** y marca dónde sintió un pico 👍 (fue bien / motivó) o un valle 👎 (frustró / trabó).

### Sprint 0 — Fundación *(abr–jun 2026)*
Definición y setup, sin código de producto.
- Definición de alcance, funcionalidades y arquitectura
- 9 épicas de producto ↔ 9 módulos (AURA-8)
- Documentos de gestión: Charter, Working Agreement, Gestión de Config, Plan de Testing
- Requerimientos (91 RF + 43 RNF), User Story Map, Backlog inicial, Branding
- Investigación de demencia/neurología + contacto con profesional
- Creación de los 5 repositorios

`👍/👎:` *(marcar en la sesión)*

### Sprint 1 — Diseño y primeras vistas *(jun–ago 2026)*
- DER completo de la BD — 8 vistas DBML + PDF (AURA-53)
- Design System (tokens WCAG), Manual de UX/UI (11 capítulos), prototipo navegable, wireframes de visión V1–V6
- Primeras pantallas de Aurora Care: login, paciente, terapias, recordatorios, recetario (AURA-54..62)
- Investigaciones: Ley 25.326, Infraestructura, pulsera Aurora Band

`👍/👎:` *(marcar en la sesión)*

### Sprint 2 — Backend, integración y Aurora Home *(jul 2026–actual)*
- Auth0 + JWT en AuroraCore (AURA-82)
- APIs REST: rutinas, medicación, cumplimiento, acknowledge de alertas (AURA-87/88/89/96)
- Aurora Home: M01 repo base, M02 contratos + simulador, M03 fundación local resiliente (AURA-90/91/95)
- Refactor de performance y seguridad en AuroraCareBack (N+1, índices, cross-tenant)
- Historias de terapias/perfil en curso (AURA-74..80) + cierre MVP frontend

`👍/👎:` *(marcar en la sesión)*

---

## 3. Hipótesis del facilitador (validar o descartar en la sesión)

> [!warning] No son conclusiones — son **disparadores** para la conversación, sacados de los datos. El equipo confirma, matiza o descarta cada uno.

1. **Los sprints se estiran mucho.** Cierres reales muy por encima de lo planificado: Sprint 0 +8/+12 días; Sprint 1 planificado para el 08-jul cerró el **02-ago (+25 días)**. ¿Estimación optimista? ¿Alcance inflado? ¿Capacidad real menor a la supuesta?
2. **El backend arrancó tarde.** Recién en Sprint 2 aparece código de servidor; varias historias de backend (AURA-83..86) siguen "por hacer". ¿Dependencia de diseño/definición previa? ¿Prioridad?
3. **Gestión de sprints en Jira inconsistente.** Dos "Sprint 0", tickets arrastrados/reasignados entre sprints, tickets sin sprint. Dificulta medir velocidad y trazar qué se hizo cuándo.
4. **Decisiones estructurales a mitad de camino.** AuroraCare pasó a frontend-only / AuroraCore único backend (28-jul); stack frontend se oficializó (RN+Expo+TS) después de venir trabajando. ¿Se pudieron anticipar?
5. **Bloqueos por dependencias.** AURA-63 (Conexión Care↔BD) estuvo bloqueada por falta de backend. ¿Cómo se detectan y gestionan antes las dependencias?
6. **Límites de herramientas externas.** Figma MCP (plan Starter, 6 lecturas/mes) frenó el push del design system. ¿Qué otras dependencias externas nos pueden trabar?

---

## 4. 4 L's — recolección del equipo

Cada integrante aporta a cada cuadrante. Agrupar lo similar al final.

### 👍 Liked — lo que nos gustó / funcionó bien
| Aporte | Quién | Sprint |
|---|---|---|
| | | |
| | | |

### 🧠 Learned — lo que aprendimos (técnico y de proceso)
| Aporte | Quién | Sprint |
|---|---|---|
| | | |
| | | |

### 🕳️ Lacked — lo que faltó / echamos en falta
| Aporte | Quién | Sprint |
|---|---|---|
| | | |
| | | |

### 🌟 Longed for — lo que hubiéramos querido tener
| Aporte | Quién | Sprint |
|---|---|---|
| | | |
| | | |

---

## 5. Acciones acordadas

Máximo **3–5 acciones** priorizadas. Cada una con dueño y sprint objetivo. Derivan de los cuadrantes de arriba (sobre todo *Lacked* y *Longed for*).

| # | Acción | Deriva de | Dueño | Aplicar en | Estado |
|---|---|---|---|---|---|
| 1 | | | | Sprint 3 | Pendiente |
| 2 | | | | Sprint 3 | Pendiente |
| 3 | | | | Sprint 3 | Pendiente |

---

## 6. Informe de la retro *(completar después de la sesión)*

> [!todo] Rellenar tras la sesión para dejar registro en la tesis.

**Fecha de la sesión:** _____
**Participantes:** _____

### Resumen ejecutivo
> _(3–5 líneas: cómo llegó el equipo, clima general, hallazgo principal)_

### Hallazgos principales
> _(qué patrones se confirmaron de la sección 3, más lo que surgió nuevo)_

### Métricas de referencia
| Sprint | Tickets planificados | Cerrados | Desvío de cierre (días) |
|---|---|---|---|
| 0 | _(completar)_ | 17 | +8 / +12 |
| 1 | _(completar)_ | ~33 | +25 |
| 2 | _(en curso)_ | _(en curso)_ | — |

> [!todo] Completar "planificados" con el compromiso original de cada sprint (dato que hoy no es confiable en Jira; ver hallazgo #3).

### Acciones comprometidas
> _(copiar la tabla final de la sección 5 con los dueños confirmados)_
