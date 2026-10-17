---
sprint: 4
jira_sprint: "SCRUM Sprint 5 (id 70)"
fecha_inicio: "2026-08-27"
fecha_fin_planificada: "2026-09-16"
fecha_cierre: "2026-09-17"
tipo: informe-sprint
---

# Informe de Sprint 4

> [!info] Numeración
> El Sprint 4 corresponde a la iteración **«SCRUM Sprint 5»** de Jira (id 70). Ver la tabla de equivalencias en [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 5 (id 70) |
| Inicio | 27/08/2026 |
| Fin planificado | 16/09/2026 |
| Cierre en Jira | 17/09/2026 (+1 día) |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez |

## 1. Objetivo del sprint

Que Aurora Home converse y recuerde la medicación de forma local, que Core guarde la memoria del paciente y envíe alertas push, y que Care muestre datos reales.

> [!note] El objetivo se redactó a posteriori
> Jira no tenía objetivo cargado para este sprint. Este texto se escribió el 17/10/2026 a partir de lo que el sprint entregó, y se cargó en Jira en esa fecha.

**¿Se cumplió?** **En parte.** La parte de Aurora Home se cumplió: voz local, conversación e intenciones y recordatorios sin conexión (AURA-151 a 156), además de la prueba de punta a punta entre Home y Core (AURA-103 y 123). La memoria del paciente, las alertas push y la conexión de Care con datos reales (AURA-104 a 108) pasaron al Sprint 5.

## 2. Equipo y capacidad

Equipo y roles como en el [[Informe Sprint 1]]. Capacidad declarada: 84 h por semana, 252 h por sprint (≈ 202 h con el 20 % de margen). Los tickets siguen sin estimarse en horas.

| Persona | Capacidad semanal | % de la capacidad | Tickets en el sprint | % de los tickets | Finalizados en el sprint |
|---|---|---|---|---|---|
| Octavio | 15 h | 18 % | 10 | 27 % | 3 |
| Mateo | 16 h | 19 % | 13 | 35 % | 11 |
| Haik | 18 h | 21 % | 5 | 14 % | 2 |
| Jeremías | 13 h | 15 % | 7 | 19 % | 0 |
| Nicolás | 22 h | 26 % | 1 | 3 % | 0 |

Mateo concentró el 35 % de los tickets (19 % de la capacidad) y cerró **11 de los 16** tickets finalizados, casi todos de Aurora Home. Esa dependencia de una sola persona es un riesgo: si no está, Home no avanza.

## 3. Sprint Backlog

El sprint tuvo **37 tickets**: **19 al inicio**, todos arrastrados del Sprint 3, y **18 agregados durante el sprint**. **Ningún ticket nuevo entró al compromiso inicial: el sprint arrancó lleno de deuda del anterior.** Se finalizaron **16** tickets dentro del sprint y **21** pasaron al Sprint 5.

| Key | Tipo | Resumen | Responsable (Jira) | Entró | Resultado | Estado actual |
|---|---|---|---|---|---|---|
| AURA-63 | Tarea | Implementar Conexión entre Care y la BD | Haik | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-64 | Análisis | Investigación Pulsera para Aurora Band | Haik | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-74 | Historia | US-D1 — Sesión guiada de terapia | Jeremías | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-76 | Historia | US-D3 — Descubrimientos con validación | Jeremías | Al inicio | Pasó al Sprint 5 | En curso |
| AURA-77 | Historia | US-D4 — Dificultad adaptativa | nicolasrodeyro | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-78 | Historia | Registro y perfil del paciente | Jeremías | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-85 | Historia | API REST: Dashboard del Cuidador (estado actual del paciente) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-86 | Historia | API REST: CRUD de Zonas Seguras (geofencing por paciente) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-90 | Tarea | AH-M01 - Crear base inicial del repositorio Aurora Home | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-91 | Tarea | AH-M02 - Definir contratos v1 y simulador local Home-Core | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-92 | Tarea | Deploy de AuroraCareBack en Render (entorno dev) | Jeremías | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-93 | Tarea | ADR formal de cifrado de PII (Ley 25.326) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-95 | Tarea | AH-M03 — Fundación local resiliente (SQLite, outbox y resiliencia) | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-97 | Subtarea | Mecanismo y ADR formal de cifrado de PII (DNI y nombre) conforme a la Ley 25.326 | Octavio | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-98 | Subtarea | API operativa de consentimiento informado para registrar y consultar consent_records desde el onboarding | Octavio | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-99 | Subtarea | Asistencia de backend a AURA-74 | Haik | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-101 | Subtarea | Implementación del backend (subtarea) | Octavio | Al inicio | Pasó al Sprint 5 | Finalizada |
| AURA-102 | Tarea | CORE-012 · Normalizar contrato OpenAPI y contract tests de Aurora Home | Haik | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-103 | Tarea | HOME-0409 · Ejecutar E2E real de configuración y eventos Aurora Home ↔ Core | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-104 | Tarea | CORE-MEM01 — Schema de memoria contextual del paciente en AuroraCore | Jeremías | Durante el sprint | Pasó al Sprint 5 | In Revision |
| AURA-105 | Historia | CORE-MEM02 — Endpoint RAG: consulta de contexto del paciente con LLM | Octavio | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-106 | Historia | API REST: Envío proactivo de alertas push al cuidador | Octavio | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-107 | Historia | Vista de alertas en tiempo real — panel del cuidador (AuroraCare) | Haik | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-108 | Historia | Conectar pantallas de AuroraCare con endpoints reales de AuroraCore | Jeremías | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-109 | Historia | Pantalla de Privacidad y datos (Aurora Care) | Jeremías | Durante el sprint | Pasó al Sprint 5 | In Revision |
| AURA-112 | Error | El campo de fecha de nacimiento no funciona en web y no permite tipear | Mateo | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-113 | Error | El selector de etapa de enfermedad es ilegible en modo oscuro | Mateo | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-115 | Error | El CRUD de rutinas apunta a una ruta inexistente | - | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-123 | Tarea | HOME-0606 · Consolidar evidencia y cierre del turno conversacional local | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-136 | Subtarea | Backend (subtarea) | Octavio | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-149 | Historia | Generación de interacciones y sesiones diarias | Octavio | Durante el sprint | Pasó al Sprint 5 | Finalizada |
| AURA-151 | Tarea | HOME-0509 · Componer recordatorios automáticos, respuesta y Outbox en runtime | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-152 | Tarea | PM-2026/HOME-04 · HomeRuntime y systemd | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-153 | Tarea | PM-2026/HOME-05 · Hardware real y diagnósticos | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-154 | Tarea | PM-2026/HOME-06 · Pipeline de voz local | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-155 | Tarea | PM-2026/HOME-07 · Conversación e intenciones locales | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-156 | Tarea | PM-2026/HOME-08 · Recordatorios offline | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |

**Trabajo finalizado sin sprint en el período:** AURA-116, 117, 118, 120, 121 y 122 (diseño de escritorio con barra lateral, aislamiento web/nativo, botón de llamada, control de acceso, pruebas de onboarding y evidencia del E2E de Home) se crearon entre el 06 y el 07/09 y se finalizaron sin asignarles sprint, por lo que no cuentan en las métricas de arriba.

**Por qué pasaron 21 tickets al Sprint 5:**

- **Memoria, alertas push y Care con datos reales (AURA-104 a 109):** se crearon el 28/08 y se terminaron en el Sprint 5 (AURA-104 y 109 siguen en revisión).
- **Errores de Care (AURA-112, 113, 115):** se corrigieron en el Sprint 5.
- **Historias de terapia (AURA-74, 76, 77, 78) y subtareas de privacidad (AURA-97, 98, 99, 101):** dependían de funcionalidades que se construyeron más adelante.
- **Deploy en Render (AURA-92), investigación de la pulsera (AURA-64), subtarea de backend (AURA-136) y sesiones diarias (AURA-149).**

## 4. Sprint Review

**Qué se pudo demostrar** (evidencia en los repositorios y en Jira):

- Aurora Home como servicio de la Raspberry Pi: `HomeRuntime` con systemd, hardware real y diagnósticos (AURA-152 y 153).
- Pipeline de voz local, conversación e intenciones locales y recordatorios sin conexión (AURA-154, 155 y 156).
- Recordatorios automáticos con respuesta y cola de salida (*outbox*) en ejecución (AURA-151).
- Prueba de punta a punta de configuración y eventos entre Home y Core, con su evidencia documentada (AURA-103 y 123).
- Contrato OpenAPI normalizado y *contract tests* de Aurora Home (AURA-102).
- Integración continua en Core y Care (desde el 29/08) y pipeline de despliegue de Core (08/09).

> [!todo] Feedback recibido
> Falta registrar quiénes asistieron a la Sprint Review y qué feedback dieron la docente y el equipo. Se completa con el formulario del equipo.

## 5. Métricas y tendencia

| Métrica | Meta | Sprint 4 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **47 %** (9 de 19 comprometidos al inicio; 16 de 37 contando lo agregado) | No se cumple. Igual que el Sprint 3, pero esta vez los 19 tickets del compromiso eran deuda heredada. |
| Desvío de cierre | ≤ 2 días | **+1 día** (16/09 → 17/09) | Se cumple. |
| Carga por integrante | nadie sobre su capacidad | **No medible en horas** | Mateo tiene el 35 % de los tickets con el 19 % de la capacidad. |
| Trabajo arrastrado | causa registrada | **21 tickets (57 %)** | Causas en el punto 3. |
| Incidencias abiertas P1/P2 | ningún P1 | **5 errores registrados, ninguno resuelto al cierre** | Es la primera vez que los errores se cargan como tickets: 3 se corrigieron en el Sprint 5 y 2 siguen abiertos (AURA-110 y 111). Todavía no se clasifican por criticidad. AURA-110 («Inicio muestra todo en orden cuando falla la carga del resumen») es un riesgo de falso negativo (R8). |
| Calidad del código | ≥ 80 % de cobertura | **Cobertura no medida**; CI activo | Los archivos de test pasaron de 38 a 57 en AuroraCore y de 52 a 91 en AuroraHome durante el sprint. |
| Mejora del proceso | — | **2 de 6 acciones implementadas (33 %)** | Detalle en el punto 6. |

**Tendencia:** el cumplimiento se mantiene en 47 % (88 % en el Sprint 1 y 47 % en el Sprint 3) y el trabajo arrastrado sigue arriba (61 % y 57 %). El desvío es la métrica que se corrigió: +25, +3 y ahora +1 día. En paralelo, el volumen de pruebas creció de forma notable. **La lectura es que el equipo aprendió a cerrar a tiempo pero todavía no a comprometerse con lo que puede terminar.**

## 6. Retrospectiva

> [!todo] Retrospectiva de este sprint
> La planilla de retrospectivas del equipo llega hasta el Sprint 3. Falta registrar qué funcionó, qué se aprendió y qué faltó en este sprint. Se completa con el formulario del equipo.

**Aportes de la planilla que corresponden a este período**

- Aprendimos a armar el hardware de Aurora Home e instalarle y configurarle el software (Haik y Mateo; ubicado acá por AURA-153, «Hardware real y diagnósticos»).

**Análisis del Scrum Master**

- Todo el compromiso inicial fue deuda del sprint anterior. Si no se corta el arrastre, el sprint nunca empieza limpio.
- Hay riesgo de dependencia de una persona para Aurora Home.

**Estado de las acciones del sprint anterior** (acciones de la retrospectiva del Sprint 3, con plazo al fin de este sprint)

| # | Acción | Estado al 17/10/2026 | Evidencia |
|---|---|---|---|
| 1 | DoD como normativa para cada IA o skill | **Implementada** | Plantilla de PR con checklist de seguridad y verificación en Core y Care (29/08) y skill `pr-flow` versionada en el vault (29/08). |
| 2 | GitHub Actions para CI/CD | **Implementada** | CI en Core y Care desde el 29/08 (Home desde el 01/08); despliegue automático de Core el 08/09 y de Care el 04/10. |
| 3 | PRs vinculadas al ticket y con convención de nombres | **Parcial** | La plantilla pide el ticket, pero solo 14 de 87 PRs de Core llevan el ticket en el nombre de la rama (0 de 17 durante los Sprints 3 y 4); en Care 15 de 60 y en Home 6 de 79. |
| 4 | Restringir la creación de PRs que no cumplan la convención | **No implementada** | Ningún workflow valida el nombre de la rama ni el título (si hay reglas de protección en GitHub, hay que verificarlas). |
| 5 | Cron para Supabase | **Sin evidencia** | No hay workflow ni tarea programada en los repositorios; AURA-148 (backups y monitoreo) sigue por hacer. |
| 6 | Llenar la base de datos de prueba | **Parcial** | Existe `seed_local` y la guía `docs/local-seed.md` (04/09); falta confirmar si el volumen alcanza para detectar N+1. |

**Mejora del proceso:** 2 de 6 acciones implementadas (33 %), 2 parciales y 2 sin implementar. Las dos implementadas son las que se podían resolver con una plantilla o un archivo de configuración; las que requerían decidir una regla o programar una tarea quedaron sin hacer.

**Action items de este sprint:** pendientes de la retrospectiva del Sprint 4.

## 7. Product Backlog repriorizado

En la última semana del sprint (7 y 8/09) se cargaron los tickets del Sprint 5: comandos autenticados y WebSocket para Home (CORE-007), Drop-in en vivo (CORE-010), planes de terapia versionados (CORE-009), revocación y rotación de credenciales de Home (CORE-011) y las tareas de infraestructura: VPS Hostinger, proxy inverso con TLS, Docker, staging, n8n y CD con GitHub Actions (AURA-140 a 148). La prioridad pasó a **llevar el sistema a un entorno de staging real**.

## 8. Registro de riesgos (cambios en este sprint)

Registro completo y vigente de todos los riesgos: [[Registro de Riesgos]].

| Riesgo | Cambio | Acción |
|---|---|---|
| R6 — Hardware difícil de conseguir en Argentina | **Mitigado**: Aurora Home funciona sobre Raspberry Pi real con diagnósticos | Se mantiene. |
| R10 — Sin conectividad | **Mitigado en parte**: recordatorios sin conexión y cola de salida local | Falta probar la reconexión en escenarios reales. |
| R8 — Falso negativo | **Aparece**: AURA-110 muestra «todo en orden» cuando falla la carga | Corregir antes de la demostración. |
| R5 — Seguridad de datos | Cifrado de PII (AURA-97) y consentimiento (AURA-98) en revisión al cierre | Cerrar en el Sprint 5 (ADR-010). |
| R7 — Sobrecarga | Mateo concentra 11 de 16 cierres | Compartir conocimiento de Home con otro integrante. |
| Nuevo — Dependencia de una persona | Aurora Home depende de Mateo | Documentar el runtime y hacer una sesión de traspaso. |

## 9. Artefactos producidos

- Trazabilidad: AURA-90, 91 y 95 (carpetas `Sprint 3/AURA-xx/`).
- Documentación de Aurora Home en `AuroraHome/Docs/` (plan de implementación y evidencia del E2E con Core).
- Contrato OpenAPI de Home normalizado y *contract tests* (AURA-102).
- Plantilla de PR y skill `pr-flow` (`.kiro/skills/pr-flow` en el vault).
