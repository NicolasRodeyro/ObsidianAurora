---
sprint: 3
jira_sprint: "SCRUM Sprint 4 (id 69)"
fecha_inicio: "2026-08-04"
fecha_fin_planificada: "2026-08-25"
fecha_cierre: "2026-08-28"
tipo: informe-sprint
---

# Informe de Sprint 3

> [!info] Numeración
> El Sprint 3 corresponde a la iteración **«SCRUM Sprint 4»** de Jira (id 69). Ver la tabla de equivalencias en [[Desarrollo del Proyecto — Sprints 0, 1 y 2]].

| Campo | Valor |
|---|---|
| Sprint Jira | SCRUM Sprint 4 (id 69) |
| Inicio | 04/08/2026 |
| Fin planificado | 25/08/2026 |
| Cierre en Jira | 28/08/2026 (+3 días) |
| Product Owner / Scrum Master | Haik Kilic Aslan / Jeremías Maldonado Gómez |

## 1. Objetivo del sprint

Tener un backend operativo, con autenticación y APIs de pacientes, rutinas, medicación y cumplimiento, y la base de Aurora Home con contratos y persistencia local resiliente.

> [!note] El objetivo se redactó a posteriori
> Jira no tenía objetivo cargado para este sprint. Este texto se escribió el 17/10/2026 a partir de lo que el sprint entregó, y se cargó en Jira en esa fecha.

**¿Se cumplió?** En lo esencial, sí. El backend (AuroraCore) quedó operativo en desarrollo con autenticación Auth0/JWT y las APIs de paciente, rutinas, medicación, cumplimiento, acuse de alertas y perfil del cuidador. La base de Aurora Home (AURA-90, 91 y 95) se terminó recién en el Sprint 4.

## 2. Equipo y capacidad

Equipo y roles como en el [[Informe Sprint 1]]. Capacidad declarada: 84 h por semana, 252 h por sprint de 3 semanas (≈ 202 h con el 20 % de margen). Los tickets no se estimaron en horas, así que se compara la distribución de tickets con la de la capacidad.

| Persona | Capacidad semanal | % de la capacidad | Tickets en el sprint | % de los tickets | Finalizados en el sprint |
|---|---|---|---|---|---|
| Octavio | 15 h | 18 % | 14 | 42 % | 7 |
| Mateo | 16 h | 19 % | 7 | 21 % | 3 |
| Haik | 18 h | 21 % | 7 | 21 % | 3 |
| Jeremías | 13 h | 15 % | 4 | 12 % | 0 |
| Nicolás | 22 h | 26 % | 1 | 3 % | 0 |

El campo *assignee* de Jira no es del todo confiable, pero la diferencia es grande: **Octavio concentró el 42 % de los tickets con el 18 % de la capacidad del equipo**, mientras que Nicolás, con el 26 %, figura en un solo ticket.

## 3. Sprint Backlog

El sprint tuvo **33 tickets**: **19 al inicio** (el 04/08) y **13 agregados durante el sprint** (AURA-92 a AURA-103 y la subtarea AURA-136), es decir el 39 % del total. La columna «Entró» se calcula a partir de la fecha de creación de cada ticket. El 23/08 se creó un lote de 9 tickets (AURA-95 a AURA-103), dos días antes del cierre planificado.

Se finalizaron **13** tickets dentro del sprint y **20** pasaron al Sprint 4.

| Key | Tipo | Resumen | Responsable (Jira) | Entró | Resultado | Estado actual |
|---|---|---|---|---|---|---|
| AURA-30 | Tarea | Skills/rules para diseño - Parte 1 | Haik | Heredado | Finalizado en el sprint | Finalizada |
| AURA-63 | Tarea | Implementar Conexión entre Care y la BD | Haik | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-64 | Análisis | Investigación Pulsera para Aurora Band | Haik | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-74 | Historia | US-D1 — Sesión guiada de terapia | Jeremías | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-75 | Historia | US-D2 — Biblioteca de actividades terapéuticas | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-76 | Historia | US-D3 — Descubrimientos con validación | Jeremías | Al inicio | Pasó al Sprint 4 | En curso |
| AURA-77 | Historia | US-D4 — Dificultad adaptativa | nicolasrodeyro | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-78 | Historia | Registro y perfil del paciente | Jeremías | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-79 | Historia | Gestión de rutinas y recordatorios (interfaz del cuidador) | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-80 | Historia | Gestión de medicación y recetario (interfaz del cuidador) | Mateo | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-82 | Historia | Integración Auth0: autenticación JWT en AuroraCore | Haik | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-83 | Historia | Setup inicial del proyecto AuroraCore (estructura, BD, entorno) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-84 | Historia | API REST: CRUD de Paciente (perfil, biografía, preferencias) | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-85 | Historia | API REST: Dashboard del Cuidador (estado actual del paciente) | Octavio | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-86 | Historia | API REST: CRUD de Zonas Seguras (geofencing por paciente) | Octavio | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-87 | Historia | API REST: CRUD de Rutinas del Paciente | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-88 | Historia | API REST: CRUD de Medicación y Recetario del Paciente | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-89 | Historia | API REST: Registro de Cumplimiento de Rutinas y Toma de Medicación | Octavio | Al inicio | Finalizado en el sprint | Finalizada |
| AURA-90 | Tarea | AH-M01 - Crear base inicial del repositorio Aurora Home | Mateo | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-91 | Tarea | AH-M02 - Definir contratos v1 y simulador local Home-Core | Mateo | Al inicio | Pasó al Sprint 4 | Finalizada |
| AURA-92 | Tarea | Deploy de AuroraCareBack en Render (entorno dev) | Jeremías | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-93 | Tarea | ADR formal de cifrado de PII (Ley 25.326) | Octavio | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-94 | Tarea | Endpoint GET/api/v1/auth/me (perfil del cuidador autenticado) | Octavio | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-95 | Tarea | AH-M03 — Fundación local resiliente (SQLite, outbox y resiliencia) | Mateo | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-96 | Historia | API REST: Acuse de recibo de alertas por el cuidador (acknowledge) | Octavio | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-97 | Subtarea | Mecanismo y ADR formal de cifrado de PII (DNI y nombre) conforme a la Ley 25.326 | Octavio | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-98 | Subtarea | API operativa de consentimiento informado para registrar y consultar consent_records desde el onboarding | Octavio | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-99 | Subtarea | Asistencia de backend a AURA-74 | Haik | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-100 | Tarea | Revisar cambios backend de facture/notifications-aurora vs main | Haik | Durante el sprint | Finalizado en el sprint | Finalizada |
| AURA-101 | Subtarea | Implementación del backend (subtarea) | Octavio | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-102 | Tarea | CORE-012 · Normalizar contrato OpenAPI y contract tests de Aurora Home | Haik | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-103 | Tarea | HOME-0409 · Ejecutar E2E real de configuración y eventos Aurora Home ↔ Core | Mateo | Durante el sprint | Pasó al Sprint 4 | Finalizada |
| AURA-136 | Subtarea | Backend (subtarea) | Octavio | Durante el sprint | Pasó al Sprint 4 | Finalizada |

**Por qué pasaron 20 tickets al Sprint 4** (agrupados):

- **Historias de terapia y registro del paciente (AURA-74, 76, 77, 78):** dependían de funcionalidades de IA, terapias y consentimiento que se construyeron en sprints posteriores. En AURA-78 el equipo dejó registrada la dependencia del consentimiento en la documentación del repositorio de Care.
- **Aurora Home M01 a M03 (AURA-90, 91, 95):** se terminaron en el Sprint 4.
- **Dashboard y zonas seguras (AURA-85, 86):** las APIs se completaron en el Sprint 4.
- **Cifrado de PII, consentimiento y su asistencia (AURA-93, 97, 98, 99, 101):** quedaron en revisión al cierre.
- **Heredados del Sprint 1 (AURA-63, 64):** la conexión de Care con la base de datos esperaba al backend, y la investigación de la pulsera estaba pausada.
- **Deploy en Render (AURA-92) y subtarea de backend (AURA-136).**
- **Pruebas de integración y contrato de Home (AURA-102, 103):** se cerraron en el Sprint 4.

## 4. Sprint Review

**Qué se pudo demostrar** (evidencia en los repositorios y en Jira):

- API REST de AuroraCore en desarrollo con autenticación Auth0/JWT (commits del 04 y 08/08) y endpoints de paciente, rutinas, medicación, cumplimiento, acuse de recibo de alertas y perfil del cuidador (AURA-82, 83, 84, 87, 88, 89, 94, 96).
- Contrato OpenAPI publicado, con Swagger y autorización Bearer.
- Auditoría y endurecimiento del backend el 22/08: aislamiento de datos por hogar con `Exists()`, cierre de la escritura entre hogares en 5 endpoints y eliminación de consultas N+1.
- Gestión de rutinas y de medicación en la interfaz del cuidador (AURA-79 y AURA-80).

> [!todo] Feedback recibido
> Falta registrar quiénes asistieron a la Sprint Review y qué feedback dieron la docente y el equipo. Se completa con el formulario del equipo.

## 5. Métricas y tendencia

| Métrica | Meta | Sprint 3 | Lectura |
|---|---|---|---|
| Cumplimiento del sprint | ≥ 80 % | **47 %** (9 de 19 comprometidos al inicio); contando lo agregado, 39 % (13 de 33) | No se cumple. Se comprometieron más tickets de los que se podían terminar y se sumó trabajo nuevo. |
| Desvío de cierre | ≤ 2 días | **+3 días** (25/08 → 28/08) | Casi en la meta. Es una mejora enorme frente a los +25 días del Sprint 1. |
| Carga por integrante | nadie sobre su capacidad | **No medible en horas** | Octavio tiene el 42 % de los tickets con el 18 % de la capacidad. Es una señal de sobrecarga. |
| Trabajo arrastrado | causa registrada | **20 tickets (61 %)** | Causas en el punto 3. |
| Incidencias abiertas P1/P2 | ningún P1 | **Sin registro** | Todavía no se cargaban los errores como tickets. La auditoría del 22/08 halló y corrigió 6 defectos latentes, entre ellos la escritura entre hogares. Quedó sin P1 abierto, pero sin registro formal. |
| Calidad del código | ≥ 80 % de cobertura | **Cobertura no medida** | `pytest-cov` estaba instalado y no se usaba. Los archivos de test de AuroraCore pasaron de 4 (en `main`, según la retro) a 38 el 24/08. |
| Mejora del proceso | — | No aplica | El Sprint 2 no registró acciones. |

**Tendencia:** el cumplimiento cayó de **88 % en el Sprint 1** a **47 %** y el trabajo arrastrado subió de 3 tickets (12 %) a 20 (61 %). El Sprint 2 no tuvo medición. Esta caída refleja un cambio de naturaleza: pasaron de documentos y diseño a código con dependencias entre componentes, con un backlog que creció a mitad del sprint. La lectura para el equipo es que **un sprint se compromete con lo que se puede terminar, y el trabajo nuevo entra solo si sale otro**.

El desvío, en cambio, mejoró de +25 a +3 días: el equipo empezó a cerrar los sprints a tiempo.

## 6. Retrospectiva

Los aportes provienen de la planilla de retrospectivas del equipo. Los que figuran con otro número de sprint en la planilla se ubicaron acá según la fecha de los commits que los originaron (auditoría del backend del 22/08, integración de Auth0 del 04 al 08/08).

**Lo que funcionó bien**

- Auth real con JWKS cacheado y rotación de claves (Haik y Octavio).
- Contrato OpenAPI publicado (Octavio).
- API REST CRUD de Paciente (Octavio).
- Mateo escribió tests junto a sus features cuando `main` casi no tenía (Mateo).
- Flujo de PRs con rama `staging` (todos).

**Lo que aprendimos (Haik, salvo indicación)**

- El queryset scopeado protege las lecturas, pero **no** las escrituras.
- Una abstracción que existe pero se copia a mano no protege.
- `.distinct()` sobre un join de 3 tablas es un parche: `Exists()` correlacionado da el mismo resultado sin duplicar filas.
- `get_or_create` en un loop hace 2 consultas por fila: un lote de 30 lecturas pasó de **122 a 6 consultas** con `bulk_create`.
- Una clave de deduplicación incompleta pierde datos en silencio.
- `auto_now` no corre si el campo no está en `update_fields`.
- Probar en SQLite y desplegar en Postgres deja huecos (`bulk_create(ignore_conflicts)` y migraciones).
- La configuración OAuth de Swagger se resolvió por prueba y error (Octavio).

**Lo que faltó**

- CI/CD: `AGENTS.md` declara «GitHub Actions» y un DoD con `ruff check` y `pytest`, pero no existía ningún workflow.
- Tests desde el arranque: `main` tenía 4 archivos de test para 13 apps, y los 6 defectos latentes eran detectables con un test de creación.
- Revisión cruzada real: los PRs se mergeaban rápido y por el mismo autor, y ningún defecto sobreviviente se detectó en review.
- Convención de ramas `feature/AURA-[num]`: se cumplió 1 de 9 veces, y una quedó con un error de tipeo (`facture/`).
- Dependencia de Auth0 (Octavio) e integración de `facture/notifications-aurora` (Haik y Mateo).

**Lo que hubiéramos querido tener**

- Un entorno de staging desplegado para probar el callback de Auth0 sin 5 commits de prueba y error (todos).
- Una plantilla de PR con el checklist del DoD que ya estaba escrito en `AGENTS.md` (Jere).
- Cobertura mínima exigida: `pytest-cov` estaba en `requirements/local.txt` y nunca se usó (Jere).
- Un seed representativo para ver performance: los N+1 solo aparecen con volumen y `seed_local` crea pocas filas (todos).

**Análisis del Scrum Master**

- Casi todo lo que el equipo «hubiera querido tener» es **proceso y automatización**, no funcionalidad: un buen insumo para acciones concretas.
- El 39 % del sprint se agregó después de empezar, y un lote de 9 tickets se creó dos días antes del cierre. Conviene crear el ticket antes de empezar el trabajo, no al terminarlo.
- La carga está concentrada: una persona con 42 % de los tickets y dos con menos del 5 % entre ambas.

**Action items** (acordados en la retrospectiva combinada de los Sprints 0 a 3)

| # | Acción | Responsable | Fecha límite | Estado |
|---|---|---|---|---|
| 1 | DoD como normativa para cada IA o skill | A confirmar por el equipo | Fin del Sprint 4 (16/09/2026) | Se evalúa en el [[Informe Sprint 4]] |
| 2 | GitHub Actions para CI/CD | A confirmar por el equipo | Fin del Sprint 4 (16/09/2026) | Se evalúa en el [[Informe Sprint 4]] |
| 3 | PRs obligatoriamente vinculadas al ticket y con convención de nombres | A confirmar por el equipo | Fin del Sprint 4 (16/09/2026) | Se evalúa en el [[Informe Sprint 4]] |
| 4 | Restringir la creación de PRs que no cumplan la convención | A confirmar por el equipo | Fin del Sprint 4 (16/09/2026) | Se evalúa en el [[Informe Sprint 4]] |
| 5 | Cron para Supabase | A confirmar por el equipo | Fin del Sprint 4 (16/09/2026) | Se evalúa en el [[Informe Sprint 4]] |
| 6 | Llenar la base de datos de prueba (seed representativo) | A confirmar por el equipo | Fin del Sprint 4 (16/09/2026) | Se evalúa en el [[Informe Sprint 4]] |

> [!todo] Responsables
> La retrospectiva registró las acciones pero no quién las toma. Se completan con el formulario del equipo. Las fechas son las del plazo del sprint siguiente.

**Estado de las acciones del sprint anterior:** el Sprint 2 no registró acciones.

## 7. Product Backlog repriorizado

Con el backend operativo, la prioridad pasó a **conectar los componentes**. El 28/08, día del cierre, se cargaron los tickets del Sprint 4: memoria contextual del paciente y consulta con IA (AURA-104 y 105), alertas push (AURA-106), vista de alertas en tiempo real (AURA-107) y conexión de las pantallas de Care con los endpoints reales (AURA-108), además de la pantalla de privacidad (AURA-109). En paralelo, Aurora Home pasa a voz local, conversación y recordatorios.

## 8. Registro de riesgos (cambios en este sprint)

Registro completo y vigente de todos los riesgos: [[Registro de Riesgos]].

| Riesgo | Cambio | Acción |
|---|---|---|
| R5 — Filtración de datos sensibles | **Se materializó un defecto interno**: escritura entre hogares en 5 endpoints, hallada y corregida el 22/08 | Aislamiento por hogar unificado; falta cifrar PII (ADR-010, AURA-93/97). |
| R7 — Sobrecarga | Octavio concentra el 42 % de los tickets | Redistribuir la carga en la próxima planificación. |
| R14 — Dependencia de proveedores | Se integra Auth0 y se necesita un staging para probar su callback | Evaluar alternativas (más adelante se migra a Supabase Auth). |
| Nuevo — Calidad sin red de seguridad | Sin CI/CD, con 4 archivos de test para 13 apps y revisión cruzada débil | Acciones 1 a 4 de la retrospectiva. |

## 9. Artefactos producidos

- Trazabilidad: AURA-82, 87, 88, 89, 90, 91, 95 y 96 (carpetas `Sprint 3/AURA-xx/`).
- Material de trabajo de las historias AURA-74 a AURA-80 (carpetas `Sprint 3/AURA-xx/`).
- Contrato OpenAPI de AuroraCore (Swagger).
- Documentación técnica del backend en `AuroraCore/docs/`.
