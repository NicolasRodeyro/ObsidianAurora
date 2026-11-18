---
base: "[[Document Hub.base]]"
Category:
  - Documentación Interna
tipo: retrospectiva-de-proyecto
ticket: AURA-191
estado: borrador al 2026-11-17, a validar y completar por el equipo
Last updated time: "2026-11-17T00:00:00"
---

# Retrospectiva de Proyecto Aurora (borrador)

> [!warning] Borrador para el equipo
> Entregable de la Instancia 5 (AURA-191, responsable Jeremías). Lo que figura acá sale de los datos del Doc y de Jira al 17/11/2026. **Lo que opina el equipo no se inventa**: queda marcado **[A COMPLETAR POR EL EQUIPO]** y se llena en una sesión de retrospectiva. La propuesta de «qué haríamos distinto» es la que ya estaba en el informe del Sprint 6 y hay que validarla.

## 1. Qué se construyó

El proyecto se desarrolló entre el 21/04 y noviembre de 2026, con Scrum y sprints de 3 semanas.

- **Cuatro componentes de producto:** Aurora Home (asistente de voz en una Raspberry Pi 5), Aurora Care (app móvil del cuidador, con un rol para el paciente), Aurora Core (backend central) y Aurora Worker IA (servicio de inteligencia artificial). Aurora Band, la pulsera, quedó **fuera del MVP** el 29/08/2026 por restricción presupuestaria.
- **Documentación:** 98 requerimientos funcionales y 52 no funcionales, decisiones de arquitectura (ADR), modelo de datos de 50 tablas en 10 módulos, y artefactos de trazabilidad por historia.
- **Pruebas (línea base del 16/10/2026):** Aurora Core 1.579, Aurora Home 1.902, Aurora Care 1.190 y Worker IA 196 pruebas pasando. Los archivos de prueba de Aurora Core pasaron de 4 a 114. La cobertura no se mide.
- **Extensión fuera del plan original:** botón «Necesito ayuda», ubicación en vivo del celular del paciente y aviso de salida de zona segura, con consentimiento propio y límites explícitos (ver [[Decisión de Alcance — Ubicación en vivo y geofencing]]).

## 2. Los números del proceso

| Métrica | Meta | Sprint 1 | Sprint 3 | Sprint 4 | Sprint 5 | Sprint 6 | Sprint 7 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Cumplimiento del sprint | ≥ 80 % | 88 % | 47 % | 47 % | 61 % | 57 % | 65 % (15 de 23; ver nota) |
| Trabajo arrastrado | causa registrada | 12 % | 61 % | 57 % | 28 % | 42 % | 35 % (8 de 23) |
| Desvío de cierre | ≤ 2 días | +25 días | +3 días | +1 día | +7 días | +2 días | [A CONFIRMAR] |

Los Sprints 0 y 2 no tienen medición (el Sprint 0 fue de definición y el «Sprint 3» de Jira quedó vacío). En el Sprint 7 no están registrados los tickets comprometidos al inicio, así que el porcentaje cuenta todo lo que figura en el sprint, y 9 de sus 15 cierres fueron depuración del tablero.

**Presupuesto.** Tope de $500.000. Gasto real: $574.300,45 (hardware de Aurora Home e infraestructura). Con el mes de noviembre de Hostinger ($42.892) llega a $617.192,45, un 23,4 % sobre el tope (ver el Plan de Proyecto, sección 6).

## 3. Lo que funcionó

Datos del Doc y de Jira:

- **Sacar Aurora Band del MVP a tiempo (29/08)** permitió concentrar el trabajo en Home, Core y Care.
- **Invertir en pruebas e integración continua desde el Sprint 4:** la suite de Core pasó de 4 a 114 archivos de prueba y a 1.579 pruebas, y el aislamiento entre hogares (un defecto hallado y corregido el 22/08) quedó cubierto por un test obligatorio en la plantilla de pull request.
- **Documentar con ADR y artefactos de trazabilidad**, algo que la cátedra destacó en su devolución del 12/10.
- **El desvío de cierre bajó de +25 días (Sprint 1) a +1 día (Sprint 4)** y volvió a +2 días en el Sprint 6.
- **Aplicar las 14 correcciones de la cátedra** (AURA-186) dentro del sprint.

**Valoración del equipo:** [A COMPLETAR POR EL EQUIPO].

## 4. Lo que no funcionó

- **El cumplimiento no volvió al 80 % después del Sprint 1.** Los sprints se estiraron y el trabajo nuevo desplazó al comprometido: entraron 25 tickets al Sprint 6 después del 17/10.
- **El trabajo y el conocimiento se concentraron en pocas personas y al final del plazo.** En el Sprint 5, Octavio y Mateo tuvieron el 57 % de los tickets y el 40 % de los commits se hizo en los últimos 6 días. Aurora Home dependió de una sola persona (riesgo R19).
- **El tablero de Jira dejó de ser confiable** en varios períodos: numeración que no coincide con el calendario, tickets finalizados sin sprint y cierres en lote para depurarlo.
- **Las reviews y retrospectivas se registraron de forma desigual:** hay planilla hasta el Sprint 3. Las de los Sprints 4 a 7 se reconstruyeron desde Jira.
- **El backend arrancó tarde** (primer código de servidor en el Sprint 2), y la conexión de la app con la base de datos estuvo bloqueada (AURA-63).
- **Operación sin respaldo ni monitoreo:** gestión de secretos (AURA-147) y respaldos (AURA-148) quedaron fuera de todo sprint, y de ellas depende el manual de instalación y operación (AURA-189).
- **Una función fuera del MVP, la ubicación, entró en el último sprint** y obligó a actualizar el alcance, el encuadre legal y las pruebas (AURA-215).
- **El equipo señaló en su retrospectiva combinada:** faltó constancia (todos menos Mateo) y le habría servido presupuesto para Hostinger, más tiempo y una profesora más presente.

## 5. Lo que haríamos distinto (propuesta a validar)

- Comprometer en cada sprint solo lo que se puede terminar, y no sumar trabajo a mitad de camino.
- Mantener el tablero al día y los sprints de Jira alineados con el calendario, para no reconstruir sprints ni corregir estados en auditorías.
- Repartir la carga y el conocimiento desde el principio, con documentación de traspaso.
- Registrar las reviews y las retrospectivas en cada sprint.
- Fijar un corte de alcance explícito antes de sumar funciones en el último sprint.

**Lo que el equipo cambiaría:** [A COMPLETAR POR EL EQUIPO].

## 6. Acciones de mejora del proceso: cómo terminaron

El equipo acordó seis acciones con objetivo en el Sprint 3. Estado al 17/10/2026: implementadas la 1 (DoD como normativa para cada IA o skill) y la 2 (GitHub Actions para CI/CD); parciales la 3 (PRs vinculadas al ticket: 14 de 87 en Core) y la 6 (base de datos de prueba con volumen); sin hacer la 4 (restringir PRs que no cumplan la convención) y la 5 (cron para Supabase). Las implementadas fueron las que se resolvían con una plantilla o un archivo de configuración.

## 7. Qué queda abierto al cierre

Detalle completo en [[Trabajo pendiente y próximos pasos]] y en [[Registro de Riesgos]]. Lo principal:

- **Entregables de la Instancia 5:** manual de instalación y operación (AURA-189) y esta retrospectiva (AURA-191) por hacer; proceso actualizado (AURA-187) en curso; instructivos (AURA-188) en revisión.
- **Producto:** validación de recuerdos (AURA-76) sin desplegar ni demostrar de punta a punta; terapias personalizadas sin funcionar de punta a punta; errores AURA-110, 111 y 175 sin sprint.
- **Legal y privacidad:** los textos de consentimiento no tienen validación legal (AURA-215), y la promesa de borrado de ubicaciones a los 7 días depende de programar la purga en n8n (AURA-221).
- **Calidad:** cobertura sin medir; latencia de voz de Aurora Home por encima del objetivo (p95 de 8,02 s frente a 2 s); guías de las 45 actividades sin revisión clínica.

## 8. Aprendizajes y recomendaciones

**Por integrante y del equipo:** [A COMPLETAR POR EL EQUIPO].

**Recomendaciones para una versión siguiente de Aurora:** [A COMPLETAR POR EL EQUIPO]. Los puntos abiertos de la sección 7 y la integración de Aurora Band (futuras versiones) son el punto de partida.
