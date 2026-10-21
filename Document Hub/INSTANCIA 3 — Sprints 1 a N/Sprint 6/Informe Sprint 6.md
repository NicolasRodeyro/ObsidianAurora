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

El sprint tiene **20 tickets**: 13 arrastrados del Sprint 5 y 7 nuevos de documentación (AURA-186 y los 6 entregables de la Instancia 5, AURA-187 a 192, creados el 17/10). Estado al 17/10:

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
| AURA-187 | Tarea | Instancia 5 · Documentación del proceso actualizado post-implementación | Sin asignar | Nuevo (Instancia 5, creado el 17/10) | Tareas por hacer |
| AURA-188 | Tarea | Instancia 5 · Instructivos de uso (Aurora Care y Aurora Home) | Sin asignar | Nuevo (Instancia 5, creado el 17/10) | Tareas por hacer |
| AURA-189 | Tarea | Instancia 5 · Manual de instalación y operación | Sin asignar | Nuevo (Instancia 5, creado el 17/10) | Tareas por hacer |
| AURA-190 | Tarea | Instancia 5 · Análisis de impacto ambiental | Sin asignar | Nuevo (Instancia 5, creado el 17/10) | Tareas por hacer |
| AURA-191 | Tarea | Instancia 5 · Retrospectiva de proyecto | Sin asignar | Nuevo (Instancia 5, creado el 17/10) | Tareas por hacer |
| AURA-192 | Tarea | Instancia 5 · Presentación y demostración final (05/11) | Sin asignar | Nuevo (Instancia 5, creado el 17/10) | Tareas por hacer |

**Cómo leer el avance:** hay 7 tickets finalizados de 20 (35 %), pero **5 de esos cierres son depuración del tablero** (AURA-64, 74, 78, 97 y 98), que ya estaban resueltos en la práctica, y 2 son subtareas que ya estaban finalizadas (AURA-99 y 101). El avance real del sprint es **cero tickets de producto cerrados** en estos 4 días.

Quedan abiertos **13 tickets**: seis de producto (AURA-76, demostración de validación de recuerdos; 104, memoria contextual, en revisión; 109, pantalla de privacidad, en revisión; 134, Drop-in en vivo, en revisión; 164 y 173, errores) y siete de documentación (AURA-186 a 192). **Los siete de documentación todavía no tienen avance, y seis de ellos no tienen responsable.**

## 4. Sprint Review

> [!todo] Sprint Review
> Se completa al cierre del sprint. Lo que se prevé demostrar el 05/11: el sistema de punta a punta (Aurora Home, Aurora Core y Aurora Care) y, en particular, el Drop-in en vivo y la validación de recuerdos (AURA-76), que necesitan una demostración documentada.

## 5. Métricas (a la fecha)

| Métrica | Meta | Sprint 6 al 17/10 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **En curso** (7 de 20 cerrados; 0 de producto) | A mitad de camino no es una medida confiable. |
| Desvío de cierre | ≤ 2 días | **Se mide el 05/11** | Planificado: 05/11. |
| Carga por integrante | nadie sobre su capacidad | **No medible en horas** | Ver propuesta de estimación en el punto 7. |
| Trabajo arrastrado | causa registrada | **Se mide al cierre** | Cualquier ticket que no se cierre pasa al backlog final. |
| Incidencias abiertas P1/P2 | ningún P1 | **2 errores abiertos en el sprint**; 3 más sin sprint | AURA-164, AURA-173; sin sprint: AURA-110, 111 y 175. Hay que clasificarlos. |
| Calidad del código | ≥ 80 % de cobertura | Línea base del 16/10 | Core 1.579, Home 1.902, Care 1.190 y Worker IA 196 pruebas pasando. Cobertura no medida. |
| Mejora del proceso | — | Pendiente | Depende de la retrospectiva del Sprint 5. |

## 6. Retrospectiva

> [!todo] Retrospectiva
> Se realiza al cierre del sprint. Para esta última retro conviene incluir una mirada de **todo el proyecto**, que es además un entregable de la Instancia 5.

## 7. Backlog repriorizado

Cambios al 17/10/2026 y decisiones pendientes:

**a) Los entregables de la Instancia 5 ya están en el tablero.** El objetivo del sprint menciona la documentación y la presentación, y hasta el 17/10 había un solo ticket (AURA-186). Ese día se cargaron 6 tickets más, en este sprint y bajo la épica AURA-13 «Documentación para Proyecto», **sin responsable asignado todavía**:

| Ticket | Entregable |
|---|---|
| AURA-187 | Documentación del proceso actualizado post-implementación |
| AURA-188 | Instructivos de uso (Aurora Care y Aurora Home) |
| AURA-189 | Manual de instalación y operación (depende de AURA-147 y 148) |
| AURA-190 | Análisis de impacto ambiental |
| AURA-191 | Retrospectiva de proyecto |
| AURA-192 | Presentación y demostración final del 05/11, incluida la demostración documentada de AURA-76 y AURA-134 |

Con estos tickets el sprint pasa de 14 a 20, de los cuales 13 están abiertos. **Falta repartir los responsables**: un ticket sin responsable no avanza.

**b) Los 9 tickets sin sprint se dejan como están** (decisión del 17/10/2026): AURA-110, 111, 147, 148, 167, 168, 175, 176 y 180 siguen fuera de cualquier sprint. Esta tabla recoge la propuesta del Scrum Master, que **no se aplicó**, como referencia de lo que implica no hacerlo:

| Ticket | Propuesta (no aplicada) | Motivo |
|---|---|---|
| AURA-110 y 111 | Entrar | Errores que muestran información falsa al cuidador («todo en orden» cuando falla la carga; datos de demostración en «Alerta atendida»). Riesgo R8. |
| AURA-175 | Entrar | El botón «Llamar» del detalle de alerta está siempre deshabilitado: afecta una función de emergencia. |
| AURA-176 | Entrar con 110 | Migrar `Promise.all` a `allSettled` evita que una falla parcial rompa la pantalla entera. |
| AURA-147 | Entrar | Gestión de secretos y variables de entorno: seguridad (R5). También es insumo del manual de instalación (AURA-189). |
| AURA-148 | Entrar (mínimo) | Respaldo diario de la base de datos, que la documentación declara como pendiente. Insumo de AURA-189. |
| AURA-167 y 168 | Entrar | Ya están en revisión; falta cerrarlos. |
| AURA-180 | Fuera del MVP | Cambiar la cadencia de reconfirmación es una decisión de producto; queda en el backlog posterior. |

Si todos esos tickets entraran, el sprint tendría 21 tickets abiertos para 19 días. Dado que los sprints anteriores arrastraron más de la mitad, **conviene recortar antes que sumar**; mientras no entren, los riesgos R5 y R8 de la sección 8 siguen abiertos y hay que aceptarlos de forma explícita.

## 8. Registro de riesgos (estado actual)

Registro completo y vigente de todos los riesgos: [[Registro de Riesgos]].

| Riesgo | Estado | Acción |
|---|---|---|
| Entrega final el 05/11 | Quedan 19 días con 13 tickets abiertos; los 6 entregables de la Instancia 5 están cargados (AURA-187 a 192) pero **sin responsable** | Asignar responsables esta semana. |
| R5 — Seguridad | Secretos (AURA-147) sin gestionar; el ticket está fuera de todo sprint | Decisión del 17/10: no entra. Aceptar el riesgo de forma explícita o reconsiderar; además es insumo del manual de instalación (AURA-189). |
| R8 — Falso negativo | AURA-110, 111, 164 y 175 abiertos; AURA-164 está en el sprint y los otros tres fuera | Decisión del 17/10: 110, 111 y 175 no entran. Aceptar el riesgo de forma explícita o reconsiderar. |
| R7 — Sobrecarga | Concentración en Octavio y Mateo; cierre con apuro en el sprint anterior | Repartir desde el inicio y no acumular al final. |
| Nuevo — Sin respaldo ni monitoreo | AURA-148 por hacer y fuera de todo sprint | Como mínimo, documentar la recomendación de respaldo diario en el manual (AURA-189). |
| Nuevo — Dependencia de la demostración | Drop-in en vivo y validación de recuerdos todavía no se demostraron | Ensayo de la demostración antes del 02/11. |

## 9. Artefactos previstos

- Entregables de la Instancia 5, en la carpeta `INSTANCIA 5 — Fin de proyecto/`: documentación del proceso (AURA-187), instructivos de uso (AURA-188), manual de instalación y operación (AURA-189), análisis de impacto ambiental (AURA-190) y retrospectiva de proyecto (AURA-191).
- Documento corregido (Docs de Google) y su réplica en el repositorio (AURA-186).
- Guion de la presentación del 05/11 y evidencia de la demostración de AURA-76 y AURA-134, con capturas o video (AURA-192).
- Informe de este sprint completo, con la Sprint Review y la retrospectiva, al cierre.
