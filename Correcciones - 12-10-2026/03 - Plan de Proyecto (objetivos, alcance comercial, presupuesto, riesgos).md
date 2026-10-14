# Correcciones 5, 6, 7 y 8 — Plan de Proyecto

> **Qué cambia en el Docs:** cuatro bloques del *Plan de Proyecto Aurora*:
>
> | Corrección | Sección del Docs | Acción |
> | --- | --- | --- |
> | 5 | **3. Objetivos y Criterios de Éxito** | Reemplazar la tabla completa |
> | 6 | **2.3 Estrategia de Monetización**, **6.5**, **8. Interesados Clave** y **4.3 Fuera de Alcance** | Reemplazar 2.3, ajustar filas de 8, agregar viñeta a 4.3 |
> | 7 | **6.1 Presupuesto de Desarrollo (CAPEX)**, párrafo de la Etapa 1 en **6.3** y **7.3 Restricción Presupuestaria** | Reemplazar tabla y textos |
> | 8 | **7. Riesgos, Supuestos y Restricciones** | Reemplazar 7.1, ajustar 7.2 y 7.3 |
>
> Texto marcado `[A COMPLETAR]`: dato que no está en los repos. Las **metas numéricas** de la corrección 5 son una **propuesta**: el equipo tiene que aprobarlas o ajustarlas antes de subirlas, porque quedan como compromiso ante la cátedra.

---

## 1. Corrección 5 — Objetivos y criterios de éxito (reemplaza la sección 3)

### 3. Objetivos y Criterios de Éxito

Los objetivos se separan en dos grupos: los del **producto** (qué problema resuelve Aurora y cómo se mide) y los del **equipo académico** (qué necesita el equipo para cerrar el Proyecto Final). Solo los primeros son criterios de éxito del producto.

#### 3.1 Objetivos del producto (SMART)

| Objetivo | Indicador | Meta | Cómo se mide | Alcance |
| :---- | :---- | :---- | :---- | :---- |
| **O1. Que el paciente reciba y responda sus recordatorios** | Tasa de recordatorios con respuesta registrada (cumplido, rechazado o pospuesto) sobre los emitidos | ≥ 80 % durante el piloto | Registro de interacciones en Aurora Core. Se excluyen los horarios en que el cuidador marcó al paciente como ausente | MVP |
| **O2. Que las alertas sean confiables** | Tasa de falsos negativos: omisiones críticas de medicación sin alerta | 0 en los escenarios de prueba (100 % de omisiones simuladas generan alerta) | Pruebas E2E con escenarios de omisión (ver Plan de Testing) | MVP |
| | Tasa de falsos positivos: alertas por omisión cuando el cuidador informa que sí se cumplió | ≤ 10 % de las alertas del piloto | Marca "falsa alerta" en Aurora Care y encuesta al cuidador | MVP |
| **O3. Que el cuidador sea notificado a tiempo** | Tiempo entre la detección de la omisión y la entrega de la notificación push | p95 ≤ 30 segundos | Marcas de tiempo del evento y del recibo de entrega de la notificación | MVP |
| **O4. Que la interacción por voz sea fluida** | Tiempo de síntesis de voz de un recordatorio | < 2 segundos | Instrumentación de latencia en Aurora Home | MVP |
| **O5. Que el sistema sea fácil de usar** | Puntaje SUS (System Usability Scale) del cuidador | ≥ 68 (promedio de referencia) | Cuestionario SUS al finalizar el piloto | MVP |
| | Tarea de configuración inicial (alta de paciente, una rutina y una medicación) sin ayuda | ≥ 80 % de los cuidadores en ≤ 10 minutos | Observación de sesiones de prueba | MVP |
| **O6. Que el paciente y el cuidador lo acepten** | Cuidadores que continúan usando el sistema hasta el final del piloto | ≥ 70 % | Registro de uso y entrevista de cierre | MVP |
| | Sesiones de actividad que el paciente completa sin abandonar | ≥ 70 % | Registro de sesiones de actividad | MVP |
| **O7. Que las funciones críticas estén disponibles** | Disponibilidad de recordatorios y alertas | ≥ 99 % durante el piloto, incluido el funcionamiento degradado sin internet | Monitoreo de salud de los servicios y de Aurora Home | MVP |

**Satisfacción de usuarios.** El criterio anterior ("10 usuarios satisfechos") se reemplaza por una medición objetiva: se considera *satisfecho* al cuidador que, en el cuestionario de cierre, califique con **4 o más sobre 5** la utilidad general y obtenga un **SUS ≥ 68**. Meta: al menos **70 % de los usuarios del piloto** (`[A COMPLETAR: cantidad real de usuarios piloto]`).

> **Referencia a futuras versiones:** los indicadores de falsos positivos y negativos en detección de caídas, agitación y anomalías biométricas se definirán cuando esas funciones entren al alcance.

#### 3.2 Objetivos del equipo académico (no son criterios de éxito del producto)

| Objetivo | Criterio |
| :---- | :---- |
| **Aprobar y regularizar el Proyecto Final** | Alcanzar el puntaje requerido por la cátedra y defender el trabajo en la fecha de entrega (05/11/2026) |
| **Entregar documentación consistente y trazable** | Requisitos, riesgos, pruebas y arquitectura coherentes entre sí (checklist de consistencia al cierre) |

*(Se elimina el objetivo "Ser la mejor tesis del año".)*

---

## 2. Corrección 6 — Alcance comercial vs. alcance del proyecto (MVP)

### Texto para la sección 2.3 (reemplaza completa)

#### 2.3 Estrategia de Monetización (visión comercial)

> **Esta sección describe la visión comercial de largo plazo. Está fuera del alcance del proyecto y del MVP.** El alcance actual es el que define el Estudio Inicial: hogares particulares, un paciente por hogar, sin instituciones ni entornos con múltiples pacientes.

* **Modelo particular (B2C), línea de negocio inicial y única contemplada en el MVP:** familias con un paciente en el hogar.
  * *Venta de hardware (pago único):* el dispositivo Aurora Home (gabinete, Raspberry Pi, micrófonos y parlante).
  * *Suscripción mensual (SaaS):* acceso a Aurora Care, procesamiento en la nube y consumo de modelos de lenguaje.
* **Evolución futura (no forma parte del proyecto):**
  * *Modelo institucional (B2B):* centros de salud y geriátricos. Requeriría **soportar múltiples pacientes por cuenta, roles institucionales y un panel profesional**, que hoy están explícitamente excluidos.
  * *Modelo gubernamental (B2G):* programas de asistencia social. Requeriría, además, certificaciones y cumplimiento normativo que el proyecto no contempla.

Para habilitar B2B o B2G habría que revisar antes el alcance, el modelo de datos (un paciente por cuenta DOT) y el marco regulatorio.

### Cambios puntuales

| Ubicación | Hoy dice | Cambiar por |
| ----- | ----- | ----- |
| **6.5 Estrategias de Monetización** | Ya se limita a B2C | Agregar al final: "Los modelos B2B y B2G se describen como visión futura en 2.3 y no forman parte del alcance." |
| **8. Interesados Clave** → fila *Centros de Salud y Geriátricos* | "Clientes corporativos (B2B). Medio…" | Cambiar el rol a **"Interesado futuro (fuera del alcance actual)"** y la expectativa a "Potenciales clientes en una etapa comercial posterior". |
| **8. Interesados Clave** → fila *Ministerios / Entes de Gobierno* | Ídem (B2G) | Ídem. |
| **8. Interesados Clave** → agregar fila | — | **Profesionales de la salud validadores** (Lic. V. Salvador y profesionales de neurología): validan el enfoque terapéutico y los estadios cubiertos. Impacto: Alto. |
| **4.3 Fuera de Alcance** → viñeta 1 | "Entornos físicos multifamiliares o institucionales masivos…" | Agregar: "Esto incluye geriátricos, clínicas y programas gubernamentales: se mencionan solo como visión comercial futura (ver 2.3)." |

---

## 3. Corrección 7 — Presupuesto: estimado vs. real vs. pendiente

### Qué estaba mal

* La tabla de CAPEX original suma **$510.000 ARS** (150.000 + 70.000 + 30.000 + 50.000 + 50.000 + 100.000 + 60.000), pero el texto decía **$410.000** y "cumple holgadamente" el tope de $500.000. El total no coincidía con las filas.
* Las compras reales de Aurora Home ya suman **$502.283,45**, es decir, **superan el tope de $500.000 solo con el hardware**, todavía sin contar infraestructura y servicios.
* La Raspberry Pi comprada es una **Raspberry Pi 5 de 8 GB**, no la Pi 4 de la tabla, y venía en un kit que incluye varios ítems que la tabla original listaba aparte.
* La pulsera (Aurora Band) quedó **fuera del MVP** (decisión del 29/08/2026 por restricción presupuestaria) y no se compró.

### Texto para 6.1 (reemplaza la tabla y el párrafo del total)

#### 6.1 Presupuesto de Desarrollo (CAPEX), estado al 12/10/2026

Este presupuesto contempla los gastos de los 6 meses de desarrollo (mayo a noviembre de 2026) y se actualiza con los costos reales. Se presentan: **estimado inicial** (Acta de Constitución, 05/05/2026), **real** (comprado) y **pendiente**. Los importes en dólares se convirtieron a pesos al tipo de cambio de la compra (≈ $1.533 por USD).

| Categoría | Componente | Estimado inicial | Real (comprado) | Pendiente | Estado |
| :---- | :---- | :---: | :---: | :---: | :---- |
| **Hardware Aurora Home** | Kit Raspberry Pi 5 de 8 GB (placa, microSD de 64 GB, 2 lectores de tarjeta, disipador activo, gabinete, 2 cables micro-HDMI a 4K y fuente GaN USB-C de 27 W) — USD 257 | $150.000 (Pi 4) + $50.000 (fuente y microSD) = $200.000 | **$393.988,45** | $0 | Comprado |
| | ReSpeaker 2-Mics Pi HAT v2.0 y parlante Seeed Studio 4 Ω 5 W (se compraron juntos) | $100.000 ($70.000 + $30.000) | **$66.640,00** | $0 | Comprado |
| | Cable plano IDE 40 pines hembra a macho, 9,5 cm | — (no estaba previsto) | **$20.655,00** | $0 | Comprado |
| | Gabinete impreso en 3D | $50.000 | **$21.000,00** | $0 | Impreso |
| **Wearable** | Pulsera AmazFit Bip 5 o similar | $100.000 | $0 | **$0** | **Descartada**: Aurora Band queda fuera del MVP |
| **Infraestructura** | VPS Hostinger, dominio, y servicios en la nube (voz e IA), 6 meses | $60.000 | `[A COMPLETAR]` | `[A COMPLETAR]` | `[A COMPLETAR]` |
| **Subtotal hardware de Aurora Home (conocido)** | | **$350.000** (sin pulsera ni infraestructura) | **$502.283,45** | | |
| **Mano de obra** | Valorización simbólica (2.016 h ad honorem) | $8.064.000 | No se desembolsa | No se desembolsa | Aporte del equipo |

| Indicador | Valor |
| :---- | :---- |
| Tope de la restricción presupuestaria | $500.000 |
| Gasto real conocido (solo hardware de Aurora Home) | $502.283,45 |
| **Desvío ya confirmado sobre el tope** | **+$2.283,45 (+0,46 %)** |
| Gastos aún sin sumar | Infraestructura y servicios en la nube (VPS, dominio, voz e IA) |

> **El tope de $500.000 ya está superado con el hardware solo**, y todavía falta sumar infraestructura y servicios. El texto anterior ("cumple holgadamente") se elimina. El desvío se registra como riesgo R13 con su plan de contención.

**Análisis del desvío.** La diferencia principal está en la Raspberry Pi: la estimación original era de $200.000 para placa, fuente y microSD (Pi 4), y el kit de Pi 5 de 8 GB costó $393.988,45. Se compensa en parte porque el módulo de audio con el parlante costó $66.640 en lugar de $100.000, el gabinete impreso costó $21.000 en lugar de $50.000 y no se compró la pulsera ($100.000). Como la placa se pagó en dólares, el costo en pesos depende del tipo de cambio.

**Plan de contención:** (a) la pulsera queda descartada; (b) no se compran más componentes de hardware; (c) infraestructura: `[A COMPLETAR: usar los planes gratuitos o mínimos que ya están en uso]`; (d) se informa a la cátedra del desvío y se solicita la ratificación del tope o su ajuste, con este detalle como respaldo.

> **Conciliación con el comentario anterior:** el comentario de Octavio del 25/08 informaba **$462.512** gastados. Era un total **parcial a esa fecha**; el total actualizado de las compras de esta tabla es **$502.283,45**. Ese comentario del Doc se puede resolver al subir esta tabla.

### Cambios relacionados

| Ubicación | Cambio |
| ----- | ----- |
| **6.3 → Etapa 1** (párrafo "El presupuesto estimado a desembolsar… $410.000") | Reemplazar por: "El presupuesto estimado inicial era de $510.000 ARS sin mano de obra. Al 12/10/2026 el hardware de Aurora Home ya suma $502.283,45 (ver 6.1)." |
| **7.3 → Restricción Presupuestaria** | Agregar: "Estado al 12/10/2026: el hardware de Aurora Home supera el tope en $2.283,45. Ver 6.1 y riesgo R13." |
| **6.2 OPEX** → fila *Consumo de IA* | Reemplazar "Llama 3 8B vía Groq a $0,10 el millón de tokens" por el proveedor vigente (`gpt-4o-mini` por defecto, con Gemini como alternativa configurable) y **recalcular** con su tarifa actual `[A COMPLETAR]`. |
| **6.2 OPEX** → agregar fila | **Servicios de voz en la nube** (Azure Speech: reconocimiento y síntesis). Hoy se usa el nivel gratuito (F0) con cuota de 500.000 caracteres mensuales para la síntesis; en producción habría que presupuestar el nivel pago. Costo `[A COMPLETAR]`. |
| **6.2 OPEX** → fila *Infraestructura de Backend* | Ya coincide con el VPS Hostinger. Quitar "Node.js/Python" y dejar "Python/Django". |
| **6.2 OPEX** → nota estratégica y **6.6** (último párrafo) | La afirmación "STT y TTS locales reducen drásticamente el costo y evitan enviar audio a servicios externos" **ya no describe el sistema** (Azure es el proveedor principal, con respaldo local). Reescribir: "La voz se procesa primero en la nube con respaldo local; el costo de los servicios de voz se incluye en el OPEX." Ver archivo 06. |

---

## 4. Corrección 8 — Riesgos (reemplaza 7.1 y ajusta 7.2 y 7.3)

### 7.1 Riesgos Principales (Amenazas)

Los riesgos se ordenan por **exposición** (probabilidad × impacto). En este proyecto una falla no es solo un defecto funcional: una alerta que no llega o una respuesta incorrecta del asistente puede influir en la conducta de un paciente o en la reacción de un cuidador ante una situación potencialmente crítica. Por eso los riesgos de **seguridad del paciente** se tratan como prioritarios (P1).

#### Riesgos prioritarios de seguridad y confiabilidad

| ID | Riesgo | Prob. | Impacto | Estrategia de mitigación |
| :---- | :---- | :---- | :---- | :---- |
| **R8** | **Falsos negativos en alertas críticas:** una omisión de medicación o rutina crítica no genera alerta, o la alerta no llega al cuidador. | Media | **Muy alto** | Evitar/Mitigar: pruebas E2E con escenarios de omisión (meta 0 falsos negativos); verificación del recibo de entrega de la notificación push; reintentos; avisar a más de un cuidador asociado; indicar en Aurora Care el estado de conexión de Aurora Home para que el cuidador sepa si el dispositivo está desconectado. |
| **R9** | **Falsos positivos en alertas:** alertas sin motivo que provocan fatiga del cuidador y lo llevan a ignorarlas. | Media | Alto | Mitigar: margen de omisión configurable por el cuidador (regla de negocio 7); evitar duplicados (RNF-16); medir la tasa de falsos positivos en el piloto (meta ≤ 10 %); permitir marcar "falsa alerta". |
| **R10** | **Indisponibilidad de conectividad o de servicios en la nube** (internet del hogar, VPS, base de datos, proveedores de IA o de voz). | Alta | Alto | Mitigar: modo offline y operación degradada en Aurora Home (base local, cola de eventos pendientes, voz local de respaldo); sincronización al recuperar conexión; monitoreo de salud de los servicios; comunicar al cuidador que el dispositivo no reporta. |
| **R11** | **Errores o alucinaciones de la IA** en la interacción con el paciente: datos personales inventados, indicaciones médicas, respuestas fuera de contexto. | Media | **Muy alto** | Mitigar: reglas duras en los prompts (usar solo la memoria provista y validada por el cuidador; nunca diagnosticar ni indicar medicación); respuestas breves; derivar al cuidador ante dudas; evaluación de IA con casos adversarios (ver Plan de Testing); registro auditable de las respuestas (RNF-24). Ver también el archivo de dominio clínico. |
| **R5** | **Filtración o vulnerabilidad de datos sensibles** (personales, médicos, de voz). | Baja | Muy alto | Mitigar: cifrado de los campos identificatorios en la aplicación; TLS; registro de consentimiento; política de retención verificable (ver archivo 07); revisión de qué datos salen del hogar hacia proveedores externos. |
| **R12** | **Fallas en datos biométricos o de ubicación.** | Baja en el MVP | Alto | **Diferido:** la integración biométrica está fuera del MVP. Si se retoma, exigir validación de umbrales con profesionales y definir antes los criterios de falsos positivos y negativos. |

#### Riesgos de gestión, costo y entorno

| ID | Riesgo | Prob. | Impacto | Estrategia de mitigación |
| :---- | :---- | :---- | :---- | :---- |
| **R13** | **Desvío presupuestario:** el gasto real ya supera el tope de $500.000 solo con el hardware, sin contar infraestructura. | **Materializado** ($502.283,45 al 12/10/2026) | Alto | Mitigar: pulsera descartada; no comprar más hardware; usar planes gratuitos o mínimos de infraestructura; informar a la cátedra y solicitar ratificación del tope. Ver 6.1. |
| **R1** | Falta de información médica útil para las terapias. | Media → **Baja** | Alto | Mitigar: validación realizada con una psicopedagoga y con profesionales de neurología (ver archivo 02). Pendiente: formalizar fechas y alcance de la validación. |
| **R2** | Pulsera biométrica no disponible o inadecuada. | **Materializado** | Medio | **Aceptado:** Aurora Band queda fuera del MVP (decisión del 29/08/2026). No se compra hardware ni se integra la API. Se conserva la visión y el código inerte. |
| **R3** | Incremento de los costos de IA y de voz. | Media | Medio | Mitigar: proveedor de IA configurable por variable de entorno (sin cambiar código); límites de longitud de respuesta; alertas de facturación. |
| **R4** | Rechazo o baja adopción por parte del paciente. | Alta | Alto | Mitigar: interfaz de voz simple, pautas de la psicopedagoga (anticipar y sostener rutina); pruebas con usuarios. |
| **R6** | Abastecimiento de hardware en Argentina. | Media → **Baja** | Alto | Mitigado: la Raspberry Pi 5, el módulo de audio con el parlante, el cable y el gabinete ya fueron comprados. |
| **R7** | Sobrecarga o deserción del equipo. | Media | Alto | Mitigar: revisar la capacidad cada 3 semanas en la Sprint Planning; recortar alcance del MVP. |
| **R14** | **Dependencia de proveedores externos con datos del paciente** (voz y texto de las conversaciones hacia el proveedor de voz y de IA). | Media | Alto | Mitigar: informar en el consentimiento; enviar solo durante las ventanas de interacción; respaldo local sin conexión; documentar la región y la transferencia internacional; pasar al nivel de servicio pago; **corregir la credencial de Azure, que hoy está en el archivo de entorno de la Raspberry Pi** (emitir tokens de corta duración desde Core). Ver archivo 07, sección 8. |

### 7.2 Supuestos del Proyecto (ajustes)

| Supuesto | Cambio |
| ----- | ----- |
| Disponibilidad de APIs: "modelos de Gemini y Claude" | Reemplazar por "los proveedores de modelos de lenguaje y de voz en uso (hoy OpenAI y Azure, con Gemini como alternativa configurable)". |
| Acceso a datos de Hardware Tercerizado (pulsera) | **Eliminar del MVP.** Mover a "Supuestos de futuras versiones". |
| Validación de Profesionales | Reemplazar por el estado real: "El equipo recibió validación de una psicopedagoga y de profesionales de neurología (ver archivo 02)." |

### 7.3 Restricciones (ajustes)

| Restricción | Cambio |
| ----- | ----- |
| Presupuestaria | Agregar el estado al 12/10/2026 (ver 6.1). |
| Hardware (Alcance) | Reemplazar "El dispositivo Aurora Band no será modificado…" por "No se desarrolla ni se integra hardware vestible en el MVP." |
| Entorno y Perfil | Reemplazar "nivel 5 de autonomía" por "FAST igual o inferior a 5". |
