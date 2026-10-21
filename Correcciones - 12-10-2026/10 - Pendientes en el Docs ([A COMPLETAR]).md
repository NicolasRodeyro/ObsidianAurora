# Pendientes en el Docs: lugares marcados con `[A COMPLETAR]`

Estado al 15/10/2026 (revisado contra el Doc tras completar el equipo el Estudio Inicial y el Plan de Proyecto). En el Google Doc (pestaña 1) se usa el texto exacto `[A COMPLETAR]` donde falta un dato que no figura en los repos ni en lo que se informó. Para encontrarlos: **Ctrl+F → `A COMPLETAR`**. **Hoy no queda ninguno.**

Cuando se complete un dato, hay que actualizar también el mismo texto en el repo (`Document Hub/`) al aplicar las correcciones.

## 1. Pendientes que quedan en el Doc (0)

| # | Dónde | Qué falta | Quién |
| --- | --- | --- | --- |

## 2. Resueltos (completados por el equipo el 15/10/2026)

- **Plan de Testing 4.7, línea base (16/10/2026):** se corrieron las suites de los cuatro repositorios: **Aurora Core 1.579 pasando** (con PostgreSQL real vía `docker compose`; 9 pruebas `e2e_live` quedan fuera por defecto), **Aurora Home 1.902 pasando (20 omitidas)**, **Aurora Care 1.190 pasando (148 suites)** y **Aurora Worker IA 196 pasando**. Notas: en Core hay que correr con `DJANGO_SETTINGS_MODULE=config.settings.test` (el `docker-compose.yml` fuerza `config.settings.local` y con eso fallan 3 pruebas de push, que esperan el envío en línea; el repo debería corregirlo); y en Windows el Worker IA necesita la base de zonas horarias (`tzdata`) para un archivo de pruebas.

- **Arquitectura 6.6, lista de control de RNF-51 (16/10/2026):** verificado en el portal de Azure (recurso `Aurora2026`, Servicio de Voz) que no hay configuraciones de diagnóstico definidas, por lo que no se exportan Request and Response Logs ni Audit Logs; el código de Aurora Home no solicita diarización. La viñeta quedó como «cumple». Sigue abierto, aparte, el nivel gratuito (F0) «no apto para pacientes reales»: se puede confirmar en *Plan de tarifa* del mismo recurso.
- **Arquitectura 5.5, respaldo, y Plan de Testing 4.5, recuperación (16/10/2026):** se escribió el estado real (no hay respaldos definidos; el plan gratuito de Supabase no los incluye) y una propuesta: `pg_dump` diario en el VPS, cifrado y guardado fuera del servidor, retención de 30 días y prueba de restauración; para producción, plan pago de Supabase con respaldos diarios. Objetivo de recuperación: pérdida máxima de 24 h y restauración en 4 h. **Falta que DevOps implemente el respaldo diario**; mientras tanto el texto describe una propuesta.
- **Arquitectura 5.4, monitoreo y logging (16/10/2026):** el equipo aclaró que no hay monitoreo ni logging en uso. El Doc ahora lo dice así: solo hay chequeos de salud básicos (`/health/` en Aurora Core y healthcheck de Docker en el Worker IA) y Sentry y Prometheus pasaron a «previstos» (`sentry-sdk` está en las dependencias de producción pero no está configurado).
- **Estudio Inicial, validación profesional:** fechas y nombres de los profesionales cargados.
- **Plan de Proyecto 3.1:** usuarios del piloto definidos (10 cuidadores).
- **Plan de Proyecto 6.1 (CAPEX):** infraestructura real ($72.017), pendiente ($42.892), estado y plan de contención.
- **Plan de Proyecto 6.2 (OPEX):** costo de IA, de voz y total ($30 USD/mes).
- **Plan de Proyecto, cronograma:** el cronograma es el plan inicial, se eliminó la columna «Estado al 12/10/2026». El estado real queda para los informes de sprint (Instancia 3). Correspondencia con Jira para cuando se haga: Sprint 1 → Jira 2 (cerró 02/08), Sprints 2 y 3 → Jira 4 (cerró 28/08), Sprint 4 → Jira 5 (cerró 17/09), Sprint 5 → Jira 6 (cerró 14/10, con 9 tickets arrastrados), Sprint 6 → Jira 7 (14/10 al 05/11).
- **Figuras AS-IS y TO-BE:** insertadas en «Procesos involucrados».

## 3. Otros marcadores que no son `[A COMPLETAR]` (no se tocan)

- `[A validar con la Lic. Salvador]` en las reglas S1 y S5 de la matriz del dominio clínico, y `[A validar]` en S2.
- `[pendiente]` en la fila «No diagnosticar ni recomendar tratamientos» de la tabla de límites: falta armar el conjunto de casos adversarios de IA (ver Plan de Testing).
- Validación legal pendiente de la cátedra o de un asesor: esquema de consentimiento por representante, plazos de retención y base legal de la transferencia internacional (escritos en el Doc como propuesta del equipo).

## 4. Inconsistencias detectadas al revisar la Instancia 1 (resueltas el 15/10/2026)

| # | Qué | Cómo quedó |
| --- | --- | --- |
| A | **Proveedor de IA** | El equipo confirmó **Gemini (`gemini-3.5-flash-lite`)**. Se unificó en el Doc: riesgos, supuestos, Arquitectura (sistemas externos) y Privacidad (6.2 y «qué sale del hogar») dicen «hoy Gemini de Google, con OpenAI como alternativa». En `09` los textos de consentimiento nombran a Google (Gemini) |
| B | **Resumen del presupuesto** | Actualizado con la infraestructura real: gasto real **$574.300,45** (hardware $502.283,45 + infraestructura $72.017), desvío de **+$74.300,45 (+14,9 %)**; falta el mes de noviembre de Hostinger ($42.892), con lo que el total proyectado es **$617.192,45** (+$117.192,45, +23,4 %). Corregidos la tabla «Frente al tope», el párrafo siguiente, el riesgo R13, 6.3 y la restricción presupuestaria |
| C | **Valor esperado** | Agregado el apartado «Valor esperado» en la Propuesta del Estudio Inicial y corregido el objetivo (ya no dice «detectar situaciones de riesgo») |
| D | **Ficha del Acta** (Versión 1.0, 05/05/2026) | Se resuelve con el historial de revisión del final (pendiente) |
| E | Typo «VIrginia» | Ya estaba corregido |

Pendiente de detalle: la fila de gasto de Hostinger de noviembre figura en la tabla CAPEX como «Pendiente $42.892»; si cambia el tipo de cambio o el plan, actualizar también el resumen de 6.1.

## 4 bis. Borradores a revisar de la Instancia 2 (no son `[A COMPLETAR]`)

Agregados el 15/10/2026; detalle en `11 - Revisión contra la guía de la cátedra.md`, sección 10.

- **ADR-012: Diseño de API** y las **alternativas consideradas** de los ADR-001, 002, 003, 004, 005, 007 y 008: el equipo debe confirmar que reflejan lo que se evaluó.
- **Product Backlog, épicas 4 a 9** (21 historias): criterios de aceptación y **estimaciones propuestas** (en Jira solo hay puntos en tareas de los Sprints 0 y 1).

## 4 ter. Nombres de los componentes (corregido el 16/10/2026)

Por indicación del equipo: **Aurora Core** es el backend central (antes se llamaba AuroraCareBack; no existe un «Aurora Care Back») y el backend de IA es **Aurora Worker IA** (repositorio `Aurora-Worker-IA`).

- **En el Doc:** se corrigió la tabla del stack tecnológico del informe de Sprints 0 a 2 (ahora con Aurora Core y Aurora Worker IA, y los datos vigentes: Supabase Auth, voz con Azure y respaldo local, Aurora Band fuera del MVP), la nota de nombres y las menciones históricas de AuroraCareBack, que ahora dicen «entonces AuroraCareBack, hoy Aurora Core».
- **Pendiente al replicar en el repo (`Document Hub/`):** aplicar lo mismo en `Informe Sprint 2.md`, `Decisión de Alcance — Aurora Band fuera del MVP.md` y los artefactos de trazabilidad de AURA-82, 87, 88, 89 y 96, que todavía mencionan AuroraCareBack.
- **Fuera del vault (código):** `AuroraCore/README.md`, `deploy/README.md`, `deploy/deploy.sh`, `deploy/docker-compose.yml` y `openspec/config.yaml` siguen diciendo «AuroraCareBack». El `deploy/README.md` además describe Nginx por puertos cuando hoy es Traefik. Conviene corregirlos antes del manual de instalación (Instancia 5).

## 5. Otros datos a confirmar (no están marcados en el Doc)

| Dato | Dónde está |
| --- | --- |
| Responsable del tratamiento de datos (nombre y domicilio: equipo, UTN o una persona); no se incluyó en el borrador de la política | `09 - Análisis legal y textos de Care.md`, sección 5.12 |
| Validación legal de los textos de Care (política de privacidad, consentimientos, T&C) por una persona con matrícula | `09 - Análisis legal y textos de Care.md` |
| Reemplazar a mano los tres diagramas C4 por `figuras/C4 Nivel 1 - Contexto.png`, `C4 Nivel 2 - Contenedores.png` y `C4 Nivel 3 - Despliegue.png`, y revisar la figura CI/CD de 5.2 (puede mencionar `develop`) | Arquitectura 2.1 a 2.3 y 5.2 |
| Actualizar el índice del Doc (Ctrl+clic → Actualizar) | Inicio del Doc |

## 6. Revisión de coherencia (checklist de `00`, corrida el 15/10/2026)

- **Quedan a propósito (historia, no se tocan):** Auth0 en los informes de Sprint 0 a 2 (con la nota de actualización al 12/10 sobre la tabla del stack), ADR-006 (STT local, ElevenLabs, RPi 4/5; marcado como reemplazado por ADR-011), ADR-009 (Aurora Band; marcado «sin implementar»), pgcrypto como alternativa descartada en ADR-010, GDS en el glosario y B2B/B2G en 2.3.
- **Corregido en el Doc:** glosario (alerta crítica, comunicación de emergencia, datos biométricos, evento, deambulación errática, escalamiento, geofencing y zona segura, con la marca de futuras versiones); texto cortado en Plan 2.1; Entregable 3 (notificaciones por omisiones críticas); «IoT» en Arquitectura (1.2 y ADR-004); resto «[cite: 504]» en el Plan de Testing; mapa de historias (wearable en lugar de «pulsera IoT»); Épica 3 del Backlog marcada como fuera del MVP.
- **A decidir:** el glosario no tiene entradas para «Consentimiento» ni «Retención».


## 7. Replicación al repo (16/10/2026)

Los cambios del Doc se replicaron en `Document Hub/` (detalle en `11`, sección 14). Con eso, el repo quedó alineado con el Doc salvo lo que sigue abierto en la sección 5. Los READMEs de los repos de código (que siguen diciendo «AuroraCareBack» y, en el de despliegue, «Nginx» aunque se usa Traefik) están fuera de este repo y quedan para el equipo.
