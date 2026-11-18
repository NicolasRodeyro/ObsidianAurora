---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
sprint: 7
jira_sprint: "SCRUM Sprint 8"
tipo: informe-sprint
estado: borrador al 2026-11-17, a validar con el equipo
Last updated time: "2026-11-17T00:00:00"
---

# Informe de Sprint 7 (borrador al 17/11/2026)

> [!warning] Borrador para validar
> Este informe se armó el 17/11/2026 a partir de Jira (iteración «SCRUM Sprint 8») y del Doc. No hay acta de la Sprint Review ni de la retrospectiva. Todo lo que dice el equipo (feedback, aprendizajes) queda marcado **[A COMPLETAR POR EL EQUIPO]**. Las fechas de la iteración no se pudieron leer de Jira y quedan **[A CONFIRMAR]**.

> [!info] Numeración
> El Sprint 7 de este documento corresponde a la iteración **«SCRUM Sprint 8»** de Jira. Es la iteración a la que pasó el trabajo pendiente del Sprint 6 al cerrarse el 07/11/2026. Ver la tabla de numeración en [[Desarrollo del Proyecto — Sprints 0, 1 y 2]]; hay que agregarle esta fila.

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 8 |
| Inicio | [A CONFIRMAR] (al cerrarse el Sprint 6, el 07/11/2026) |
| Fin | [A CONFIRMAR] |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez (igual que el Sprint 6) |

## 1. Objetivo del sprint

El sprint recibió lo que no se cerró en el Sprint 6: las seis tareas de producto arrastradas (AURA-76, 104, 109, 134, 164 y 173), cinco tareas de la línea de ubicación y celular del paciente (AURA-207, 213, 214, 215 y 216), la reconfirmación de recordatorios (AURA-180), los seis entregables de la Instancia 5 (AURA-187 a 192) y trabajo nuevo de cierre (AURA-193, 204, 221, 222 y 223). **El objetivo del sprint no figura en lo que se pudo leer de Jira**; el de esta lectura es: cerrar lo pendiente del MVP y entregar la documentación final de la Instancia 5. **[A CONFIRMAR con el equipo]**

## 2. Sprint Backlog (estado al 17/11/2026)

El sprint tiene **23 tickets**.

| Ticket | Tipo | Resumen | Responsable | Estado al 17/11 |
| --- | --- | --- | --- | --- |
| AURA-76 | Historia | US-D3 Descubrimientos con validación | Jeremías | In Revision |
| AURA-104 | Tarea | CORE-MEM01 Schema de memoria contextual del paciente | Jeremías | Finalizada (09/11) |
| AURA-109 | Historia | Pantalla de Privacidad y datos (Aurora Care) | Jeremías | Finalizada (09/11) |
| AURA-134 | Tarea | CORE-010 Drop-in en vivo (LiveKit) para Aurora Home | Jeremías | Finalizada (09/11) |
| AURA-164 | Error | Compliance sin filtro de fecha | Haik | Finalizada (09/11) |
| AURA-173 | Error | El cuidador principal se crea sin permiso de Drop-in | Haik | Finalizada (09/11) |
| AURA-180 | Tarea | Reconfirmación de recordatorios (3, 5 y 10 min escalonado) | Jeremías | Finalizada (09/11) |
| AURA-187 | Tarea | Instancia 5: proceso actualizado post-implementación | Nicolás | En curso |
| AURA-188 | Tarea | Instancia 5: instructivos de uso | Mateo | In Revision |
| AURA-189 | Tarea | Instancia 5: manual de instalación y operación | Octavio | Por hacer |
| AURA-190 | Tarea | Instancia 5: análisis de impacto ambiental | Haik | Finalizada (14/11) |
| AURA-191 | Tarea | Instancia 5: retrospectiva de proyecto | Jeremías | Por hacer |
| AURA-192 | Tarea | Instancia 5: presentación y demostración final | Jeremías | Finalizada (17/11) |
| AURA-193 | Tarea | Reporte de errores de Aurora Care a Aurora Core, sin datos de la persona | Mateo | Finalizada (09/11) |
| AURA-204 | Tarea | Formalizar ADR e historias de recuerdos en el vault | Octavio | Finalizada (09/11) |
| AURA-207 | Historia | Botón «Necesito ayuda» con ubicación puntual y consentimiento | Mateo | Finalizada (09/11) |
| AURA-213 | Tarea | Alerta «Perdimos la señal del celular» y programarla en n8n | Mateo | In Revision |
| AURA-214 | Tarea | Despliegue y QA en celulares reales de la ubicación en vivo | Mateo | Finalizada (09/11) |
| AURA-215 | Tarea | Validación legal de los consentimientos y encuadre documental de ubicación y geofencing | Mateo | In Revision |
| AURA-216 | Historia | Celular del paciente: mejora de juegos y terapias (Fases 0 a 4) | Mateo | Finalizada (09/11) |
| AURA-221 | Tarea | n8n: programar la purga de ubicaciones, la de reportes de error y el barrido de silencio | Octavio | Por hacer |
| AURA-222 | Tarea | Aurora multiidioma | Haik | Finalizada (15/11) |
| AURA-223 | Tarea | Completar los campos [A COMPLETAR] del Doc | Haik | Finalizada (16/11) |

## 3. Sprint Review (reconstruida desde Jira y el Doc)

**Qué se pudo demostrar.** La demostración final del 16/11/2026 mostró los ocho procesos descriptos en el Proceso Actualizado: consulta a Aurora, alerta con Drop-in, terapias personalizadas, ubicación de la paciente, juegos visuales, chat, atención de una alerta y alertas por omisión. El Drop-in se mostró en vivo. El proceso de terapias personalizadas **no funciona de punta a punta**: se mostró solo su diagrama. AURA-192 se cerró el 17/11.

**Qué se cerró.** Quince tickets: cinco de los seis arrastrados (todos salvo AURA-76), AURA-180, la línea de ubicación y celular del paciente (AURA-207, 214 y 216), AURA-193 y 204, los entregables AURA-190 (análisis ambiental, 14/11) y AURA-192 (presentación, 17/11), el multiidioma (AURA-222, 15/11) y la reconstrucción de los campos pendientes del Doc (AURA-223, 16/11).

**Qué no llegó.** AURA-76 queda en revisión hasta desplegarla y demostrarla de punta a punta. AURA-213 (alerta de pérdida de señal) y AURA-215 (validación legal) siguen en revisión. Por hacer: AURA-189 (manual de instalación y operación), AURA-191 (retrospectiva de proyecto) y AURA-221 (programar en n8n la purga y el barrido de silencio). AURA-187 sigue en curso y AURA-188 en revisión.

**Feedback del equipo y de la docente:** [A COMPLETAR POR EL EQUIPO]. No hay registro.

**Cómo leer los cierres.** Nueve de los quince cierres (AURA-104, 109, 134, 180, 193, 204, 207, 214 y 216) se hicieron en lote el 09/11/2026 a las 17:10, durante la auditoría de cierre contra el código. Esos tickets estaban resueltos en la práctica; los cierres reflejan la depuración del tablero más que trabajo hecho ese día. Los de AURA-164 y 173 sí corresponden a correcciones, cerradas el mismo 09/11.

## 4. Métricas

| Métrica | Meta | Sprint 7 | Lectura |
| --- | --- | --- | --- |
| Cumplimiento del sprint | ≥ 80 % | 65 % (15 de 23 tickets del sprint) | No se cumple. Los comprometidos al inicio no están registrados, así que se cuenta todo lo que figura en el sprint. 9 de los 15 cierres son depuración del tablero. |
| Desvío de cierre | ≤ 2 días | [A CONFIRMAR] | Faltan las fechas de la iteración. |
| Carga por integrante | nadie sobre su capacidad | No medible en horas | Jeremías 7 tickets, Mateo 7, Haik 5, Octavio 3, Nicolás 1. |
| Trabajo arrastrado | causa registrada | 8 tickets abiertos (35 %) | AURA-76, 187, 188, 189, 191, 213, 215 y 221. Causas: la demostración de recuerdos sin desplegar, la validación legal y la programación en n8n sin hacer, y los entregables de documentación. |
| Incidencias abiertas P1/P2 | ningún P1 | 0 en el sprint; 3 sin sprint | AURA-110, 111 y 175 siguen abiertos y sin clasificar, fuera de todo sprint. |
| Calidad del código | ≥ 80 % de cobertura | Sin nueva medición | La línea base es la del 16/10. La cobertura no se mide. |
| Mejora del proceso | — | AURA-223 | Se reconstruyeron las reviews y retrospectivas de los Sprints 4 a 6 desde Jira; falta que el equipo las valide. |

## 5. Retrospectiva

**No hay registro de una sesión de retrospectiva para este sprint.** Lo que sigue sale de los datos y se propone para discutirlo con el equipo.

- **Lo que muestran los datos.** Se cerró lo que bloqueaba la demostración (Drop-in, memoria, privacidad, errores de alertas), y la documentación final avanzó: un entregable finalizado, uno en revisión, uno en curso.
- **Lo que quedó sin cerrar.** El manual de instalación y operación (AURA-189) y la retrospectiva de proyecto (AURA-191) no empezaron. El manual depende de la gestión de secretos y de los respaldos (AURA-147 y 148), que siguen fuera de todo sprint.
- **Lo que se corrigió al revisar el Doc el 17/11.** El escalamiento de alertas al siguiente cuidador figuraba como integrado y no lo está; el intervalo de repetición del recordatorio figuraba como 10 minutos en los instructivos y es de 3.

**Aprendizajes y acciones:** [A COMPLETAR POR EL EQUIPO].

## 6. Backlog repriorizado

Abiertos al 17/11/2026, sin decidir quién los toma ni si entran en alguna iteración posterior:

- **Para cerrar la documentación:** AURA-187, 188, 189 y 191.
- **Para cumplir lo prometido en los consentimientos:** AURA-221 (la purga de ubicaciones a los 7 días no corre sola) y AURA-213 (alerta de pérdida de señal).
- **Para cerrar la validación de recuerdos:** AURA-76.
- **Sin sprint desde el 17/10:** AURA-110, 111, 147, 148, 167, 168, 175 y 176. Siguen abiertos los riesgos R5 y R8 ligados a ellos (ver [[Registro de Riesgos]]).

## 7. Registro de riesgos

El registro completo y vigente está en [[Registro de Riesgos]]. Cambios de este sprint: R8 baja un ticket abierto (AURA-164 se cerró), R22 se actualiza (los entregables ya tienen responsable) y se proponen dos riesgos nuevos, R23 (consentimientos de ubicación sin validación legal, AURA-215) y R24 (borrado a los 7 días sin proceso automático, AURA-221).
