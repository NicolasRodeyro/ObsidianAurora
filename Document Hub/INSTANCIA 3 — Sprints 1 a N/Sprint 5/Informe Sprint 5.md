---
sprint: 5
jira_sprint: "SCRUM Sprint 6 (id 71)"
fecha_inicio: "2026-09-16"
fecha_fin_planificada: "2026-10-07"
fecha_cierre: "2026-10-14"
tipo: informe-sprint
---

# Informe de Sprint 5

> [!info] Numeración
> El Sprint 5 corresponde a la iteración **«SCRUM Sprint 6»** de Jira (id 71). Jira muestra 63 tickets en este sprint, pero 16 son tickets de los Sprints 0 a 2 que quedaron reasignados al cerrar el «Sprint 3» vacío (por ejemplo AURA-65 a 73). Este informe cuenta solo los **47 tickets propios** del sprint. Ver [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 6 (id 71) |
| Inicio | 16/09/2026 |
| Fin planificado | 07/10/2026 |
| Cierre en Jira | 14/10/2026 (+7 días) |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez |

## 1. Objetivo del sprint

Llevar el MVP a staging de punta a punta: Home conectado a Core (heartbeat, comandos, Drop-in), sesiones y terapias diarias, recuerdos con fotos y consentimiento informado en el alta.

> [!note] El objetivo se redactó a posteriori
> Jira no tenía objetivo cargado para este sprint. Este texto se escribió el 17/10/2026 a partir de lo que el sprint entregó, y se cargó en Jira en esa fecha.

**¿Se cumplió?** **En su mayor parte.** Se entregó el heartbeat real de Home hacia Core (AURA-129 y 165), el canal de comandos con rotación de credenciales (AURA-130, 131 y 166), las sesiones cognitivas diarias (AURA-149, 157 y 172), los recuerdos con fotos (AURA-162, 163 y 183), el consentimiento obligatorio en el alta (AURA-160, 169 y 170), el catálogo de terapias de la psicopedagoga (AURA-184) y el VPS de Hostinger con el despliegue de staging (AURA-140 y 185). **El Drop-in en vivo (AURA-134) quedó en revisión** y el error AURA-173 todavía impide usarlo por defecto.

## 2. Equipo y capacidad

Equipo y roles como en el [[Informe Sprint 1]]. Capacidad declarada: 84 h por semana (≈ 252 h por sprint de 3 semanas). Los tickets siguen sin estimarse en horas.

| Persona | Capacidad semanal | % de la capacidad | Tickets en el sprint | % de los tickets | Finalizados en el sprint |
|---|---|---|---|---|---|
| Octavio | 15 h | 18 % | 15 | 32 % | 12 |
| Mateo | 16 h | 19 % | 12 | 26 % | 12 |
| Haik | 18 h | 21 % | 9 | 19 % | 5 |
| Jeremías | 13 h | 15 % | 9 | 19 % | 3 |
| Nicolás | 22 h | 26 % | 1 | 2 % | 1 |

## 3. Sprint Backlog

El sprint tuvo **47 tickets propios**: **28 al inicio** (la mayoría arrastrados del Sprint 4) y **19 agregados durante el sprint**, en su mayoría errores y tareas surgidas de las pruebas con Home y Care. Se finalizaron **34** dentro del sprint y **13** pasaron al Sprint 6.

| Key | Tipo | Resumen | Responsable (Jira) | Entró | Resultado | Estado al 17/10 |
|---|---|---|---|---|---|---|
| AURA-64 | Análisis | Investigación Pulsera para Aurora Band | Haik | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-74 | Historia | US-D1 — Sesión guiada de terapia | Jeremías | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-76 | Historia | US-D3 — Descubrimientos con validación | Jeremías | Al inicio | Pasó al Sprint 6 | En curso |
| AURA-77 | Historia | US-D4 — Dificultad adaptativa | nicolasrodeyro | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-78 | Historia | Registro y perfil del paciente | Jeremías | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-92 | Tarea | Deploy de AuroraCareBack en Render (entorno dev) | Jeremías | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-97 | Subtarea | Mecanismo y ADR formal de cifrado de PII (DNI y nombre) conforme a la Ley 25.326 | Octavio | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-98 | Subtarea | API operativa de consentimiento informado para registrar y consultar consent_records desde el onboarding | Octavio | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-99 | Subtarea | Asistencia de backend a AURA-74 | Haik | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-101 | Subtarea | Implementación del backend (subtarea) | Octavio | Al inicio | Pasó al Sprint 6 | Finalizada |
| AURA-104 | Tarea | CORE-MEM01 — Schema de memoria contextual del paciente en AuroraCore | Jeremías | Al inicio | Pasó al Sprint 6 | In Revision |
| AURA-105 | Historia | CORE-MEM02 — Endpoint RAG: consulta de contexto del paciente con LLM | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-106 | Historia | API REST: Envío proactivo de alertas push al cuidador | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-107 | Historia | Vista de alertas en tiempo real — panel del cuidador (AuroraCare) | Haik | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-108 | Historia | Conectar pantallas de AuroraCare con endpoints reales de AuroraCore | Jeremías | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-109 | Historia | Pantalla de Privacidad y datos (Aurora Care) | Jeremías | Al inicio | Pasó al Sprint 6 | In Revision |
| AURA-112 | Error | El campo de fecha de nacimiento no funciona en web y no permite tipear | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-113 | Error | El selector de etapa de enfermedad es ilegible en modo oscuro | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-115 | Error | El CRUD de rutinas apunta a una ruta inexistente | - | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-129 | Tarea | CORE-004 · Heartbeat autenticado y telemetría mínima para Aurora Home | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-130 | Tarea | CORE-011 · Revocación, reemplazo y rotación segura (Aurora Home) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-131 | Tarea | CORE-007 · Comandos autenticados, ack durable y WSS para Aurora Home | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-134 | Tarea | CORE-010 · Drop In en vivo (LiveKit) autorizado para Aurora Home | Jeremías | Al inicio | Pasó al Sprint 6 | In Revision |
| AURA-136 | Subtarea | Backend (subtarea) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-137 | Tarea | CORE-009 · Planes de terapia y assets versionados para Aurora Home | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-140 | Tarea | Provisioning y hardening del VPS Hostinger | Jeremías | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-149 | Historia | Generación de interacciones y sesiones diarias | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-157 | Historia | CORE-009 · Propuesta de contrato ActivityPlan para Home | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-158 | Error | Home anuncia dosis vencidas tras un arranque con el reloj sin sincronizar | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-159 | Error | Un fallo de captura ALSA a mitad de la escucha dejaba el recordatorio colgado | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-160 | Tarea | [Backend] Registrar ConsentRecord atómicamente en POST /households/setup/ | Haik | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-161 | Tarea | Optimización de la carga inicial del paciente (front) | Haik | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-162 | Tarea | El alta del hogar tiene que aceptar varios recuerdos iniciales | Octavio | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-163 | Tarea | Fotos en los recuerdos | Octavio | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-164 | Error | Compliance sin filtro de fecha: Care infiere «hoy» por paginación y oculta estados reales | Haik | Durante el sprint | Pasó al Sprint 6 | En curso |
| AURA-165 | Tarea | HOME · Publicar heartbeat real hacia Core (CORE-004) | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-166 | Tarea | HOME · Canal de comandos de Core: WS control, safe mode, rotación de credenciales y ack | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-169 | Tarea | [Frontend] Enviar el consentimiento en el alta del hogar y confirmar con consent_record | Haik | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-170 | Tarea | [Backend] Hacer obligatorio el consentimiento en POST /households/setup/ | Haik | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-171 | Tarea | HOME · Integrar patient-query de Core (memoria del paciente) como responder de conversación | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-172 | Tarea | HOME · Ejecutar sesiones cognitivas diarias de Core y reportar activity.started/completed | Octavio | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-173 | Error | El cuidador principal se auto-provisiona sin can_drop_in, bloqueando Drop-in por defecto | Haik | Durante el sprint | Pasó al Sprint 6 | Tareas por hacer |
| AURA-174 | Error | Falta UI en el frontend para autorizar un Aurora Home para Drop-in | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-182 | Historia | Pairing en producción: pantalla de WiFi para vincular Aurora Home (AURA-134) | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-183 | Error | Conectar la carga de fotos en recuerdos (AuroraCare y Aurora Core) | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-184 | Tarea | Terapias cognitivas: catálogo de la psicopedagoga | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-185 | Tarea | Deploy de staging del frontend | Mateo | Durante el sprint | Finalizado en el sprint | Finalizada |

**Trabajo finalizado sin sprint en el período:** AURA-141, 142, 144, 145 y 146 (proxy inverso con TLS y DNS, dockerización de AuroraCore, stack de staging, n8n y pipeline de despliegue con GitHub Actions) y AURA-177, 178, 179 y 181 (etiquetas en inglés, duración negativa en el dashboard, onboarding sin trabas y desbloqueo de la promoción de `staging` a `main`). Son 9 tickets finalizados que no cuentan en las métricas porque no tienen sprint.

**Por qué pasaron 13 tickets al Sprint 6:**

- **Funcionalidades en revisión:** Drop-in en vivo (AURA-134), memoria contextual del paciente (AURA-104) y pantalla de privacidad (AURA-109).
- **Descubrimientos con validación (AURA-76):** requiere una demostración de punta a punta.
- **Errores abiertos:** AURA-164 (compliance sin filtro de fecha) y AURA-173 (Drop-in bloqueado por defecto).
- **Tickets viejos de depuración:** AURA-64, 74, 78, 97 y 98 ya estaban resueltos en la práctica y se cerraron el 17/10/2026 al revisar el tablero (ver [[Informe Sprint 6]]); AURA-99 y 101 son subtareas que ya estaban finalizadas.

## 4. Sprint Review

**Qué se pudo demostrar** (evidencia en los repositorios y en Jira):

- Aurora Home conectado a Aurora Core en staging: heartbeat, canal de comandos con rotación de credenciales y vinculación en producción por WiFi (AURA-165, 166 y 182).
- Sesiones cognitivas diarias generadas por Core y ejecutadas por Home, con reporte de inicio y fin (AURA-149 y 172), y planes de terapia versionados (AURA-137).
- Recuerdos con fotos, con almacenamiento privado (AURA-163 y 183).
- Consentimiento informado obligatorio en el alta del hogar (AURA-160, 169 y 170).
- Infraestructura de staging en el VPS de Hostinger con despliegue automático (AURA-140, 141 a 146 y 185).
- Jornada de presentación del 06/10: paper, póster y video (ver [[Jornada de Presentación]]).

> [!todo] Feedback recibido
> Falta registrar quiénes asistieron a la Sprint Review y qué feedback dieron la docente y el equipo. Se completa con el formulario del equipo.

## 5. Métricas y tendencia

| Métrica | Meta | Sprint 5 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **61 %** (17 de 28 comprometidos al inicio; 34 de 47 contando lo agregado) | No se cumple, pero es el mejor valor desde el Sprint 1. |
| Desvío de cierre | ≤ 2 días | **+7 días** (07/10 → 14/10) | No se cumple. |
| Carga por integrante | nadie sobre su capacidad | **No medible en horas** | Octavio tiene el 32 % de los tickets con el 18 % de la capacidad, y Nicolás el 2 % con el 26 %. |
| Trabajo arrastrado | causa registrada | **13 tickets (28 %)** | Causas en el punto 3. |
| Incidencias abiertas P1/P2 | ningún P1 | **9 errores en el sprint, 2 abiertos al cierre** | Se corrigieron 7. Siguen abiertos AURA-164 y AURA-173, además de AURA-110, 111 y 175 de otros sprints. No se clasifican por criticidad; AURA-173 impide usar Drop-in por defecto y debería clasificarse. |
| Calidad del código | ≥ 80 % de cobertura | **Cobertura no medida**; CI activo | Archivos de test: AuroraCore de 57 a 114, AuroraHome de 91 a 148, AuroraCare de 35 a 149, y Aurora Worker IA con 4 (repositorio nuevo). |
| Mejora del proceso | — | **No aplica** | La retrospectiva del Sprint 4 está pendiente; no hay acciones nuevas que evaluar. |

**Tendencia** (de los sprints con medición):

| Métrica | Sprint 1 | Sprint 3 | Sprint 4 | Sprint 5 |
|---|---|---|---|---|
| Cumplimiento | 88 % | 47 % | 47 % | **61 %** |
| Trabajo arrastrado | 12 % | 61 % | 57 % | **28 %** |
| Desvío de cierre | +25 días | +3 días | +1 día | **+7 días** |

**Lectura:** mejoró lo que pedía la retro (menos arrastre y más cumplimiento), pero **el desvío volvió a empeorar**. Los datos de los repositorios sugieren por qué: el **40 % de los commits del sprint** (174 de 440) se hicieron en los últimos 6 días del plazo planificado (01 al 06/10), que son el 27 % del tiempo del sprint. El 06/10 fue la jornada de presentación y el 12/10 llegaron las correcciones de la profesora, por lo que ambos hitos coinciden con la extensión del sprint. Conviene ordenar el trabajo para no concentrarlo en el cierre.

## 6. Retrospectiva

> [!todo] Retrospectiva de este sprint
> La planilla de retrospectivas del equipo no incluye este sprint. Falta registrar qué funcionó, qué se aprendió y qué faltó. Se completa con el formulario del equipo.

**Análisis del Scrum Master**

- El equipo cierra con apuro: 40 % de los commits en el último cuarto del plazo, y el sprint se extendió una semana.
- La concentración en Octavio y Mateo continúa (57 % de los tickets entre los dos).
- Se resolvió una deuda de proceso: los errores ahora se cargan como tickets (9 en este sprint).
- Siguen sin implementarse las acciones 4 (restringir PRs fuera de convención) y 5 (cron para Supabase) de la retro del Sprint 3.

**Action items:** pendientes de la retrospectiva del Sprint 5.

**Estado de las acciones del sprint anterior:** la retrospectiva del Sprint 4 no se realizó o no se registró, por lo que no hay acciones que evaluar. Las acciones del Sprint 3 se evaluaron en el [[Informe Sprint 4]].

## 7. Product Backlog repriorizado

Al cierre, el foco pasa a **cerrar el MVP**: terminar el Drop-in en vivo y sus errores, demostrar la validación de recuerdos (AURA-76), la pantalla de privacidad, la memoria contextual y las métricas del panel del cuidador (AURA-167 y 168, en revisión). La documentación y la presentación del 05/11 se incorporan como trabajo del sprint (AURA-186). Ver la propuesta de qué más entra en el [[Informe Sprint 6]].

## 8. Registro de riesgos (cambios en este sprint)

Registro completo y vigente de todos los riesgos: [[Registro de Riesgos]].

| Riesgo | Cambio | Acción |
|---|---|---|
| R5 — Seguridad de datos | Se cerraron cifrado de PII (ADR-010) y consentimiento obligatorio; falta AURA-147 (gestión de secretos) | Priorizar AURA-147 en el Sprint 6. |
| R8 — Falso negativo | Siguen abiertos AURA-110 («todo en orden» cuando falla la carga), 111 y 164 (compliance oculta estados reales) | Corregirlos antes de la demostración. |
| R14 — Dependencia de proveedores | **Mitigado en parte**: la autenticación pasó de Auth0 a Supabase Auth (18/09) | Se mantiene la dependencia de Supabase y Azure. |
| R13 — Presupuesto | Se contrató el VPS de Hostinger para staging | Actualizar el flujo de fondos con el mes de noviembre. |
| R7 — Sobrecarga | Cierre concentrado: 40 % de los commits en 6 días | Repartir el trabajo del Sprint 6 desde el inicio. |
| Nuevo — Operación sin respaldo | AURA-148 (backups, monitoreo y runbook) sigue por hacer | Definir al menos un respaldo diario de la base de datos. |

## 9. Artefactos producidos

- Jornada de presentación: paper, póster, video y landing ([[Jornada de Presentación]]).
- Documentación técnica de AuroraCore (`docs/`), de AuroraHome (`Docs/`) y del Worker IA.
- Plan de Testing con línea base de ejecución: AuroraCore 1.579 pruebas, AuroraHome 1.902, AuroraCare 1.190 y Aurora Worker IA 196 ([[Plan de Testing]], sección 4.7).
- Catálogo de terapias cognitivas de la psicopedagoga (AURA-184).
- Trazabilidad: [[Artefacto de Trazabilidad AURA-98]] (consentimiento), [[Artefacto de Trazabilidad AURA-105]] (memoria y consulta con IA), [[Artefacto de Trazabilidad AURA-106]] (alertas push), [[Artefacto de Trazabilidad AURA-131]] (heartbeat y comandos), [[Artefacto de Trazabilidad AURA-134]] (Drop-in, en revisión), [[Artefacto de Trazabilidad AURA-149]] (sesiones diarias) y [[Artefacto de Trazabilidad AURA-163]] (recuerdos con fotos).
