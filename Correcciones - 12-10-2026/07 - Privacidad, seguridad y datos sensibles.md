# Corrección 12 — Privacidad, seguridad y datos sensibles como requisitos verificables

> **Criterio de la profe:** las políticas de retención, cifrado, consentimiento, anonimización y derechos sobre los datos deben ser **requisitos funcionales / no funcionales verificables** y no solo recomendaciones de arquitectura. Hay que **justificar cada período de retención** y definir **quién otorga y revoca el consentimiento, cómo se registra, qué pasa al revocarlo y qué se elimina o conserva**.
>
> **Qué cambia en el Docs:**
>
> | Sección del Docs | Acción |
> | --- | --- |
> | Estudio Inicial → Requerimientos Funcionales / No Funcionales | **Agregar** los requisitos nuevos de la sección 2 y 3 de este archivo |
> | Arquitectura → **6.1 a 6.3** | **Reemplazar** por las secciones 1, 4 y 5 de este archivo (sigue como "Consideraciones de Privacidad…" pero con requisitos trazables) |
> | Arquitectura → 6.2 (tabla de retención) | **Reemplazar** por la tabla de la sección 4 |
> | Requerimientos (repo) | Agregar RF-92 a RF-98 y RNF-44 a RNF-52 |
>
> ⚠️ **Actualización (12/10/2026): el análisis legal completo está en el archivo 09**, que corrige varios puntos de este archivo: los plazos de respuesta a derechos (10 días corridos y 5 días hábiles), quién puede consentir por un paciente con deterioro cognitivo (un familiar sin designación judicial **no** tiene representación; ver las situaciones A, B y C del archivo 09) y la necesidad de tres consentimientos separados.
>
> ⚠️ **Todo lo legal (plazos, quién puede consentir por un paciente con deterioro cognitivo) lo redacté como propuesta técnica. Deben validarlo con la cátedra o un asesor legal antes de presentarlo como definitivo.** Los números de artículos de la Ley 25.326 conviene verificarlos contra el texto oficial.

---

## 1. Qué datos trata Aurora y adónde van

Antes de fijar plazos hay que saber por dónde circulan los datos. Con la arquitectura vigente (archivo 06):

| Dato | Se genera en | Adónde llega | Sensibilidad |
| ----- | ----- | ----- | ----- |
| Voz del paciente (audio) | Aurora Home | Azure Speech (reconocimiento en tiempo real) **solo durante las ventanas de escucha** abiertas por un recordatorio o una actividad; nunca de forma ambiental ni continua. Sin conexión: Whisper.cpp local | Alta (dato de salud) |
| Texto de lo que dice el paciente y lo que responde Aurora | Aurora Home / Core | Aurora Core; Worker IA y su proveedor de modelos de lenguaje (OpenAI, Gemini); Azure para la síntesis de voz. La clasificación de si el paciente confirmó un recordatorio la hace un modelo **local** en Aurora Home | Alta |
| Datos identificatorios (nombre, DNI, contactos de emergencia) | Aurora Care | Aurora Core / Supabase, **cifrados en la aplicación** | Alta |
| Medicación, rutinas, recuerdos personales | Aurora Care | Aurora Core / Supabase | Alta (dato de salud) |
| Respuestas del paciente a recordatorios; eventos y alertas | Aurora Home / Core | Aurora Core / Supabase | Alta |
| Datos biométricos y de ubicación | — | **No se procesan en el MVP** | (Futuras versiones) |

> **Hallazgo que hay que explicitar:** hoy **el audio del paciente (durante las ventanas de escucha) y el texto de la conversación salen del hogar** hacia proveedores externos (voz e IA). El documento anterior decía que el audio crudo no salía de la Raspberry Pi y que el STT era local. Eso ya no es cierto: se cambió por una decisión consciente y documentada (ADR-HOME-010 y ADR-HOME-011), que se explica y se justifica en la sección 8. El consentimiento debe informarlo con claridad (RF-95).

---

## 2. Requisitos funcionales nuevos (verificables)

Se agregan al módulo **Seguridad, Privacidad y Cumplimiento** (RF-76 a RF-81 existentes).

| ID | Requisito | Criterio de aceptación verificable | Cómo se verifica | Alcance |
| ----- | ----- | ----- | ----- | ----- |
| **RF-92** | Registrar el consentimiento informado antes de tratar datos del paciente, con tipo, versión de la política, alcance, fecha de aceptación y quién lo registró. | No se puede completar el alta del paciente sin un consentimiento vigente. Repetir la aceptación de la misma versión no duplica el registro. Una versión nueva de la política exige una nueva aceptación. | Pruebas de API y de la pantalla de alta | MVP |
| **RF-93** | Permitir revocar el consentimiento en cualquier momento desde Aurora Care. | Al revocar, el registro queda con fecha de revocación y estado "revocado", y se ejecutan los efectos de la sección 5 en el plazo definido. | Prueba E2E de revocación | MVP |
| **RF-94** | Atender solicitudes del titular o su representante: acceso (exportar), rectificación y supresión. | Cada solicitud queda registrada con tipo, estado (solicitada, en proceso, completada, rechazada) y responsable. La exportación incluye todos los datos del paciente. | Pruebas de API de solicitudes de datos | MVP |
| **RF-95** | Informar al cuidador, en el consentimiento, qué datos salen del hogar y a qué proveedores. | El texto del consentimiento lista la voz, el texto de las conversaciones y los proveedores de voz e IA. | Revisión del texto y prueba de pantalla | MVP |
| **RF-96** | Depurar automáticamente los datos que superaron su plazo de retención. | Un proceso programado elimina o anonimiza los registros vencidos y deja constancia de la depuración. Ningún registro excede su plazo en más de un día. | Prueba con datos de fecha simulada | MVP |
| **RF-97** | Registrar el acceso a los datos del paciente (quién, qué, cuándo, motivo). | Toda lectura de datos sensibles por un cuidador genera una entrada en el registro de accesos, que el cuidador principal puede consultar. | Pruebas de API | MVP |
| **RF-98** | No incluir datos personales en el texto visible de las notificaciones. | Una notificación push muestra un mensaje genérico (por ejemplo, "Hay una novedad en Aurora"); el detalle se ve dentro de la aplicación autenticada. | Prueba de contenido de notificaciones | MVP |

*(RF-79 "Cifrar datos sensibles almacenados" y RF-80 "Cifrar comunicaciones" ya existen; se vuelven verificables con los RNF de abajo.)*

---

## 3. Requisitos no funcionales nuevos (verificables)

Se suman a los RNF-34 a RNF-38 existentes.

| ID | Requisito | Criterio medible | Cómo se verifica |
| ----- | ----- | ----- | ----- |
| **RNF-44** | Cifrado en reposo de datos identificatorios. | El 100 % de los campos identificatorios (nombre, DNI, contactos de emergencia) se almacena cifrado (Fernet, ADR-010). Una consulta directa a la base no devuelve texto plano. | Prueba automática sobre la base |
| **RNF-45** | Cifrado en tránsito. | Todas las comunicaciones externas usan TLS 1.2 o superior. Los endpoints rechazan HTTP plano. | Escaneo de configuración y prueba de integración |
| **RNF-46** | Rotación de claves de cifrado. | Existe un procedimiento documentado y probado para rotar la clave sin migraciones masivas. | Prueba de rotación |
| **RNF-47** | Separación de entornos y datos. | Los datos reales de pacientes **no** se usan en desarrollo ni en staging. Staging usa datos sintéticos. | Revisión de configuración y de semillas |
| **RNF-48** | Minimización en Aurora Home. | Aurora Home no almacena audio más allá de un buffer circular de 5 minutos. | Prueba en dispositivo |
| **RNF-49** | Tiempo de atención de derechos. | Las solicitudes de acceso, rectificación y supresión se resuelven en el plazo que fije la política (**plazos legales: acceso, 10 días corridos; rectificación, actualización o supresión, 5 días hábiles**; Ley 25.326, arts. 14 y 16). | Registro de solicitudes |
| **RNF-51** | Los proveedores de voz e IA no conservan el audio ni el texto. | La configuración de cada proveedor se verifica con una lista de control (registro de solicitudes desactivado, sin endpoints personalizados con registro, nivel de servicio con términos de protección de datos). Se revisa en cada cambio de proveedor o de configuración. | Revisión documentada de la configuración |
| **RNF-52** | La credencial del proveedor de voz no queda expuesta en los dispositivos. | La credencial no se comparte en texto plano entre dispositivos: se emiten tokens de corta duración desde Aurora Core o credenciales revocables por dispositivo. **Estado actual: no cumple** (la clave está en el archivo de entorno de la Raspberry Pi). | Revisión de configuración; prueba de rotación `[PENDIENTE]` |
| **RNF-50** | Anonimización para mejora de modelos. | Ningún dato de pacientes se usa para entrenar o ajustar modelos sin consentimiento específico y sin eliminar identificadores directos y cuasi-identificadores. Por defecto, **no se usa**. | Revisión del flujo de datos y de contratos con los proveedores |

---

## 4. Política de retención con justificación (reemplaza la tabla 6.2)

**Principio:** la Ley 25.326 establece que los datos no deben conservarse más tiempo del necesario para la finalidad con que se recolectaron (calidad de los datos). Cada plazo se justifica por una finalidad concreta. Los plazos son una **propuesta del equipo**.

| Tipo de dato | Plazo propuesto | Justificación | Qué ocurre al vencer |
| ----- | ----- | ----- | ----- |
| Audio crudo del paciente | **No se almacena** (buffer circular de 5 minutos en el dispositivo) | Solo se necesita para transcribir en el momento. Guardarlo no aporta a ninguna función del MVP. | Se sobrescribe |
| Transcripciones de interacciones | **6 meses** | Permite al cuidador revisar el historial reciente y auditar las respuestas de la IA (RNF-24). Cubre un ciclo habitual de seguimiento con el profesional. | Se anonimiza o elimina |
| Respuestas a recordatorios, eventos y alertas | **2 años** | Es la base del historial de cumplimiento que el cuidador lleva a la consulta, y la evidencia de qué ocurrió y cómo se actuó. Más de 2 años no se justifica para el MVP. | Se elimina; el resumen estadístico anonimizado puede conservarse |
| Rutinas, medicación y recuerdos del paciente | **Mientras dure la relación + 90 días** | Son necesarios para prestar el servicio. Los 90 días posteriores permiten exportar los datos o revertir una baja por error. *(El borrador anterior decía + 1 año; no se justificaba para dato de salud.)* | Se elimina |
| Datos identificatorios del paciente | **Mientras dure la relación + 90 días** | Ídem anterior. | Se elimina |
| Cuenta del cuidador | **Mientras dure la relación + 90 días** | Ídem. *(El borrador anterior decía + 2 años por "motivos contables", que no aplican a un piloto sin facturación.)* | Se elimina |
| **Registro de consentimientos y revocaciones** | **Mientras dure la relación + 5 años** | Es la prueba de que el tratamiento fue autorizado y de cuándo dejó de estarlo. Se conserva por la prescripción general de reclamos. Es el único dato que **sobrevive** a la baja. | Se elimina |
| **Registro de accesos y de solicitudes de derechos** | **2 años** | Auditoría de quién accedió a datos sensibles. | Se elimina |
| Datos biométricos y de ubicación | **(Futuras versiones)** | No se tratan en el MVP. Si se incorporan: plazos cortos y justificación propia (biometría 90 días, ubicación 7 días como punto de partida) | — |

> **Estado de la implementación:** el backend tiene el modelo de políticas de retención y el campo de vencimiento en las interacciones, pero **no encontré un proceso automático que depure los datos vencidos**. Eso es lo que verifica RF-96 y es un trabajo pendiente.

---

## 5. Consentimiento: quién, cómo, qué pasa al revocar

### 5.1 Quién lo otorga y quién lo revoca

La Ley 25.326 exige consentimiento **libre, expreso e informado** del titular del dato. En Aurora el titular es una persona con deterioro cognitivo, lo que plantea una cuestión de capacidad. La propuesta es:

| Situación | Quién otorga y revoca | Quién lo registra |
| ----- | ----- | ----- |
| El paciente conserva capacidad para decidir | **El propio paciente**, con ayuda del cuidador principal | El cuidador principal en Aurora Care, dejando constancia de que el titular fue informado |
| Hay una sentencia que restringe su capacidad | **El paciente con su apoyo, o su curador**, según lo que diga la sentencia | El cuidador principal, indicando el vínculo con el paciente |
| Un cuidador de apoyo | **No puede** otorgar ni revocar | — |

Hoy el sistema registra la aceptación desde Aurora Care, a cargo del cuidador que da de alta al paciente. **Falta registrar si el consentimiento lo otorga el paciente o su representante, y el vínculo del representante.** Es un campo nuevo a agregar.

### 5.2 Cómo se registra

Cada consentimiento queda como un registro con: paciente, tipo, **versión de la política aceptada**, alcance, fecha de aceptación según el cliente, fecha de persistencia, **fecha de revocación**, vencimiento y cuidador que lo registró. Repetir la misma aceptación no duplica el registro; una nueva versión de la política requiere una nueva aceptación.

### 5.3 Qué pasa al revocar

| Momento | Efecto |
| ----- | ----- |
| **Inmediato (≤ 24 h)** | Aurora Home deja de capturar y enviar voz. Core deja de procesar datos con IA y de enviar recordatorios. Se suspenden las notificaciones. |
| **Dentro de 90 días** | El cuidador principal puede **exportar** todos los datos del paciente. |
| **A los 90 días** | Se **eliminan** los datos del paciente: identificatorios, medicación, rutinas, recuerdos, transcripciones, respuestas, eventos y alertas. |
| **Se conserva** | El registro de consentimientos y revocaciones (5 años) y el registro de accesos y solicitudes (2 años), **sin los datos del paciente**. |
| **Excepción** | Si una obligación legal exige conservar un dato, se conserva solo ese dato y se documenta el motivo. |

La revocación no afecta la validez del tratamiento realizado antes de revocar.

---

## 6. Trazabilidad de privacidad: requisito → diseño → prueba

| Requisito | Decisión de arquitectura | Prueba |
| ----- | ----- | ----- |
| RF-92 a RF-93 (consentimiento) | Registro de consentimiento versionado en Core | Pruebas de API y E2E de alta y revocación |
| RF-94 (derechos) | Registro de solicitudes de datos | Pruebas de API |
| RF-96 (depuración) | Proceso programado `[PENDIENTE]` | Prueba con fechas simuladas |
| RNF-44, RNF-46 (cifrado) | ADR-010 | Prueba automática sobre la base |
| RNF-45 (tránsito) | TLS en el proxy inverso | Prueba de configuración |
| RF-98 (notificaciones) | Contenido genérico en Expo Push | Prueba de contenido |
| RNF-48 (minimización) | Buffer circular en Aurora Home | Prueba en dispositivo |

Estos requisitos entran al Plan de Testing como casos de **criticidad P1** cuando su falla implique una brecha de seguridad (ver archivo 08).

---

## 7. Pendiente de definición del equipo

1. **Validación legal** del esquema de consentimiento por representante y de los plazos (cátedra o asesor).
2. **Configuración de Azure y de los proveedores de IA:** completar la lista de control de la sección 8.5 (registro desactivado, región, nivel de servicio) y confirmar los términos de los proveedores de IA (OpenAI, Gemini) sobre conservación y entrenamiento, que no están cubiertos por la documentación de Microsoft.
3. **Si el proceso de depuración (RF-96) se desarrolla antes del 05/11** o queda registrado como deuda técnica.
4. **Campo nuevo de consentimiento:** quién consintió (paciente o representante) y vínculo.

---

## 8. Voz en la nube con Azure: por qué se cambió y por qué es defendible

> **Qué cambia en el Docs:** se agrega este apartado como **ADR-011** (ver archivo 06) y se resume en *6.3 Controles de privacidad*. Responde al punto 11 (que el ADR refleje lo que realmente se decidió) y al punto 12 (que se justifique qué datos salen del hogar).

### 8.1 Por qué se migró de Whisper.cpp y Piper a Azure (decisión de calidad, con evidencia)

La decisión original (ADR-006) priorizaba la privacidad: todo el reconocimiento y la síntesis de voz en la Raspberry Pi. En las pruebas con el dispositivo real, esa decisión **no alcanzó el nivel de uso que necesita un paciente con Alzheimer**. La migración no fue una preferencia tecnológica: se decidió con mediciones.

| Función | Problema medido con la solución local | Qué se decidió |
| ----- | ----- | ----- |
| **Síntesis de voz (TTS)** | La única voz argentina disponible en Piper no cumplió la meta de latencia: p95 de 8,02 s contra el objetivo de < 2 s. Además, en la prueba auditiva sonó menos amigable que las alternativas. No existe otra voz argentina local viable | Azure (voces `es-AR`) como principal; Piper queda como respaldo obligatorio sin conexión (ADR-HOME-010) |
| **Reconocimiento de voz (STT)** | El detector de voz casero producía un falso positivo reproducible. En un benchmark con el mismo audio, ni siquiera el modelo `small` de Whisper evitó que el paciente tuviera que acercarse al micrófono y repetir varias veces. La palabra "Aurora" fallaba más que el resto | Azure Speech en modo continuo (streaming) como principal; Whisper.cpp queda como respaldo sin conexión (ADR-HOME-011) |

**Criterio:** un paciente con Alzheimer no puede depender de repetirse cerca de un micrófono para confirmar su medicación. La decisión prioriza que el producto sea usable, y lo hace de forma acotada:

* El audio solo sale del hogar **durante las ventanas de escucha** abiertas por un recordatorio o una actividad. Nunca hay escucha ambiental ni continua.
* La palabra de activación "Aurora" se detecta **localmente**.
* La clasificación de si el paciente confirmó o rechazó un recordatorio la hace un modelo **local**, con una salida limitada a tres valores (confirmo, rechazo, ninguna). Cualquier otra salida se descarta. Un fallo del proveedor nunca se interpreta como confirmación.
* Se descartó entregar la conversación a una plataforma de agente conversacional de terceros, porque delegaba en un modelo ajeno la decisión de si el paciente tomó su medicación, sin auditoría.
* La capacidad sin conexión no se eliminó: Whisper.cpp y Piper siguen siendo el modo degradado.

### 8.2 Qué dice el proveedor (verificado en la documentación oficial de Microsoft)

| Afirmación | Respaldo |
| ----- | ----- |
| En el reconocimiento de voz **en tiempo real**, el audio se procesa solo en la memoria del servidor y no se guarda en disco. Microsoft no retiene ni almacena los datos que envía el cliente | [Data, privacy, and security for Speech to text](https://learn.microsoft.com/en-us/azure/foundry/responsible-ai/speech-service/speech-to-text/data-privacy-security) |
| En la **síntesis de voz en tiempo real** no se conserva el texto enviado ni se guarda el audio generado | [Data, privacy, and security for text to speech](https://learn.microsoft.com/en-us/azure/foundry/responsible-ai/speech-service/text-to-speech/data-privacy-security) |
| Los datos viajan cifrados en tránsito | Misma página de Speech to text |
| Las excepciones al "sin retención" son el registro (*logging*) si se activa, la transcripción por lotes (*batch*) y las voces personalizadas | Documentación de Azure Speech (FAQ) |
| **Microsoft aclara que la responsabilidad legal es de quien implementa**: obtener los permisos necesarios y cumplir las leyes de su jurisdicción. La página no es asesoramiento legal | Misma página de Speech to text |

### 8.3 Cómo se usa la investigación de seguridad del equipo (qué sirve y qué no aplica)

La investigación entregada por el equipo es una buena base, pero hay que ajustar algunas afirmaciones antes de ponerla en el documento:

| Afirmación de la investigación | Evaluación | Qué poner en el documento |
| ----- | ----- | ----- |
| El audio en tiempo real se procesa en memoria y no se guarda | ✅ **Confirmada** por la documentación oficial | Citar la fuente oficial |
| Los datos no se usan para entrenar modelos públicos | ⚠️ **No pude confirmarla en la página oficial consultada** | No afirmarlo hasta verificarlo en los términos de producto de Microsoft `[A VERIFICAR]` |
| Cifrado en tránsito con TLS 1.2 o superior | ✅ Cifrado en tránsito confirmado; la versión de TLS no figura en esa página | Decir "cifrado en tránsito", o verificar la versión |
| Claves administradas por el cliente (CMK) y *private endpoints* | ⚠️ Aplican a funciones por lotes y personalizadas, no al uso en tiempo real. Es un aislamiento mayor al que necesita el MVP | Mencionar como mejora futura, no como parte del diseño actual |
| Contenedores locales de Azure (el audio nunca sale de la infraestructura) | ✅ Existe y está documentado | Presentarlo como **alternativa futura** si se exigiera "cero nube". Hoy el respaldo local ya cumple ese rol sin conexión |
| ISO 27001, SOC 2 y otras certificaciones | ✅ Sirven como respaldo del proveedor | Decirlo como "el proveedor cuenta con certificaciones de seguridad", sin presentarlas como cumplimiento de la Ley 25.326 |
| **HIPAA y GDPR** | ❌ **No aplican a Aurora** (son normas de EE. UU. y de la UE) | No usarlas como argumento de legalidad. El marco que corresponde es la **Ley 25.326** |
| "Usar la región East US para América Latina por ley" | ❌ **No hay una regla legal que lo diga.** La región es una decisión que hay que justificar | Declarar la región realmente configurada `[A COMPLETAR]` y analizar la transferencia internacional (8.4) |
| "Hay que usar un contrato corporativo (Enterprise Agreement)" | ⚠️ Exagerado para este proyecto. Lo relevante es el nivel de servicio y los términos aceptados | Documentar qué suscripción se usa. **Hoy se usa el nivel gratuito (F0)**, que no conviene para pacientes reales `[A VERIFICAR los términos]` |
| Autenticación robusta (Entra ID / roles) | ✅ **Muy relevante**: hoy la clave está en la Raspberry Pi (ver RNF-52) | Incluir como mejora prioritaria |

### 8.4 Transferencia internacional de datos (Ley 25.326)

Al enviar audio y texto a Azure, los datos salen de Argentina. La Ley 25.326 (art. 12) restringe la transferencia de datos personales a países que no ofrezcan un nivel de protección adecuado, con algunas excepciones. Dado que se trata de datos de salud (sensibles), conviene dejar documentado:

1. **Dónde se procesa:** el recurso de Azure está en la región **East US**, es decir, **en Estados Unidos**. La transferencia es, por lo tanto, a un tercer país. Conviene verificar la lista vigente de países con nivel de protección adecuado reconocidos por la autoridad argentina `[VERIFICAR]`, y evaluar si existe una región más cercana con las voces `es-AR` que se usan `[NO VERIFICADO]`.
2. **Con qué base legal se transfiere:** el consentimiento informado y expreso del titular o su representante, que debe listar la voz, el texto y los proveedores (RF-95). Además existen cláusulas contractuales modelo publicadas por la autoridad de aplicación `[VALIDAR CON ASESOR LEGAL si alcanza el consentimiento solo o hace falta el contrato]`.
3. **Qué se hace para minimizar:** escucha acotada a las ventanas de interacción, sin audio ambiental, sin almacenamiento propio del audio, y la clasificación sensible (confirmación de medicación) hecha localmente.

### 8.5 Condiciones para considerar válido el uso de Azure (lista de control de RNF-51)

| # | Condición | Estado |
| --- | ----- | ----- |
| 1 | Registro (*logging*) de solicitudes **desactivado** y sin endpoints personalizados con registro | `[A VERIFICAR]` |
| 2 | Separación de interlocutores (*diarization*) desactivada (viene así por defecto) | `[A VERIFICAR]` |
| 3 | No se usa transcripción por lotes ni voces personalizadas | ✅ El código usa tiempo real |
| 4 | Región documentada y analizada (8.4) | ✅ Documentada (East US). Falta el análisis legal de la transferencia |
| 5 | Nivel de servicio pago antes de usar con pacientes reales (hoy se usa F0) | Pendiente |
| 6 | Credencial no compartida en texto plano entre dispositivos (RNF-52) | **No cumple hoy** |
| 7 | El consentimiento informa de la transferencia (RF-95) | Pendiente de implementar |
| 8 | Existe respaldo local sin conexión | ✅ Whisper.cpp y Piper |

### 8.6 Texto sugerido para el ADR (resumen)

> **ADR-011 — Voz en la nube con respaldo local.** *Contexto:* las pruebas con el dispositivo mostraron que el reconocimiento y la síntesis locales no alcanzan la latencia ni la calidad que necesita un paciente con Alzheimer (p95 de síntesis de 8,02 s frente a una meta de 2 s; el reconocimiento local obligaba al paciente a repetirse). *Decisión:* usar Azure Speech como proveedor principal de reconocimiento y síntesis, acotado a las ventanas de interacción, con Whisper.cpp y Piper como respaldo sin conexión. La clasificación de las respuestas a recordatorios se realiza localmente con salida de vocabulario cerrado. *Consecuencias:* el audio y el texto de las interacciones salen del hogar durante esas ventanas, por lo que se informa en el consentimiento y se documenta la transferencia internacional; el proveedor declara no retener los datos de las llamadas en tiempo real. *Riesgos aceptados:* dependencia de un proveedor externo y de conectividad; nivel gratuito sujeto a cambios; credencial alojada en el dispositivo (a corregir).
