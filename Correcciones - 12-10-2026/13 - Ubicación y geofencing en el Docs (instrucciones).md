# Instrucciones para el Docs: ubicación en vivo y geofencing (AURA-215)

**Documento a modificar:** https://docs.google.com/document/d/1jGigjSpOtEeBZSEEqm5ijTiZy22IWZoQPIOaaxsXgbE/edit
**Fuente de los hechos:** [[Decisión de Alcance — Ubicación en vivo y geofencing]] (verificada contra el código y la base de staging el 09/11/2026).

## Reglas para quien edita

1. **Solo la pestaña 1 («Proyecto Aurora 2026»).** No tocar la pestaña 2 (`Proyecto Aurora 2026-Correcciones.md`).
2. **Aplicar como sugerencias** (`writeControl.writeMode = "SUGGEST"`). Si el conector responde «Unsupported WriteControl mode», **no editar directo**: avisar al usuario y esperar.
3. **Leer antes de escribir.** Leer el Doc como texto (Drive `read_file_content` con `includeComments: true`), ubicar cada texto de la columna «Hoy dice» y recién entonces editar. **Si un texto no aparece tal cual, no adivinar: reportarlo y seguir con el resto.**
4. **Cambiar solo las palabras que cambian.** No reescribir párrafos ni tablas enteras. En las tablas, insertar filas con el mismo formato (bordes, fondo, encabezado) que las demás. No retocar numeración de secciones ni el índice.
5. Cada edición con `requiredRevisionId` de una lectura posterior a la última escritura (salvo las hechas solo con `replaceAllText`).
6. **No agregar afirmaciones que no estén acá.** Mantener los marcadores del Doc (`[A CONFIRMAR]`, `[A COMPLETAR]`). Los textos de consentimiento siguen **sin validación legal**: no escribir que están validados.
7. Sin emojis; evitar rayas largas (—) en el texto nuevo.
8. Al terminar: releer, y devolver la lista de lo que se cambió y de lo que **no se encontró**.

## Cambios

### 1. Arquitectura, sección 6.2 «datos que trata Aurora» (tabla)

**Hoy dice (una fila):** `Datos biométricos y de ubicación | — | No se procesan en el MVP | (Futuras versiones)`

**Cambiar por dos filas** (respetar las columnas de la tabla):

| Dato | Origen | Dónde se trata | Sensibilidad |
| --- | --- | --- | --- |
| Datos biométricos | — | No se procesan en el MVP | (Futuras versiones) |
| Ubicación del celular del paciente (última posición y ubicación asociada a las alertas de ayuda y de salida de zona) | Celular del paciente (Aurora Care) | Aurora Core / Supabase. Solo con consentimiento propio, que se puede retirar | Alta (dato sensible) |

### 2. Arquitectura, sección 6.3 «retención con justificación» (tabla)

**Hoy dice (una fila):** `Datos biométricos y de ubicación | (Futuras versiones) | No se tratan en el MVP. Si se incorporan: plazos cortos y justificación propia (biometría 90 días, ubicación 7 días como punto de partida) | —`

**Cambiar por tres filas** (columnas: dato, plazo, justificación, al vencer):

| Dato | Plazo | Justificación | Al vencer |
| --- | --- | --- | --- |
| Datos biométricos | (Futuras versiones) | No se tratan en el MVP. Si se incorporan: plazos cortos y justificación propia (90 días como punto de partida) | — |
| Ubicación del celular del paciente: última posición | Mientras el consentimiento esté vigente | Solo se guarda la última posición, que reemplaza a la anterior: no hay historial de recorridos. Permite al cuidador ver dónde está el paciente y avisar la salida de una zona segura. | Se elimina al retirar el consentimiento o al desvincular el celular |
| Ubicación asociada a una alerta (pedido de ayuda o salida de zona) | 7 días | Permite al cuidador saber dónde estaba el paciente cuando ocurrió el evento. Pasado el plazo no se justifica conservarla. | Se borra el lugar y la alerta queda marcada como depurada. [A CONFIRMAR: depuración diaria automática programada (AURA-213)] |

### 3. Estudio Inicial, «Información que maneja el sistema»

**Hoy dice:** `Información biométrica y de ubicación (frecuencia cardíaca, movimiento, ubicación, temperatura, actividad electrodérmica): (futuras versiones; requiere un dispositivo wearable comercial).`

**Cambiar por dos ítems:**

- `Información biométrica (frecuencia cardíaca, movimiento, temperatura, actividad electrodérmica): (futuras versiones; requiere un dispositivo wearable comercial).`
- `Ubicación del celular del paciente (última posición y ubicación de las alertas de ayuda y de salida de zona): se procesa con consentimiento propio, como extensión con prototipo funcional.`

### 4. Estudio Inicial, «Clasificación de eventos» (tabla)

**Hoy dice (fila de gravedad Alta):** `Alta | Requiere intervención inmediata | Salida de zona segura configurada | Futuras versiones`

**Cambiar solo la última celda por:** `Extensión con prototipo funcional (celular del paciente)`. La fila Crítica (caída, frecuencia cardíaca alta) **queda igual**.

### 5. Estudio Inicial, «Alcance del sistema» y frases de alcance

- **Futuras versiones, viñeta:** `Monitoreo de ubicación y biometría, detección de caídas y delimitación de zonas seguras (geofencing).`
  **Cambiar por:** `Monitoreo biométrico, detección de caídas y de agitación, y detección de eventos de riesgo a partir de un dispositivo wearable.`
- **Frase de cierre del alcance:** `La detección automática de eventos de riesgo (caídas, salida de zona segura, anomalías biométricas) y las llamadas automáticas de emergencia forman parte de la visión del producto y quedan fuera del MVP actual.`
  **Cambiar por:** `La detección automática de eventos de riesgo (caídas, anomalías biométricas) y las llamadas automáticas de emergencia forman parte de la visión del producto y quedan fuera del MVP actual. El aviso de salida de zona segura se ofrece como extensión con prototipo funcional, a partir de la ubicación del celular del paciente.`
- **Agregar una viñeta** al final de la lista de alcance del MVP:
  `Extensión con prototipo funcional: botón «Necesito ayuda», ubicación en vivo del celular del paciente y aviso de salida de zona segura, con consentimiento propio y límites explícitos (ver Plan de Testing).`

### 6. Tabla «Alcance del MVP vigente» (debajo de la matriz del User Story Mapping)

**Agregar una fila** (columna MVP: `Extensión con prototipo funcional`; columna Futuras versiones: vacía):
`Ubicación en vivo del celular del paciente, botón de ayuda y aviso de salida de zona segura (consentimiento propio, límites explícitos)`

La fila `Monitoreo biométrico, de movimiento y detección de caídas (Aurora Band)` **queda en Futuras versiones**.

### 7. Backlog, «Futuras versiones → Monitoreo, Historial y Alertas»

**Hoy dice:** `Detectar la salida del paciente de las zonas seguras y notificar al cuidador (geofencing).`
**Cambiar por:** `Detectar la salida del paciente de las zonas seguras a partir de un dispositivo wearable (Aurora Band) y notificar al cuidador.`

### 8. Glosario

En **Geofencing** y **Zona segura**, reemplazar solo la marca `(futuras versiones)` por: `(extensión con prototipo funcional con el celular del paciente; con wearable, futuras versiones)`. No tocar el resto de la definición. Las marcas de *Datos biométricos*, *Deambulación errática* y *Comunicación de emergencia* **quedan igual**.

### 9. Plan de Testing

**9.a. Criterios de entrada de futuras versiones (sección 4, tabla), fila Geofencing.** Hoy dice `Precisión de ubicación, tiempo de detección de salida`. Dejar esa celda y **agregar una nota debajo de la tabla:**

`Geofencing se implementó como extensión con prototipo funcional. Parámetros vigentes: se ignora toda lectura con precisión peor que 100 m; para dar por «afuera» hacen falta 2 lecturas seguidas separadas por al menos 15 s, fuera de todas las zonas descontando la imprecisión del GPS; para dar por «volvió» hay que estar 10 m adentro; una lectura de más de 15 minutos no genera aviso. La precisión de ubicación y el tiempo de detección de salida todavía no se midieron en campo. [A COMPLETAR]`

**9.b. Tabla «Estrategia y Niveles de Testing», fila End-to-End.** Donde hoy dice que el caso de salida de zona segura queda como futuras versiones, cambiar a: `Salida de zona segura (extensión): lectura fuera de la zona, confirmada → alerta → notificación push al cuidador.`

**9.c. Casos de prueba nuevos** (tabla o lista, con el formato de las demás tablas de la sección 4):

| Caso | Resultado esperado |
| --- | --- |
| Retirar el consentimiento de ubicación en vivo | Se borra la última posición del celular |
| Desvincular el celular | Se borra la última posición |
| Lectura con precisión peor que 100 m | Se ignora, no mueve el estado |
| Una sola lectura fuera de la zona | No genera aviso (hacen falta 2 separadas por 15 s) |
| Lectura de más de 15 minutos de antigüedad | Actualiza la posición, no genera aviso |
| Celular sin informar más de 20 minutos, con zonas activas | Alerta «Perdimos la señal del celular del paciente», una por silencio |
| Pedido de ayuda sin consentimiento de ubicación | La alerta se envía; se descarta solo el lugar |

## Revisar, sin cambiar todavía (confirmar con el equipo)

- **Requerimientos (RF-92 a RF-98, consentimiento):** ver si deben mencionar los dos consentimientos del celular del paciente (ubicación para ayuda y ubicación en vivo). No se verificó qué dicen hoy.
- **Plan de Proyecto 4.1, 4.2 y WBS:** buscar si mencionan geofencing o ubicación como futuras versiones. No se verificó.
- **Backlog:** ver si corresponde agregar una historia de MVP para la extensión. Es una decisión del equipo.
- **Sin cambios:** Aurora Band y la biometría siguen siendo futuras versiones.

---

# Segunda ronda (10/11/2026)

El agente aplicó como sugerencias los cambios 3, 5 (dos), 8, 9.a y 9.b. Lo que sigue corrige las diferencias que encontró entre este archivo y la estructura real del Doc. Las reglas de arriba siguen valiendo.

## A. Cambios de tabla, para hacer a mano en Google Docs (el conector no inserta filas)

**A1. Arquitectura 6.2** (columnas: Dato, Se genera en, Adónde llega, Sensibilidad). Editar la fila existente y agregar una debajo:

| Dato | Se genera en | Adónde llega | Sensibilidad |
| --- | --- | --- | --- |
| Datos biométricos | No aplica | No se procesan en el MVP. | Futuras versiones |
| Ubicación del celular del paciente (última posición y ubicación de las alertas de ayuda y de salida de zona) | Celular del paciente (Aurora Care) | Aurora Core / Supabase. Solo con consentimiento propio, que se puede retirar. | Alta (dato sensible) |

**A2. Arquitectura 6.3** (el Doc tiene tres columnas: tipo de dato, período, justificación; lo que ocurre «al vencer» va dentro de la justificación). Pasar la fila a tres:

| Tipo de dato | Período | Justificación |
| --- | --- | --- |
| Datos biométricos | (Futuras versiones) | No se tratan en el MVP. Si se incorporan: plazos cortos y justificación propia (90 días como punto de partida). |
| Ubicación del celular del paciente: última posición | Mientras el consentimiento esté vigente | Solo se guarda la última posición, que reemplaza a la anterior: no hay historial de recorridos. Permite al cuidador ver dónde está el paciente y avisar la salida de una zona segura. Al vencer: se elimina al retirar el consentimiento o al desvincular el celular. |
| Ubicación asociada a una alerta (pedido de ayuda o salida de zona) | 7 días | Permite al cuidador saber dónde estaba el paciente cuando ocurrió el evento. Pasado el plazo no se justifica conservarla. Al vencer: se borra el lugar y la alerta queda marcada como depurada. [A CONFIRMAR: depuración diaria automática programada (AURA-213)] |

**A3. Clasificación de eventos, fila Alta:** la celda `Futuras versiones` pasa a `Extensión con prototipo funcional (celular del paciente)`.

**A4. Alcance del sistema, párrafo «Alcance del MVP:»:** agregar al final:
`Extensión con prototipo funcional: botón «Necesito ayuda», ubicación en vivo del celular del paciente y aviso de salida de zona segura, con consentimiento propio y límites explícitos (ver Plan de Testing).`

**A5. «Alcance del MVP vigente» no existe en el Doc.** No crear una tabla nueva. Agregar la misma frase de A4, abreviada, en la **«Matriz de Alcance del MVP y Futuras Versiones»**, en la celda de la fila MVP de la columna «Monitoreo, Historial y Alertas»:
`Ubicación en vivo del celular del paciente, botón de ayuda y aviso de salida de zona segura (extensión con prototipo funcional; consentimiento propio y límites explícitos).`

## B. Textos que no coincidían: propuesta (confirmar con el equipo antes de aplicar)

Para cada uno el agente tiene que ubicar la frase exacta en el Doc y cambiar **solo las palabras indicadas**.

| Dónde | Hoy dice | Propuesta |
| --- | --- | --- |
| Matriz del User Story Mapping, columna «Monitoreo, Historial y Alertas», celda de **Futuras versiones** | `Delimitar perímetros virtuales en un mapa para gestionar zonas seguras (Geofencing).` | `Detectar la salida del paciente de las zonas seguras a partir de un dispositivo wearable (Aurora Band) y notificar al cuidador.` Antes de cambiar, confirmar en qué celda está la frase. Si está en la de MVP (la configuración de zonas es MVP parcial desde el 12/10), **no tocarla** y avisar. |
| Backlog, historia **US F.2 - Alerta temprana de deambulación y anomalías** | `notificación push al salir de la zona segura configurada o ante estrés severo` | `notificación push ante deambulación o estrés severo detectados con un wearable` y agregar al final: `El aviso de salida de zona segura con el celular del paciente se ofrece como extensión con prototipo funcional.` Mantener `Requiere validación de umbrales por un profesional`. |
| Estudio Inicial, Alcance del sistema | `Futuras versiones: monitoreo biométrico y de ubicación, … zonas seguras` | Quitar `y de ubicación` y quitar `zonas seguras` de esa lista. El resto de la frase queda igual. |
| Arquitectura, introducción de la sección 6 | `los datos biométricos y de ubicación quedan para futuras versiones` | `los datos biométricos quedan para futuras versiones; la ubicación del celular del paciente se trata solo con consentimiento propio (extensión con prototipo funcional)` |
| Glosario, **Evento** | Dice que la detección de salidas de zona segura es de futuras versiones | Cambiar solo esa mención por `extensión con prototipo funcional (celular del paciente)`. |

## C. A revisar a mano al aceptar las sugerencias

- En el ítem de biometría del Estudio Inicial, el paréntesis `(frecuencia cardíaca, movimiento, temperatura,` puede haber quedado en negrita. Corregirlo si es así.
