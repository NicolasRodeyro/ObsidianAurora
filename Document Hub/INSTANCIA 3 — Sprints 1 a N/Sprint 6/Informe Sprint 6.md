---
sprint: 6
jira_sprint: "SCRUM Sprint 7 (id 72)"
fecha_inicio: "2026-10-14"
fecha_fin_planificada: "2026-11-05"
fecha_cierre: null
tipo: informe-sprint
estado: parcial al 2026-10-17
---

# Informe de Sprint 6 (parcial al 17/10/2026)

> [!warning] Informe parcial
> El sprint está en curso: empezó el 14/10 y termina con la entrega final del 05/11. Este informe se escribe a los 3 días de empezado el sprint y se completa al cierre. Las partes que dependen del equipo (Sprint Review y retrospectiva) quedan para ese momento.

> [!info] Numeración
> El Sprint 6 corresponde a la iteración **«SCRUM Sprint 7»** de Jira (id 72). Ver [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 7 (id 72), activo |
| Inicio | 14/10/2026 |
| Fin planificado | 05/11/2026 (entrega final); Jira lo cierra el 06/11 a las 02:30 UTC |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez |

## 1. Objetivo del sprint

Cerrar el MVP y la entrega final: terminar las 6 tareas arrastradas del Sprint 6 de Jira (Drop-in, memoria del paciente, pantalla de privacidad, validación de recuerdos y dos errores), completar la documentación y el Docs corregido, y preparar la presentación del 05/11.

## 2. Equipo y capacidad

Equipo y roles como en el [[Informe Sprint 1]]. El sprint dura 22 días (3,1 semanas): **264 h** de capacidad declarada (84 h por semana), unas **211 h** descontando el 20 % de margen. Los tickets no tienen estimación en horas.

## 3. Sprint Backlog

El sprint tiene **14 tickets**: 13 arrastrados del Sprint 5 y 1 nuevo (AURA-186, documentación). Estado al 17/10:

| Key | Tipo | Resumen | Responsable (Jira) | Origen | Estado al 17/10 |
|---|---|---|---|---|---|
| AURA-64 | Análisis | Investigación Pulsera para Aurora Band | Haik | Arrastrado del Sprint 5 | Finalizada *(cerrado el 17/10 al depurar el tablero)* |
| AURA-74 | Historia | US-D1 — Sesión guiada de terapia | Jeremías | Arrastrado del Sprint 5 | Finalizada *(cerrado el 17/10 al depurar el tablero)* |
| AURA-76 | Historia | US-D3 — Descubrimientos con validación | Jeremías | Arrastrado del Sprint 5 | En curso |
| AURA-78 | Historia | Registro y perfil del paciente | Jeremías | Arrastrado del Sprint 5 | Finalizada *(cerrado el 17/10 al depurar el tablero)* |
| AURA-97 | Subtarea | Mecanismo y ADR formal de cifrado de PII (DNI y nombre) conforme a la Ley 25.326 | Octavio | Arrastrado del Sprint 5 | Finalizada *(cerrado el 17/10 al depurar el tablero)* |
| AURA-98 | Subtarea | API operativa de consentimiento informado para registrar y consultar consent_records desde el onboarding | Octavio | Arrastrado del Sprint 5 | Finalizada *(cerrado el 17/10 al depurar el tablero)* |
| AURA-99 | Subtarea | Asistencia de backend a AURA-74 | Haik | Arrastrado del Sprint 5 | Finalizada |
| AURA-101 | Subtarea | Implementación del backend (subtarea) | Octavio | Arrastrado del Sprint 5 | Finalizada |
| AURA-104 | Tarea | CORE-MEM01 — Schema de memoria contextual del paciente en AuroraCore | Jeremías | Arrastrado del Sprint 5 | In Revision |
| AURA-109 | Historia | Pantalla de Privacidad y datos (Aurora Care) | Jeremías | Arrastrado del Sprint 5 | In Revision |
| AURA-134 | Tarea | CORE-010 · Drop In en vivo (LiveKit) autorizado para Aurora Home | Jeremías | Arrastrado del Sprint 5 | In Revision |
| AURA-164 | Error | Compliance sin filtro de fecha: Care infiere «hoy» por paginación y oculta estados reales | Haik | Arrastrado del Sprint 5 | En curso |
| AURA-173 | Error | El cuidador principal se auto-provisiona sin can_drop_in, bloqueando Drop-in por defecto | Haik | Arrastrado del Sprint 5 | Tareas por hacer |
| AURA-186 | Tarea | Actualizar la documentación del proyecto en el Docs y en el repositorio (correcciones de la cátedra del 12/10/2026) | Mateo | Nuevo (documentación) | En curso |

**Cómo leer el avance:** hay 7 tickets finalizados de 14 (50 %), pero **5 de esos cierres son depuración del tablero** (AURA-64, 74, 78, 97 y 98), que ya estaban resueltos en la práctica, y 2 son subtareas que ya estaban finalizadas (AURA-99 y 101). El avance real del sprint es **cero tickets de producto cerrados** en estos 4 días.

Quedan abiertos **7 tickets**: AURA-76 (demostración de validación de recuerdos), 104 (memoria contextual, en revisión), 109 (pantalla de privacidad, en revisión), 134 (Drop-in en vivo, en revisión), 164 y 173 (errores) y 186 (documentación).

## 4. Sprint Review

> [!todo] Sprint Review
> Se completa al cierre del sprint. Lo que se prevé demostrar el 05/11: el sistema de punta a punta (Aurora Home, Aurora Core y Aurora Care) y, en particular, el Drop-in en vivo y la validación de recuerdos (AURA-76), que necesitan una demostración documentada.

## 5. Métricas (a la fecha)

| Métrica | Meta | Sprint 6 al 17/10 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **En curso** (7 de 14 cerrados; 0 de producto) | A mitad de camino no es una medida confiable. |
| Desvío de cierre | ≤ 2 días | **Se mide el 05/11** | Planificado: 05/11. |
| Carga por integrante | nadie sobre su capacidad | **No medible en horas** | Ver propuesta de estimación en el punto 7. |
| Trabajo arrastrado | causa registrada | **Se mide al cierre** | Cualquier ticket que no se cierre pasa al backlog final. |
| Incidencias abiertas P1/P2 | ningún P1 | **2 errores abiertos en el sprint**; 3 más sin sprint | AURA-164, AURA-173; sin sprint: AURA-110, 111 y 175. Hay que clasificarlos. |
| Calidad del código | ≥ 80 % de cobertura | Línea base del 16/10 | Core 1.579, Home 1.902, Care 1.190 y Worker IA 196 pruebas pasando. Cobertura no medida. |
| Mejora del proceso | — | Pendiente | Depende de la retrospectiva del Sprint 5. |

## 6. Retrospectiva

> [!todo] Retrospectiva
> Se realiza al cierre del sprint. Para esta última retro conviene incluir una mirada de **todo el proyecto**, que es además un entregable de la Instancia 5.

## 7. Backlog repriorizado: propuesta (a confirmar por el equipo)

Esta sección es una **propuesta del Scrum Master**: no se cambió nada en Jira. Hay dos problemas para resolver:

**a) La documentación y la presentación casi no están en el tablero.** El objetivo del sprint menciona la documentación del Docs y la presentación, pero hay un solo ticket (AURA-186). La Instancia 5 pide cinco entregables: manual de instalación y operación, documentación del proceso actualizada, retrospectiva del proyecto, instructivos de uso y análisis de impacto ambiental. **Lo que no está en el tablero no se puede planificar ni medir**, así que se propone crear un ticket por cada uno, más uno para preparar la presentación del 05/11 y otro para la demostración de AURA-76.

**b) Hay 9 tickets sin sprint.** Propuesta para el Sprint 6:

| Ticket | Propuesta | Motivo |
|---|---|---|
| AURA-110 y 111 | Entran | Errores que muestran información falsa al cuidador («todo en orden» cuando falla la carga; datos de demostración en «Alerta atendida»). Riesgo R8. |
| AURA-175 | Entra | El botón «Llamar» del detalle de alerta está siempre deshabilitado: afecta una función de emergencia. |
| AURA-176 | Entra con 110 | Migrar `Promise.all` a `allSettled` evita que una falla parcial rompa la pantalla entera. |
| AURA-147 | Entra | Gestión de secretos y variables de entorno: seguridad (R5). |
| AURA-148 | Entra (mínimo) | Respaldo diario de la base de datos, que la documentación declara como pendiente. |
| AURA-167 y 168 | Entran | Ya están en revisión; falta cerrarlos. |
| AURA-180 | Fuera del MVP | Cambiar la cadencia de reconfirmación es una decisión de producto; queda en el backlog posterior. |

Con esa propuesta el sprint quedaría con unos 22 tickets abiertos para 19 días. Dado que los sprints anteriores arrastraron más de la mitad, **conviene recortar antes que sumar**: priorizar lo que impacta en la demostración y en la seguridad, y dejar fuera lo demás de forma explícita.

## 8. Registro de riesgos (estado actual)

| Riesgo | Estado | Acción |
|---|---|---|
| Entrega final el 05/11 | Quedan 19 días con 7 tickets abiertos y la documentación de la Instancia 5 sin planificar | Cargar los entregables en Jira y asignar responsables esta semana. |
| R5 — Seguridad | Secretos (AURA-147) sin gestionar | Entra al sprint. |
| R8 — Falso negativo | AURA-110, 111, 164 y 175 abiertos | Entran al sprint. |
| R7 — Sobrecarga | Concentración en Octavio y Mateo; cierre con apuro en el sprint anterior | Repartir desde el inicio y no acumular al final. |
| Nuevo — Sin respaldo ni monitoreo | AURA-148 por hacer | Respaldo diario como mínimo. |
| Nuevo — Dependencia de la demostración | Drop-in en vivo y validación de recuerdos todavía no se demostraron | Ensayo de la demostración antes del 02/11. |

## 9. Artefactos previstos

- Entregables de la Instancia 5 (carpeta `INSTANCIA 5 — Fin de proyecto/`).
- Documento corregido (Docs de Google) y su réplica en el repositorio (AURA-186).
- Evidencia de demostración de AURA-76 (capturas o video).
