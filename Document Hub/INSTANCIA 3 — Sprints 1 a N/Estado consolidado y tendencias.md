---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-18
---

# Estado consolidado y tendencias

Esta sección reúne el estado del proyecto al **17/10/2026**, cómo evolucionaron las métricas de un sprint a otro y qué aprendió el equipo del proceso. Complementa los informes de cada sprint ([[Informe Sprint 1]], [[Informe Sprint 2]], [[Informe Sprint 3]], [[Informe Sprint 4]], [[Informe Sprint 5]] e [[Informe Sprint 6]]), que son la fuente de cada dato. Los riesgos están en el [[Registro de Riesgos]].

## 1. Estado por subsistema

La columna «Autoría principal» se basa en la autoría real de los repositorios (git) y en los roles del equipo, no en el responsable cargado en Jira, que en varios períodos no es confiable.

| Subsistema | Autoría principal | Estado al 17/10/2026 |
| --- | --- | --- |
| Documentación y gestión | Jeremías (Project Manager y Scrum Master) y todo el equipo | Project Charter, Requerimientos (98 RF y 52 RNF), Arquitectura y Stack Tecnológico (12 ADR), Plan de Testing y este documento. Hay una corrección de la cátedra del 12/10/2026 en curso de aplicación (AURA-186). |
| Diseño (Design System y UX/UI) | Nicolás y Jeremías | Completo y verificado con los criterios WCAG AA y AAA. El envío del design system a Figma sigue pendiente por el límite del plan gratuito. |
| Modelo de datos | Mateo y Nicolás | DER de 50 tablas en 10 módulos, dibujado en 8 vistas. Las migraciones viven en Aurora Core. |
| Aurora Core (backend) | Octavio, Haik y Mateo | API REST y WebSocket operativas: rutinas, medicación, alertas con push, dashboard, zonas seguras, consentimiento informado, memoria del paciente con consulta de IA, sesiones diarias de terapia, Drop-in y canal de comandos hacia Aurora Home. La suite del equipo pasa con 1.579 pruebas (16/10). Pendientes: AURA-173 y AURA-164, gestión de secretos y respaldos. |
| Aurora Worker IA | Haik y Octavio | Servicio nuevo desde el 14/09: consulta a la memoria del paciente y generación del plan diario de sesiones. 196 pruebas pasando. |
| Aurora Home (Raspberry Pi) | Mateo, con Octavio | Corre como servicio de la Raspberry Pi, con voz local (Whisper y Piper), recordatorios que funcionan sin conexión, heartbeat y comandos seguros con Core, ejecución de las sesiones diarias y cliente de Drop-in. 1.902 pruebas en la línea base del 16/10. Pendientes: latencia de voz (p95 de 8,02 s frente al objetivo de 2 s) y la validación con hardware real del botón SOS durante una conversación. |
| Aurora Care (app móvil) | Todo el equipo, según el sprint | Dashboard, feed de alertas con notificaciones push, rutinas, medicación, terapias, recuerdos con fotos, alta del hogar con consentimiento y UI de Drop-in. 1.190 pruebas en la línea base del 16/10. Pendientes: pantalla de Privacidad (AURA-109, en revisión) y errores AURA-110, 111 y 175. |
| Infraestructura y despliegue | Jeremías y Octavio | Staging en un VPS de Hostinger (Docker Compose y Traefik) con despliegue automático desde GitHub Actions. Sin monitoreo ni respaldos definidos todavía (AURA-147 y 148, fuera de todo sprint). |
| Aurora Band (pulsera) | — | Fuera del MVP por restricción presupuestaria (decisión del 29/08/2026). Se conserva como visión de futuras versiones. |

## 2. Tendencia de las métricas

Las métricas son las que fija el Plan de Proyecto. Solo se pueden medir los sprints que tuvieron tickets cargados y cerrados en Jira: el Sprint 0 fue de definición y el Sprint 2 («SCRUM Sprint 3» de Jira) quedó sin tickets, por lo que no tienen medición.

| Métrica | Meta | Sprint 1 | Sprint 3 | Sprint 4 | Sprint 5 | Sprint 6 |
| --- | --- | --- | --- | --- | --- | --- |
| Cumplimiento del sprint | ≥ 80 % | 88 % | 47 % | 47 % | 61 % | En curso |
| Trabajo arrastrado al sprint siguiente | Causa registrada | 12 % | 61 % | 57 % | 28 % | Se mide al cierre |
| Desvío de cierre | ≤ 2 días | +25 días | +3 días | +1 día | +7 días | Se mide el 05/11 |

**Lectura.** El desvío de cierre mejoró mucho desde el Sprint 1 (+25 días) hasta el Sprint 4 (+1 día), pero volvió a empeorar en el Sprint 5 (+7 días), con el cierre concentrado en los últimos días y dos hitos encima (la jornada de presentación del 06/10 y las correcciones de la cátedra del 12/10). El cumplimiento no volvió a la meta del 80 % desde el Sprint 1, aunque en el Sprint 5 subió a 61 % y el trabajo arrastrado bajó a 28 %. La calidad del código se sostuvo: los archivos de test de Aurora Core pasaron de 4 a 114, hay integración continua desde el 29/08 y la suite completa pasó el 16/10 con 1.579 pruebas en Aurora Core, 1.902 en Aurora Home, 1.190 en Aurora Care y 196 en el Worker IA. La cobertura todavía no se mide.

## 3. Hallazgos de proceso

- **Los sprints se estiran.** Los cuatro sprints medidos cerraron después de la fecha planificada; el Sprint 1 lo hizo con 25 días de desvío.
- **El tablero de Jira es poco confiable.** La numeración de los sprints no coincide con la de la documentación (el «Sprint 3» de Jira quedó vacío) y hay tickets finalizados sin sprint. Por eso la sección de numeración de este documento incluye la equivalencia y cada informe aclara su iteración de Jira. Ver el riesgo R16 del [[Registro de Riesgos]].
- **El backend arrancó tarde.** Recién en el Sprint 2 aparece código de servidor; mientras tanto, la conexión de la app con la base de datos estuvo bloqueada (AURA-63).
- **El trabajo se concentra en pocas personas y al final del sprint.** En el Sprint 5, Octavio y Mateo concentraron el 57 % de los tickets y el 40 % de los commits se hizo en los últimos 6 días del plazo. Ver los riesgos R7, R19 y R21 del [[Registro de Riesgos]].
- **Las retrospectivas se registraron de forma desigual.** La planilla del equipo cubre hasta el Sprint 3; faltan las de los Sprints 4 a 6, y por eso en esos informes figuran marcadas como pendientes.
- **Los errores no se cargaban como tickets.** Desde el Sprint 5 sí se cargan (9 en ese sprint), lo que mejora la trazabilidad del trabajo de corrección.
- **Los límites de las herramientas externas condicionan el trabajo.** El plan gratuito de Figma (6 lecturas por mes) frenó el envío del design system.

## 4. Aportes transversales y acciones acordadas

La retrospectiva combinada del equipo (técnica de las 4 L's) dejó aportes que abarcan todos los sprints o no se pueden atribuir a uno solo.

- **Lo que faltó:** constancia (todos menos Mateo).
- **Lo que hubiéramos querido tener:** presupuesto para Hostinger, más tiempo y una profesora más presente.

El equipo acordó seis acciones para mejorar el proceso, con objetivo en el Sprint 3. Su estado se evaluó en el informe del Sprint 4:

| # | Acción | Deriva de | Estado al 17/10/2026 |
| --- | --- | --- | --- |
| 1 | DoD como normativa para cada IA o skill | Falta de DoD aplicado | Implementada (plantilla de PR con checklist y skill versionada, 29/08) |
| 2 | GitHub Actions para CI/CD | CI/CD declarado pero inexistente | Implementada (CI en Core y Care desde el 29/08; despliegue automático de Core el 08/09 y de Care el 04/10) |
| 3 | PRs vinculadas al ticket y con convención de nombres | Convención de ramas incumplida | Parcial (14 de 87 PRs de Core llevan el ticket en la rama) |
| 4 | Restringir la creación de PRs que no cumplan la convención | Revisión cruzada débil | No implementada |
| 5 | Cron para Supabase | Operación de la base de datos | Sin evidencia (AURA-148 sigue por hacer) |
| 6 | Llenar la base de datos de prueba | N+1 solo visibles con volumen | Parcial (existe `seed_local`; falta confirmar si el volumen alcanza) |

De las seis, dos están implementadas (33 %), dos son parciales y dos no se hicieron. Las dos implementadas son las que se podían resolver con una plantilla o un archivo de configuración; las que requerían decidir una regla o programar una tarea quedaron sin hacer.
