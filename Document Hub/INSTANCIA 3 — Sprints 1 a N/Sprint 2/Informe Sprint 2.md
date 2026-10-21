---
sprint: 2
jira_sprint: "SCRUM Sprint 3 (sin tickets en Jira)"
fecha_inicio: "2026-07-08"
fecha_fin_planificada: "2026-08-04"
fecha_cierre: "2026-08-04"
tipo: informe-sprint
---

# Informe de Sprint 2

> [!info] Numeración y por qué este sprint casi no figura en Jira
> El Sprint 2 corresponde al **«Sprint 3» de Jira**, que se abrió y se cerró **sin tickets**. Mientras tanto, el sprint anterior de Jira (id 35) siguió abierto hasta el 02/08, así que todo el trabajo de este período quedó dentro de él. Este informe reconstruye el sprint con la evidencia de los repositorios y de Jira. Ver [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].

| Campo | Valor |
|---|---|
| Sprint Jira | «SCRUM Sprint 3» (sin tickets) |
| Inicio | 08/07/2026 |
| Fin | 04/08/2026 (inicio del Sprint 3) |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez |

## 1. Objetivo del sprint

Contar con el sistema de diseño y el prototipo navegable de Aurora Care, abrir los repositorios de código con su convención de trabajo, y dejar investigados los aspectos legales y de infraestructura.

> [!note] El objetivo se redactó a posteriori
> No existe objetivo en Jira para este período; se escribió el 17/10/2026 a partir de lo entregado.

## 2. Equipo y capacidad

El equipo y su capacidad declarada son los mismos que en el [[Informe Sprint 1]]: 84 h por semana, 252 h por sprint de 3 semanas (≈ 202 h con el 20 % de margen). Este sprint duró 4 semanas.

## 3. Sprint Backlog

Como el sprint no existió en Jira, **no hay un compromiso inicial registrado**. Solo se informa lo finalizado, como establece el Plan de Proyecto para los Sprints 0 a 2.

### 3.1 Tickets finalizados (9)

| Key | Tipo | Resumen | Responsable (Jira) | Story points |
|---|---|---|---|---|
| AURA-65 | Tarea | Design System — tokens, componentes y verificación WCAG AA | Jeremías |  |
| AURA-66 | Tarea | Manual de UX/UI Aurora (11 capítulos) | Jeremías |  |
| AURA-67 | Tarea | Prototipo navegable de Aurora Care + wiring para Figma | Jeremías |  |
| AURA-68 | Tarea | Vistas Auth y Onboarding UI | Mateo |  |
| AURA-69 | Tarea | Vistas Alertas y Actividad UI | Mateo |  |
| AURA-70 | Tarea | Vistas Ajustes UI | nicolasrodeyro |  |
| AURA-71 | Tarea | Vistas Dispositivo — Aurora Home Display UI | nicolasrodeyro |  |
| AURA-72 | Tarea | Vistas Desktop — Aurora Care (1440) UI | Mateo |  |
| AURA-73 | Tarea | Wireframes de Visión (V1–V6) | Jeremías |  |

### 3.2 Trabajo sin ticket en el período (evidencia en los repositorios)

| Fecha | Qué se hizo | Dónde |
|---|---|---|
| 09/07 | Design system, manual de UX/UI y previews en HTML | `Design/` y `Document Hub/Diseño UX-UI/` |
| 18/07 | Primeros commits de Aurora Care: estructura de la arquitectura e inicio de sesión | AuroraCare |
| 23/07 | Estructura inicial del backend (scaffold) | AuroraCore |
| 01/08 | Convención de ramas y commits, documentos de contexto para los agentes de IA, Swagger con autorización Bearer | AuroraCore |
| 01/08 | Plan de implementación y backlog del Core para Aurora Home | AuroraHome |
| 03/08 | Investigaciones: almacenamiento y Ley 25.326, despliegue e infraestructura | Vault |
| 03/08 | Artefactos de trazabilidad AURA-75 a AURA-80 | Vault |
| junio–julio | Paper y póster de la Jornada de Presentación | Carpeta de Drive |

### 3.3 Historias que quedaron listas para el sprint siguiente

AURA-74 a AURA-80 (creadas el 18/07): sesión guiada, biblioteca de actividades, descubrimientos con validación, dificultad adaptativa, registro del paciente, rutinas y medicación. Se tomaron en el Sprint 3.

## 4. Sprint Review

**Qué se pudo demostrar:**

- Design system con verificación de contraste WCAG AA y AAA, y prototipo navegable de Aurora Care (`Design/previews/index.html` y `Design/prototype/aurora-care.html`).
- Las 32 pantallas del MVP en HTML y los wireframes de visión.
- Repositorios de backend y frontend con estructura inicial y convención de trabajo.

> [!todo] Feedback recibido
> Falta registrar quiénes asistieron a la Sprint Review y qué feedback hubo. Se completa con el formulario del equipo.

## 5. Métricas y tendencia

| Métrica | Meta | Sprint 2 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **No medible** | No hubo compromiso inicial en Jira. Se finalizaron 9 tickets. |
| Desvío de cierre | ≤ 2 días | **No aplica** | El sprint de Jira se abrió y cerró vacío; el período se absorbió en el Sprint 1 de Jira. |
| Carga por integrante | nadie sobre su capacidad | **No medible** | Sin estimación en horas. |
| Trabajo arrastrado | causa registrada | **2 tickets** (AURA-63 y AURA-64) | Ver [[Informe Sprint 1]]. |
| Incidencias P1/P2 | ningún P1 | No aplica | No había software en ejecución. |
| Calidad del código | ≥ 80 % de cobertura | No aplica | Solo estructura inicial de código. |
| Mejora del proceso | — | No aplica | Las acciones surgen de la retro combinada del Sprint 3. |

**Tendencia:** 16 tickets en el Sprint 0, 23 en el Sprint 1 y 9 en el Sprint 2. La caída **no** indica menos trabajo: los tickets de diseño eran grandes (por ejemplo un manual de 11 capítulos) y buena parte del trabajo (backend, repositorios, investigaciones) se hizo sin ticket. Esta es la señal principal del período: **el tablero dejó de reflejar el trabajo real**. Para medir con confiabilidad hay que abrir el ticket antes de empezar.

## 6. Retrospectiva

**Lo que funcionó bien**

- Paper y póster (Octavio).
- Contexto versionado por área y `agents.md` como fuente de verdad (Octavio).
- Convención de commits explícita y sostenida (Octavio).
- Docker Compose reproducible (Octavio).
- Agentes de IA especializados por área y un orquestador (Octavio).
- Construcción de wireframes, prototipo navegable y manual de UX/UI (Jere).
- Modelo de dominio consistente desde el día 1 (Octavio).

**Lo que aprendimos**

- Restructurar las épicas (Jere).
- Expo es clave para el desarrollo de la app móvil (Mateo).
- Manejo de hooks (Nico).
- La ley de protección de datos del paciente (Ley 25.326) es un tema complejo (Jere).

**Lo que faltó**

- Constancia en el trabajo (todos menos Mateo).
- Comunicación entre backend y frontend (Haik y Octavio con Mateo y Nico).
- Un sprint de Jira ordenado: el Sprint 3 se abrió y cerró sin tickets (análisis del Scrum Master).

**Lo que hubiéramos querido tener**

- Más tiempo (todos).
- Una profe más presente.

**Análisis del Scrum Master**

- Es el período con **peor trazabilidad entre tablero y trabajo real**: Jira muestra 9 tickets finalizados mientras que los repositorios muestran decenas de commits de backend y frontend.
- Hay que cerrar el sprint al terminar y abrir el siguiente con su planificación; no se debe dejar un sprint abierto mientras se trabaja en otro.

**Action items:** las acciones acordadas para este y los sprints siguientes se registraron en la retrospectiva combinada y figuran, con responsable y fecha, en el [[Informe Sprint 3]] y su estado en el [[Informe Sprint 4]].

**Estado de las acciones del sprint anterior:** el Sprint 1 no registró acciones.

## 7. Product Backlog repriorizado

El foco pasó del diseño al backend: prioridad para el Sprint 3 fue autenticación, API de pacientes, rutinas, medicación y cumplimiento (AURA-82 a AURA-96) y la base de Aurora Home (AURA-90 y AURA-91).

## 8. Registro de riesgos (cambios en este sprint)

Registro completo y vigente de todos los riesgos: [[Registro de Riesgos]].

| Riesgo | Cambio | Acción |
|---|---|---|
| R7 — Sobrecarga o falta de constancia | Se repite en la retro | Seguimiento por sprint. |
| Dependencia de herramientas externas (afín a R14) | Aparece la restricción de Figma (plan Starter con 6 lecturas por mes) | El design system queda en HTML y tokens; el push a Figma queda pendiente. |
| R5 — Seguridad de datos sensibles | Se investigan la Ley 25.326 y el almacenamiento (03/08) | Origen de ADR-010 (cifrado de datos identificatorios). |
| Nuevo — Tablero poco confiable | Sprint de Jira abierto 46 días y un sprint vacío | Cerrar y abrir sprints a tiempo y asignar siempre un sprint a cada ticket. |

## 9. Artefactos producidos

- Design System y previews: `Design/tokens`, `Design/previews`.
- Manual de UX/UI Aurora (11 capítulos): [[Manual de UX-UI Aurora]].
- Prototipo navegable: `Design/prototype/aurora-care.html`.
- [[Investigación — Almacenamiento de Datos y Ley 25.326]] y [[Investigación — Despliegue e Infraestructura]].
- Trazabilidad de las historias AURA-74 a AURA-80: ver [[Historias de producto AURA-74 a 80]].
