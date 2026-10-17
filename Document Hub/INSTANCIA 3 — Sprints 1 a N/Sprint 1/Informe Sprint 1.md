---
sprint: 1
jira_sprint: "SCRUM Sprint 2 (id 35)"
fecha_inicio: "2026-06-17"
fecha_fin_planificada: "2026-07-08"
fecha_cierre: "2026-08-02"
tipo: informe-sprint
---

# Informe de Sprint 1

> [!info] Numeración
> Este informe usa la numeración de la documentación. El Sprint 1 corresponde a la iteración **«SCRUM Sprint 2»** de Jira (id 35). Ver la tabla de equivalencias en [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 2 (id 35) |
| Inicio | 17/06/2026 |
| Fin planificado | 08/07/2026 |
| Cierre en Jira | 02/08/2026 (+25 días; ver métricas) |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez |

## 1. Objetivo del sprint

Dejar definida la base del proyecto (arquitectura, plan de testing, backlog y modelo de datos) y construir las primeras pantallas de Aurora Care.

> [!note] El objetivo se redactó a posteriori
> Jira no tenía objetivo cargado para este sprint. Este texto se escribió el 17/10/2026 a partir de lo que el sprint entregó, y se cargó en Jira en esa fecha.

## 2. Equipo y capacidad

| Persona | Roles en el sprint | Capacidad declarada |
|---|---|---|
| Haik Kilic Aslan | Backend · Backend del Worker IA · Analista funcional · Product Owner | 18 h/semana |
| Nicolás Rodeyro Contarino | Frontend · Base de datos · Diseño UX/UI | 22 h/semana |
| Mateo Romero Plaza | Frontend · Base de datos · Aurora Home · Analista funcional | 16 h/semana |
| Octavio Escudero | Backend · Backend del Worker IA · Aurora Home | 15 h/semana |
| Jeremías Maldonado Gómez | Project Manager · DevOps · Diseño UX/UI · Scrum Master | 13 h/semana |

**Capacidad asumida:** 84 h por semana, es decir 252 h en un sprint de 3 semanas, o unas 202 h si se descuenta el 20 % de margen para imprevistos (Plan de Proyecto). Los tickets no se estimaron en horas en Jira, por lo que no se puede comparar el esfuerzo estimado con la capacidad (ver métrica «Carga por integrante»).

## 3. Sprint Backlog

Comprometidos: **26 tickets**; finalizados al cierre: **23**; sin terminar: **3**. La columna de responsable sale del campo *assignee* de Jira, que en este período no es del todo confiable.

### 3.1 Tickets finalizados (23)

| Key | Tipo | Resumen | Responsable (Jira) | Story points |
|---|---|---|---|---|
| AURA-27 | Tarea | Definir Branding | nicolasrodeyro | 2 |
| AURA-30 | Tarea | Skills/rules para diseño - Parte 1 | Haik | 2 |
| AURA-41 | Tarea | Implementación de Informe de Sprint | Jeremías | 1 |
| AURA-42 | Tarea | Definición de Artefactos de Trazabilidad | Jeremías | 2 |
| AURA-43 | Tarea | Revisar granularidad del WBS (desagregar o agrupar las actividades de gestión) | Jeremías | 1 |
| AURA-44 | Tarea | Revisar correcciones de los requerimientos funcionales y no funcionales | Haik | 1 |
| AURA-45 | Tarea | Agregar flujo de fondos | Mateo | 1 |
| AURA-46 | Tarea | Agregar cronograma | Octavio | 1 |
| AURA-48 | Tarea | Agregar glosario general del proyecto | - |  |
| AURA-49 | Tarea | Buscar una forma mas linda de mostrar el analisis de costos | Octavio | 0 |
| AURA-50 | Tarea | Crear un glosario en el documento de entrega a la profe | Mateo | 0 |
| AURA-51 | Análisis | Investigar un carrito de compras para un prototipo de Aurora Home. | Haik | 1 |
| AURA-52 | Tarea | Sub RAG para flujo de información entre Jira y Obsidian | Jeremías | 2 |
| AURA-53 | Tarea | Diseño de BD | Mateo | 5 |
| AURA-54 | Tarea | Login - Aurora Care | Mateo | 3 |
| AURA-55 | Tarea | Modulo Paciente - Aurora Care | Mateo | 2 |
| AURA-56 | Tarea | Módulo Terapias Cognitivas | nicolasrodeyro | 2 |
| AURA-57 | Tarea | Módulo Recordatorios | Mateo | 2 |
| AURA-58 | Tarea | Módulo Recetario | Mateo | 2 |
| AURA-59 | Tarea | Vistas Paciente UI | nicolasrodeyro | 2 |
| AURA-60 | Tarea | Vistas Terapias UI | nicolasrodeyro | 2 |
| AURA-61 | Tarea | Vistas Recordatorio UI | Jeremías | 2 |
| AURA-62 | Tarea | Vistas Recetario UI | Jeremías | 2 |

### 3.2 Tickets sin terminar (3)

| Key | Tipo | Resumen | Responsable (Jira) | Story points |
|---|---|---|---|---|
| AURA-47 | Tarea | Agregar US | nicolasrodeyro | 2 |
| AURA-63 | Tarea | Implementar Conexión entre Care y la BD | Haik | 3 |
| AURA-64 | Análisis | Investigación Pulsera para Aurora Band | Haik | 1 |

| Key | Qué pasó |
|---|---|
| AURA-47 | «Agregar US» quedó pendiente al cierre; se completó después. |
| AURA-63 | Conexión entre Aurora Care y la base de datos. Quedó bloqueada porque todavía no existía el backend; se cerró recién en el Sprint 4. |
| AURA-64 | Investigación de la pulsera de Aurora Band. Siguió pausada y se descartó el 17/10/2026, porque Band quedó fuera del MVP (decisión del 29/08/2026). |

## 4. Sprint Review

**Qué se pudo demostrar** (evidencia en el repositorio de documentación):

- DER de la base de datos con 8 vistas DBML y su PDF (AURA-53).
- El formato de informe de sprint y la definición de los artefactos de trazabilidad, con su skill (AURA-41 y AURA-42), además de las correcciones del WBS, el flujo de fondos y el cronograma del Plan de Proyecto (AURA-43 a AURA-46).
- Los módulos y vistas de Aurora Care para Login, Paciente, Terapias, Recordatorios y Recetario (AURA-54 a AURA-62).

> [!todo] Feedback recibido
> Falta registrar quiénes asistieron a la Sprint Review y qué feedback dieron la docente y el equipo. Se completa con el formulario del equipo.

## 5. Métricas y tendencia

Se usan las métricas que el equipo definió en el Plan de Proyecto. En los Sprints 0 a 2 los valores «planificados» de Jira no son del todo confiables, por lo que se reportan con esa salvedad.

| Métrica | Meta | Sprint 1 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **88 %** (23 de 26) | Se cumple la meta. |
| Desvío de cierre | ≤ 2 días | **+25 días** en Jira | No refleja trabajo sin terminar, sino que el sprint de Jira no se cerró a tiempo y absorbió el período siguiente (ver Sprint 2). La meta no se cumple. |
| Carga por integrante | nadie sobre su capacidad | **No medible** | No se estimó en horas. Se propone estimar en horas desde el Sprint 5. |
| Trabajo arrastrado | causa registrada | **3 tickets** | Cada uno tiene su causa en el punto 3.2. |
| Incidencias abiertas P1/P2 | ningún P1 | No aplica | Todavía no había software en ejecución. |
| Calidad del código | ≥ 80 % de cobertura | No aplica | Sprint de diseño y documentación. |
| Mejora del proceso | — | No aplica | Primer sprint con retrospectiva. |

**Tendencia:** el Sprint 0 cerró 16 tickets y el Sprint 1, 23. El volumen creció y casi todo el trabajo fue de documentación y diseño, donde el cumplimiento es más fácil de lograr. Lo que se destaca como señal de alerta es el desvío: el sprint se mantuvo abierto 46 días en vez de 21.

Los puntos de historia se usaron solo en los Sprints 0 y 1: en este, 62 puntos planificados y 56 entregados (90 %). Después de este sprint los tickets dejaron de estimarse. El Plan de Proyecto declara que no se usa velocidad en puntos, por eso esta cifra es solo informativa.

## 6. Retrospectiva

Los aportes provienen de la planilla de retrospectivas del equipo (ítems marcados para los sprints 0 a 2).

**Lo que funcionó bien**

- UX casi completo (Jere).
- Skill de trazabilidad e informes (Jere).
- DER de la base de datos (Mateo, Nico).
- Definición temprana de las pantallas principales de Aurora Care (Jere).
- Modelo de dominio consistente desde el día 1 (Octavio, sprints 1 y 2).

**Lo que aprendimos**

- En Aurora Care, definir antes los flujos completos de usuario evita rehacer pantallas después (Jere).

**Lo que faltó**

- Constancia en el trabajo (todos menos Mateo; sprints 0, 1 y 2).
- Comunicación entre backend y frontend (Haik y Octavio con Mateo y Nico; sprints 1 y 2).

**Lo que hubiéramos querido tener**

- Más tiempo (todos; sprints 1 y 2).
- Una profe más presente (sprints 1 y 2).

**Análisis del Scrum Master**

- El sprint de Jira quedó abierto casi el doble de lo planificado. Mientras tanto no se podía medir cumplimiento ni arrastre del período siguiente.
- La «constancia» aparece en la retro de tres sprints seguidos. Es un riesgo de proceso (R7 del Plan de Proyecto) y hay que tratarlo con acciones concretas.

**Action items:** en la retrospectiva de este sprint no se registraron acciones con responsable y fecha. Las acciones acordadas surgieron de la retrospectiva combinada de los Sprints 0 a 2; están en el [[Informe Sprint 3]] y su estado figura en el [[Informe Sprint 4]].

**Estado de las acciones del sprint anterior:** no aplica; no había acciones registradas para el Sprint 0.

## 7. Product Backlog repriorizado

Al cierre se incorporaron al backlog las historias derivadas del diseño (AURA-74 a AURA-80, creadas el 18/07): sesión guiada de terapia, biblioteca de actividades, descubrimientos con validación, dificultad adaptativa, registro y perfil del paciente, gestión de rutinas y gestión de medicación. Prioridad para el sprint siguiente: **completar el diseño visual** (design system, vistas y prototipo) y **abrir el repositorio del backend**, que todavía no existía y bloqueaba la conexión de Aurora Care con la base de datos (AURA-63).

## 8. Registro de riesgos (cambios en este sprint)

Registro completo y vigente de todos los riesgos: [[Registro de Riesgos]].

| Riesgo | Cambio | Acción |
|---|---|---|
| R2 — Pulsera biométrica no disponible | Se confirma: AURA-64 sigue pausada sin avance | Se sigue con la decisión de alcance del Sprint 3. |
| R7 — Sobrecarga o falta de constancia | Aparece en la retro como «constancia» | Revisar la capacidad real en la próxima Sprint Planning. |
| Nuevo — Dependencia del backend | AURA-63 bloqueada por no existir backend | Abrir el repositorio del backend en el Sprint 2. |

## 9. Artefactos producidos

- [[DER - Base de Datos Aurora]] (AURA-53)
- [[Arquitectura y Stack Tecnológico]] (AURA-35)
- [[Gestion de la Configuracion]] (AURA-34)
- [[Plan de Testing]] (AURA-36)
- [[Product Backlog Inicial]] (AURA-38)
- [[User Story Map]] (AURA-37)
- Artefactos de trazabilidad de AURA-54 a AURA-62 (carpetas `Sprint 1/AURA-xx/`).
