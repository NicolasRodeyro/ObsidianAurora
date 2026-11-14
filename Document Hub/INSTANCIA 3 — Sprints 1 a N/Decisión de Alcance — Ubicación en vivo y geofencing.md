---
base: "[[Document Hub.base]]"
Created time: 2026-11-09T21:00:00
Last edited by: Mateo Romero Plaza
Created by: Mateo Romero Plaza
Category:
  - Análisis
Last updated time: 2026-11-09T21:00:00
---
# Decisión de Alcance — Ubicación en vivo y geofencing

**Fecha:** 2026-11-09 · **Ticket:** AURA-215 · **Estado:** encuadre decidido por el equipo el 09/11/2026 · **Pendiente:** validación legal de los textos

Los documentos del 12/10 dicen que ubicación y geofencing son **«futuras versiones»** y que los datos de ubicación **«no se procesan en el MVP»** (ver [[Decisión de Alcance — Aurora Band fuera del MVP]]). Entre el 25/10 y el 07/11 se implementó una función que **sí procesa ubicación** desde el celular del paciente. Esta nota fija qué se construyó, qué se guarda, qué promete y qué no, y qué partes del Docs hoy lo contradicen.

> Los hechos de las secciones 2 a 5 se verificaron contra el código de AuroraCore y AuroraCare y contra la base de staging el 2026-11-09. Lo que no se pudo verificar se marca como **pendiente**.

## 1. Qué se implementó

| Función | Qué hace | Tickets |
| --- | --- | --- |
| Botón «Necesito ayuda» | El paciente lo toca; el celular manda su ubicación **una sola vez** y el cuidador recibe una alerta crítica con push. | AURA-207 |
| Ubicación en vivo | Con consentimiento, el celular informa su posición en segundo plano; el cuidador ve dónde está y hace cuánto. | AURA-210, 211, 212 |
| Salida de zona segura | **Core** (no el celular) decide si el paciente salió o volvió de una zona configurada y avisa al cuidador. Las zonas se crean desde un mapa en Care. | AURA-210 (detección), AURA-208 (zonas con mapa) |
| «Perdimos la señal del celular» | Si el celular lleva más de 20 minutos sin informar y hay zonas activas, se avisa al cuidador. | AURA-213 |

La ubicación sale de un **celular común** del paciente, no de Aurora Band ni de ningún wearable: la decisión del 29/08 sobre la pulsera **no cambia**.

## 2. Modelo de datos (verificado)

| Dato | Dónde se guarda | Cuánto se conserva | Cuándo se borra |
| --- | --- | --- | --- |
| **Última posición** del celular (latitud, longitud, precisión, hora de captura y de recepción, estado de zona) | `PatientPhoneLocation`, **una fila por celular**. Cada lectura **pisa** a la anterior. | Solo la última. **No hay historial ni recorrido.** | Al **retirar el consentimiento** de ubicación en vivo y al **desvincular** el celular. |
| Ubicación asociada a una **alerta** (pedido de ayuda o salida de zona) | Dentro de la alerta y del evento de salida de zona. Es «dónde estaba cuando pasó esto». | **7 días** (`LOCATION_RETENTION_DAYS = 7`). | Pasados 7 días se borra el lugar y la alerta queda con la marca `location_purged_at`. |
| El **hecho** del pedido de ayuda | Evento crítico de auditoría, **sin** la ubicación. | Según la política de eventos y alertas (2 años). | — |
| **Consentimiento** (tipo, versión del texto, fecha, estado) | `ConsentRecord` | Mientras dure la relación + 5 años (archivo 07). | Es el único dato que sobrevive a la baja. |

Además, la precisión de las coordenadas se acota a 5 decimales (~1 m): más precisión no cambia a dónde hay que ir y revela más de la cuenta. Un reloj mal puesto en el celular no puede hacer pasar un dato viejo por reciente.

El pedido de ayuda **se avisa aunque no haya consentimiento de ubicación vigente**: pedir auxilio no puede depender de un trámite. Lo único que se descarta en ese caso es el lugar.

## 3. Consentimientos (para la validación legal)

Hay **dos consentimientos con texto propio**, porque son finalidades distintas, y los dos quedan registrados en `ConsentRecord` con la versión exacta que aceptó la persona. En staging hay registros de ambos desde el 31/10.

**A. Ubicación solo cuando pide ayuda** · tipo `patient_phone_location_help` · versión `patient-phone-location-v2` · se muestra al vincular el celular

> *Tu ubicación, solo cuando pedís ayuda*
> - Si tocás «Necesito ayuda», Aurora le avisa a tu cuidador y le dice dónde estás.
> - Solo se comparte en ese momento. Si no activás el seguimiento aparte, Aurora no te sigue ni guarda por dónde andás.
> - El lugar se borra a los 7 días.
> - *Esto no reemplaza una llamada de emergencia: si es urgente, llamá al 911.*
> - Casilla: «Entiendo y acepto compartir mi ubicación cuando pido ayuda»

**B. Ubicación en vivo** · tipo `patient_phone_live_location` · versión `patient-phone-live-location-v1` · se puede retirar aparte

> *¿Querés que tu cuidador vea dónde estás?*
> - Mientras esté activado, Aurora usa la ubicación de tu celular aunque no la tengas abierta, y tu cuidador puede ver dónde estás.
> - Si salís de una zona segura, le avisamos a tu cuidador.
> - Vas a ver siempre un aviso en la pantalla que dice que Aurora comparte tu ubicación.
> - Solo guardamos tu última posición, no por dónde anduviste. El lugar de una alerta se borra a los 7 días.
> - Lo podés desactivar cuando quieras.
> - *Esto no reemplaza una llamada de emergencia: si es urgente, llamá al 911.*
> - Casilla: «Entiendo y quiero que mi cuidador vea dónde estoy»
>
> Aviso fijo de Android mientras comparte: **«Aurora comparte tu ubicación»** — *«Tu cuidador puede ver dónde estás. Lo podés desactivar abriendo Aurora.»*

`[VALIDAR]` con una persona con criterio legal (Ley 25.326, arts. 5 y 7; la ubicación de una persona con Alzheimer es un dato sensible): que la redacción sea suficiente como consentimiento informado, que la finalidad esté bien delimitada y que la retirada sea tan fácil como el alta. **Ambos textos están marcados «pendiente de validación legal» en el código** y deben seguir así hasta que alguien los valide.

## 4. Límites del aviso (para no venderlo como un sistema de seguridad)

**La función no garantiza detectar una salida.** Es un aviso útil que depende del celular y de la red. Reglas reales de Core (`zone_tracking.py`):

- Una lectura con precisión peor que **100 m** se ignora por completo.
- Para dar por «afuera» hacen falta **2 lecturas seguidas**, separadas por al menos **15 s**, y todas fuera de **todas** las zonas incluso descontando la imprecisión del GPS. Dentro de una casa el GPS salta entre 20 y 100 m: las reglas prefieren **no avisar** antes que dar falsas alarmas.
- Una lectura en la «zona gris» (afuera por poco) corta la racha.
- Para dar por «volvió» hay que estar **10 m** adentro de la zona.
- Una lectura más vieja que **15 minutos** (por ejemplo, acumulada sin red) actualiza dónde estaba el paciente pero **no genera aviso**: avisar tarde por un dato viejo es peor que esperar el próximo.

Lo que puede dejar al cuidador sin aviso:

| Causa | Qué pasa |
| --- | --- |
| Batería baja o ahorro de batería | El sistema puede matar el servicio de ubicación en segundo plano. |
| GPS apagado o sin señal (interiores, subsuelos) | No hay lecturas. |
| Sin datos móviles ni wifi | Las lecturas no llegan a Core. |
| App cerrada a la fuerza | Android **no la relanza**. |
| Celular apagado, olvidado o dejado en casa | El aviso mide el celular, **no a la persona**. |

Mitigación parcial: si el celular lleva **más de 20 minutos** sin informar y hay zonas activas, Core crea la alerta «Perdimos la señal del celular del paciente» (una por silencio). Detecta el silencio, no la causa.

**Medición pendiente.** El plan de testing (archivo 08, §4) exige, antes de que el geofencing entre al alcance, definir y validar «precisión de ubicación» y «tiempo de detección de salida». Hoy existen los **parámetros** de arriba pero **no hay métricas medidas en campo**. Estimación teórica, no medida: la segunda lectura confirmatoria llega al menos 15 s después de la primera; con lecturas cada ~30 s, el aviso puede tardar del orden de un minuto más la entrega del push.

## 5. Diferencias entre lo que se promete y lo que hoy se cumple

1. **«El lugar se borra a los 7 días»** está en los dos textos de consentimiento. La purga existe (comando y endpoint desplegado en staging) pero **todavía no corre sola**: falta programarla en n8n (AURA-213). Hasta entonces, la promesa se cumple solo si alguien la ejecuta a mano. **Es la brecha más importante**, porque está escrita en lo que acepta la persona. La tarea de programarlo en n8n (purgas y barrido de silencio) está en **AURA-221**, asignada a Octavio en el Sprint 8.
2. **QA en celulares reales** (AURA-214, figura **Finalizada** en Jira al 09/11/2026): se confirmó la pantalla apagada, la creación de zonas con el mapa y el botón de ayuda; **no se confirmaron** la salida de zona caminando, modo avión, GPS apagado, batería baja ni el consumo de batería.
3. **Hallazgo B3 del análisis del 12/10** (consiente el cuidador, no el paciente): esta función lo **mejora**, porque el consentimiento lo da quien usa el celular. La **presunción de capacidad** del paciente con Alzheimer **sigue abierta**, y el equipo la **aceptó como limitación el 09/11/2026**: queda anotada acá y se declara, no se resuelve en este alcance.

## 6. Encuadre ante la cátedra (decidido el 09/11/2026)

**No cambiar el alcance del MVP.** El equipo decidió presentarlo como **extensión con prototipo funcional y alcance explícito**: algo que se vio hacia el final del desarrollo para que el paciente pueda confirmar sus recordatorios desde su celular y para avisar al cuidador cuando está fuera de su casa (botón de ayuda, ubicación en vivo y aviso de salida de zona), con los límites de la sección 4, con consentimientos propios y con la validación legal pendiente declarada. Aurora Band, la biometría y la detección de caídas **siguen siendo futuras versiones**.

**Redacción acordada.** Hay que usar este mismo texto en la presentación, porque el criterio «cumplimiento del alcance» compara lo comprometido con lo desarrollado:

- **Para el Docs y los archivos 04 y 07:** *«Aurora Band (la pulsera) sigue fuera del MVP por restricción presupuestaria (decisión del 29/08/2026). Hacia el final del desarrollo se agregó una extensión con prototipo funcional en el celular del paciente, para que pueda confirmar sus recordatorios y para avisar al cuidador cuando está fuera de su casa (botón de ayuda, ubicación en vivo y aviso de salida de zona segura). Tiene consentimiento propio, límites explícitos y los textos de consentimiento pendientes de validación legal. No cambia el alcance del MVP.»*
- **Para una diapositiva (una sola frase):** *«La pulsera quedó fuera por presupuesto; sobre el final sumamos una extensión con prototipo funcional: el celular del paciente le permite confirmar sus recordatorios y avisar al cuidador cuando está fuera de casa.»*
- **Lo que no se dice:** que sea un sistema de seguridad, que los consentimientos estén validados, que el lugar «se borra solo a los 7 días» mientras la purga no esté programada, ni que el aviso de salida de zona esté probado en la calle (AURA-214 está incompleta).

## 7. Correcciones propuestas al Docs

Estos archivos contradecían la implementación. **Actualización del 09/11/2026:** se aplicaron las correcciones en `01 - Estudio Inicial`, `Estudio Inicial Aurora`, `04 - Alcance y MVP único`, `07 - Privacidad, seguridad y datos sensibles`, `08 - Plan de Testing` y `Trazabilidad RF-Épicas` (cambios sin commitear: se revisan con `git diff`). Los cambios del Docs de Google quedaron como sugerencias y el equipo las aceptó. Los `RF-92 a RF-98` no se modificaron.

| Archivo | Hoy dice | Propuesta |
| --- | --- | --- |
| `Correcciones - 12-10-2026/07 - Privacidad, seguridad y datos sensibles.md` (tabla de datos, ~l.31) | «Datos biométricos y de ubicación — **No se procesan en el MVP** (Futuras versiones)» | Separar: **Datos biométricos** → «No se procesan en el MVP (futuras versiones)». **Ubicación del celular del paciente** → «Se procesa con consentimiento propio (ver [[Decisión de Alcance — Ubicación en vivo y geofencing]]). Tratamiento: última posición y ubicación de alertas. Proveedores: Aurora Core / Supabase.» Sensibilidad: **Alta**. |
| Ídem 07 (tabla de retención, ~l.87) | «Datos biométricos y de ubicación — (Futuras versiones) … ubicación 7 días como punto de partida» | Biometría sigue como futuras versiones. **Ubicación: última posición mientras dure el consentimiento (se borra al retirarlo o desvincular); ubicación de alertas, 7 días.** Registrar que la purga automática depende de n8n (AURA-213). |
| `04 - Alcance y MVP único.md` (tabla «Alcance del MVP vigente») | Geofencing y salida de zona figuran como futuras versiones (fila de «Monitoreo biométrico, de movimiento…» y glosario) | Agregar una fila **«Ubicación en vivo del celular del paciente, botón de ayuda y aviso de salida de zona segura (con consentimiento y límites explícitos)»** marcada como **extensión con prototipo funcional**. Dejar «Monitoreo biométrico, de movimiento y detección de caídas (Aurora Band)» en futuras versiones. |
| `08 - Plan de Testing (métricas críticas).md` §4 y §5 | «Geofencing» como función de futuras versiones; el caso «salida de zona» queda como futuras versiones | Mover **Geofencing** a una fila propia «extensión»: métricas a definir = precisión de ubicación y tiempo de detección (hoy sin medir; ver §4 de esta nota). Agregar casos: consentimiento/retiro y borrado de la posición, silencio de 20 min, lectura vieja que no avisa, GPS impreciso que se ignora. |
| `01 - Estudio Inicial (AS-IS y TO-BE).md` (~l.128, 138) y `Estudio Inicial Aurora.md` | «Información biométrica y de ubicación … futuras versiones; requiere un dispositivo wearable»; «Alta: salida de zona segura — futuras versiones» | Aclarar que la **biometría** requiere wearable (futuras versiones), pero la **ubicación** y la salida de zona hoy se obtienen del **celular del paciente** con consentimiento. |
| `Document Hub/Trazabilidad RF-Épicas.md` | Módulos 2 y 3 en `vision` | Revisar las filas de geofencing/ubicación y trazarlas a AURA-207, 208, 210 a 214. |

## 8. Pendientes de esta decisión

- [ ] Validación legal de los dos textos de consentimiento (sección 3). **Decisión del equipo (09/11/2026): se hace cuando los tickets estén en revisión.**
- [x] Decidir el encuadre ante la cátedra (sección 6): decidido el 09/11/2026.
- [ ] Programar la purga de ubicaciones en n8n **antes** de afirmar el borrado a los 7 días: **AURA-221**, asignada a Octavio.
- [ ] Completar la QA de AURA-214 con los casos no confirmados.
- [x] Aplicar las correcciones de la sección 7 en el vault y en el Docs (09/11/2026).
- [ ] Definir y medir precisión y tiempo de detección de salida (sección 4).
- [x] Presunción de capacidad del paciente (hallazgo B3): **limitación aceptada** el 09/11/2026 (sección 5, punto 3).
