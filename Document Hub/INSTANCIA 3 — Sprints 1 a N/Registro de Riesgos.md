---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
Last updated time: 2026-10-17
---

# Registro de Riesgos de Aurora

Registro único y vivo de los riesgos del proyecto, con su estado al **17/10/2026** y cómo evolucionó en cada sprint. Se actualiza en cada informe de sprint; este documento reemplaza a las tablas de riesgos sueltas de los informes, que quedan como historia de cada sprint.

## 1. Cómo se lee

Un **riesgo** es algo que *puede* pasar y afectar el proyecto o a las personas que usan el sistema. Cuando pasa, deja de ser riesgo y se convierte en un **problema** (en Scrum, un impedimento o un error). Un registro sirve para no enterarse tarde: cada riesgo tiene una probabilidad, un impacto y una forma de reducirlo.

| Campo | Qué significa |
|---|---|
| Probabilidad | Qué tan probable es que ocurra: Baja, Media, Alta. |
| Impacto | Cuánto daño haría: Medio, Alto, Muy alto. |
| Estado | **Abierto** (sin mitigación suficiente), **Mitigado en parte**, **Mitigado**, **Materializado** (ya ocurrió), **Aceptado** (se decidió convivir con él) o **Cerrado**. |
| Evidencia | Dónde se puede comprobar el estado: ticket de Jira, commit o documento. |

Los riesgos R8, R9, R10 y R11 son de **seguridad del paciente**: una alerta que no llega o una respuesta incorrecta del asistente puede influir en un paciente o en la reacción de un cuidador. Por eso son los prioritarios.

Fuente de los riesgos R1 a R14: sección 7.1 del [[Project Charter]]. Los riesgos R15 en adelante se detectaron durante los sprints.

## 2. Riesgos del Plan de Proyecto (R1 a R14)

| ID | Riesgo | Prob. | Impacto | Estado al 17/10 | Evidencia y lectura |
|---|---|---|---|---|---|
| R1 | Falta de información médica útil para las terapias | Media | Alto | **Mitigado en parte** | Hay un catálogo de terapias de la psicopedagoga cargado (AURA-184, Sprint 5). Sigue pendiente formalizar fechas y alcance de la validación profesional, como dice el Plan de Proyecto. |
| R2 | No conseguir una pulsera para Aurora Band | Alta | Alto | **Materializado y aceptado** | Aurora Band quedó fuera del MVP el 29/08/2026. La investigación AURA-64 se cerró el 17/10. Ver [[Decisión de Alcance — Aurora Band fuera del MVP]]. |
| R3 | Costos de tokens de la IA | Media | Medio | **Abierto, sin evidencia** | Ningún ticket ni informe registra la caché local ni las alertas de facturación previstas. Confirmar con el equipo. |
| R4 | Rechazo o baja adopción del paciente | Alta | Alto | **Abierto, a confirmar** | No hay registro de pruebas con adultos mayores en los informes. Confirmar si existieron y dónde constan. |
| R5 | Filtración de datos médicos sensibles | Baja | Muy alto | **Mitigado en parte** | Hecho: cifrado de PII con Fernet (ADR-010, AURA-97), consentimiento obligatorio (AURA-98, 160, 169, 170), escritura entre hogares corregida (22/08) y escaneo de secretos con gitleaks en CI. **Pendiente:** gestión de secretos (AURA-147, sin sprint) y política de retención verificable. |
| R6 | Abastecimiento de hardware | Media | Alto | **Mitigado** | La Raspberry Pi 5 y el hardware de audio se compraron y Aurora Home funciona sobre hardware real (AURA-152 y 153, Sprint 4). |
| R7 | Sobrecarga o falta de constancia del equipo | Media | Alto | **Abierto, en aumento** | «Constancia» aparece en las retros de tres sprints. Octavio concentró el 42 % de los tickets del Sprint 3 y el 32 % del Sprint 5; Mateo cerró 11 de 16 en el Sprint 4. El 40 % de los commits del Sprint 5 se hizo en los últimos 6 días. |
| R8 | Falso negativo: una situación importante no se comunica al cuidador | Media | Muy alto | **Abierto, prioritario** | Mitigado en parte: pruebas de punta a punta de Home con Core (AURA-103 y 123), corrección de recordatorio colgado por fallo de audio (AURA-159) y de dosis vencidas tras reloj desincronizado (AURA-158). **Abiertos:** AURA-110 («todo en orden» cuando falla la carga), 111 (datos de demostración en «Alerta atendida»), 164 (compliance oculta estados reales) y 175 (botón «Llamar» siempre deshabilitado). Los tres sin sprint están fuera del sprint por decisión del 17/10. |
| R9 | Falso positivo: alertas innecesarias | Media | Alto | **Mitigado en parte** | El backend suprime alertas duplicadas (5 minutos, bloqueo por paciente, 05/10, según `docs/agent-lessons.md` de AuroraCore). La cadencia de reconfirmación de recordatorios (AURA-180) está sin definir. |
| R10 | Sin conectividad, Aurora Home no usa la nube | Media | Alto | **Mitigado en parte** | Base local SQLite con cola de salida (AURA-95), recordatorios sin conexión (AURA-156) y voz local de respaldo. Falta probar la reconexión en escenarios reales. |
| R11 | Alucinaciones de la IA | Media | Muy alto | **Mitigado en parte** | Las respuestas se basan en la memoria del paciente (AURA-105) y los datos nuevos esperan la aprobación del cuidador (AURA-76: el backend existe, **la demostración está pendiente**). Los límites del asistente (no diagnosticar) deben comprobarse en la demostración. |
| R12 | Funciones biométricas sin validar | Alta | Medio | **Aceptado** | Trabajo futuro: el MVP no ofrece monitoreo biométrico ni detección de caídas. |
| R13 | Desvío presupuestario | Alta | Medio | **Materializado** | Gasto real de $574.300,45 frente al tope de $500.000 (sección 6.1 del Plan de Proyecto). Falta sumar el mes de noviembre de Hostinger. |
| R14 | Dependencia de proveedores externos | Media | Alto | **Mitigado en parte** | La autenticación pasó de Auth0 a Supabase Auth (18/09). Siguen Azure, Gemini, Supabase, Hostinger y Expo, con proveedor de IA configurable y voz local de respaldo. |

## 3. Riesgos detectados durante los sprints (R15 en adelante)

| ID | Riesgo | Detectado | Estado al 17/10 | Evidencia y lectura |
|---|---|---|---|---|
| R15 | Dependencia del backend: las pantallas no se pueden conectar si no existe | Sprint 1 | **Cerrado** | AURA-63 quedó bloqueada hasta que existió el backend (repositorio desde el 23/07); se cerró en el Sprint 4. |
| R16 | Tablero poco confiable: el sprint no refleja el trabajo real | Sprint 2 | **Mitigado en parte** | El desvío de cierre mejoró (+25, +3, +1 días), pero hay 25 tickets sin sprint (16 finalizados) y el «Sprint 3» de Jira quedó vacío. Ver [[Informe Sprint 2]]. |
| R17 | Calidad sin red de seguridad (sin CI/CD, pocos tests, revisión cruzada débil) | Sprint 3 | **Mitigado en parte** | Integración continua desde el 29/08 y plantilla de PR. Los archivos de test pasaron de 4 a 114 en AuroraCore. **Pendiente:** cobertura mínima medida y regla de ramas con ticket (14 de 87 PRs de Core). |
| R18 | Escritura entre hogares (aislamiento multi-tenant) | Sprint 3 | **Materializado y corregido** | Hallado y corregido el 22/08 en 5 endpoints. La plantilla de PR exige ahora un test de aislamiento. |
| R19 | Dependencia de una persona para Aurora Home | Sprint 4 | **Abierto** | Mateo cerró 11 de los 16 tickets del Sprint 4 y 12 de 34 en el Sprint 5, casi todos de Home. Falta documentación de traspaso. |
| R20 | Operación sin respaldo ni monitoreo | Sprint 5 | **Abierto** | AURA-148 (backups, monitoreo y runbook) y AURA-147 (secretos) sin sprint. El Doc declara que no hay monitoreo ni backups definidos. Ver el manual de instalación (AURA-189). |
| R21 | Trabajo concentrado al cierre del sprint | Sprint 5 | **Abierto** | 40 % de los commits en el último cuarto del plazo y +7 días de desvío. Ver [[Informe Sprint 5]]. |
| R22 | Entrega final del 05/11 sin responsables y con demostraciones sin ensayar | Sprint 6 | **Abierto** | AURA-187 a 192 sin responsable; AURA-76 y AURA-134 sin demostración documentada. Ver [[Informe Sprint 6]]. |

## 4. Evolución por sprint

| Sprint | Riesgos que aparecen o cambian |
|---|---|
| 1 | R7 aparece como «constancia» en la retro. Se detecta **R15**. R2 se confirma (AURA-64 pausada). |
| 2 | Se detecta **R16**. R5 gana contexto con la investigación de la Ley 25.326 (03/08). |
| 3 | Se detectan **R17** y **R18** (este último se materializa y se corrige). R14 por Auth0. |
| 4 | R6 pasa a mitigado y R10 a mitigado en parte. Se detecta **R19**. Aparece el primer error de tipo R8 (AURA-110). |
| 5 | R5 avanza (cifrado y consentimiento); R14 mejora (Supabase Auth). Se detectan **R20** y **R21**. R13 suma el VPS de Hostinger. |
| 6 | Se detecta **R22**. R5 y R8 quedan abiertos por decisión de no sumar tickets al sprint. |

## 5. Decisiones sobre riesgos

- **Aceptados explícitamente:** R2 (Aurora Band fuera del MVP, decisión del 29/08/2026) y R12.
- **Aceptación pendiente:** la parte abierta de R5 (AURA-147) y de R8 (AURA-110, 111 y 175) está fuera de todo sprint desde el 17/10. Hay que **aceptarla por escrito** o reconsiderar la decisión. Un riesgo que nadie decidió aceptar sigue siendo un riesgo abierto.
- **Responsables:** no están asignados. Se acuerdan con el equipo (formulario `Correcciones - 12-10-2026/12`, parte C).

## 6. Cómo se actualiza

1. En cada Sprint Review y retrospectiva se revisan los riesgos abiertos: ¿cambió la probabilidad, el impacto o el estado?
2. Los riesgos nuevos se agregan al final con un ID siguiente, el sprint en que se detectaron y la evidencia.
3. Un cambio de estado siempre cita su evidencia (ticket, commit o documento). Si no hay evidencia, el estado es «Abierto» o «A confirmar».
4. Cada informe de sprint enlaza a este registro en lugar de repetirlo.
