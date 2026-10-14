# Análisis legal y cambios a los textos de privacidad y términos de Aurora Care

> **Pedido:** investigar a fondo las leyes aplicables y determinar si hay que modificar los términos y condiciones que están en Aurora Care.
>
> **Respuesta corta: sí, hay que modificarlos.** El texto actual (*Privacidad MVP v0.1*) se declara a sí mismo un borrador: seis de sus nueve secciones dicen que algo está "pendiente de validación legal", y la pantalla advierte que no debe usarse con pacientes reales hasta validarse. Además, **no existen unos Términos y Condiciones de uso**: solo hay una información de privacidad con un checkbox. Hay varias brechas puntuales respecto de la Ley 25.326 y dos cuestiones de fondo que requieren decisión legal (quién consiente por el paciente y la transferencia a Estados Unidos).
>
> ⚠️ **Esto es una investigación técnica, no asesoramiento legal.** Verifiqué cada norma contra fuentes oficiales (InfoLEG, AAIP) y marco con `[VALIDAR]` lo que depende de interpretación. Antes de usar Aurora con personas reales, el texto final debe revisarlo un abogado o la cátedra. La sección 8 lista las preguntas exactas para llevarle.
>
> **Qué cambia en el repo y en el Docs:** este archivo es nuevo. Complementa el archivo 07 (que corrijo en lo que se contradice, ver sección 9) y se apoya en la investigación previa del vault: *Investigación — Almacenamiento de Datos y Ley 25.326* (19/07/2026).

---

## 1. Qué dice hoy Aurora Care

| Elemento | Estado actual (código de AuroraCare, 12/10/2026) |
| ----- | ----- |
| **Pantalla de privacidad** (`app/privacy.tsx`) | "Información de privacidad", **versión `privacy-mvp-v0.1`**, 9 secciones. Aviso visible: *"Versión informativa del MVP. Su contenido debe validarse legalmente antes de utilizar Aurora con pacientes reales."* |
| **Términos y Condiciones de uso** | **No existen.** No hay pantalla ni aceptación de términos del servicio |
| **Aceptación** | En el alta de cuenta (`create-account.tsx`), un checkbox: *"Leí y acepto el tratamiento de datos descripto en la información de privacidad"*. En el onboarding del paciente se registra el consentimiento con tipo `health_data_processing` |
| **Alcance del consentimiento** (`privacyConsent.ts`) | Tres líneas genéricas: tratamiento de datos sensibles; acceso por cuidadores y "proveedores necesarios"; "transferencias internacionales descriptas" |
| **Evidencia que guarda Core** | Registro por paciente, tipo, versión, alcance, fecha de aceptación según el cliente, fecha de persistencia, revocación y quién lo registró; auditoría de cambios |
| **Lo que NO registra** | Si consintió el paciente o un representante, el vínculo del representante, el texto exacto que se mostró (solo la versión), ni consentimientos separados por finalidad |

**Secciones con "pendiente de validación legal" en el texto actual:** 3 (consentimiento y representación), 4 (accesos y solicitudes), 5 (transferencias), 6 (seguridad: "esta versión no afirma que todas estén implementadas"), 7 (derechos: canal y plazos), 8 (revocación: efectos y retención).

---

## 2. Marco legal aplicable (verificado)

| Norma | Qué exige | Aplica a Aurora | Fuente |
| ----- | ----- | ----- | ----- |
| **Ley 25.326, art. 2** | La información de salud es dato **sensible** | Sí: medicación, diagnóstico, transcripciones que revelan salud | [InfoLEG](https://servicios.infoleg.gob.ar/infolegInternet/anexos/60000-64999/64790/texact.htm) |
| **Art. 5** | Consentimiento **libre, expreso e informado**, por escrito o medio equivalente. Sin él, el tratamiento es ilícito | Sí | Ídem |
| **Art. 6** | Informar **previamente**: finalidad y destinatarios; existencia del archivo y **identidad y domicilio del responsable**; si las respuestas son obligatorias o facultativas; consecuencias de dar datos, negarse o darlos inexactos; derechos de acceso, rectificación y supresión | Sí. **Es donde el texto actual falla más** (sección 3) | Ídem |
| **Art. 7** | Nadie puede ser obligado a dar datos sensibles; se prohíbe formar archivos que revelen datos sensibles salvo excepciones. El decreto reglamentario **no reglamenta** este artículo | Sí. Aurora **no** es un establecimiento sanitario, por lo que no puede apoyarse en el art. 8 (`[VALIDAR]` la interpretación: el consentimiento expreso sería la base) | Ídem; [Decreto 1558/2001](https://servicios.infoleg.gob.ar/infolegInternet/anexos/70000-74999/70368/texact.htm) |
| **Art. 4** | Datos adecuados, pertinentes y **no excesivos**; **destruirlos cuando dejen de ser necesarios** | Sí. Fundamenta la política de retención y quitar datos innecesarios (por ejemplo, los biométricos que no se usan en el MVP) | InfoLEG |
| **Art. 9** | Medidas técnicas y organizativas de seguridad y confidencialidad | Sí | Ídem |
| **Art. 10** | Secreto profesional de quienes intervienen en el tratamiento, incluso después de terminada la relación | Sí: equipo y cuidadores con acceso | Ídem |
| **Art. 11** | Cesión de datos solo con consentimiento previo, informado, con identidad del cesionario. Es revocable | Sí, en lo que se comparta con terceros | Ídem |
| **Art. 12 y Decreto 1558/2001, art. 12** | Prohibida la transferencia a países **sin nivel de protección adecuado**. La prohibición **no rige si el titular consintió expresamente** la cesión | Sí: Azure en EE. UU., IA, etc. | InfoLEG; Decreto 1558 |
| **Art. 14** | Acceso: respuesta en **10 días corridos**; gratuito a intervalos no menores a **6 meses** | Sí | InfoLEG |
| **Art. 16** | Rectificación, actualización o supresión: **5 días hábiles**; durante la verificación el dato se **bloquea** o se marca "en revisión"; la supresión no procede si hay obligación legal de conservar | Sí | InfoLEG |
| **Art. 21 y Decreto, art. 21** | Inscribir en el registro los archivos **públicos** y los **privados destinados a dar informes** (los que exceden el uso personal o buscan ceder datos) | `[VALIDAR]` (ver 5.5) | InfoLEG; [AAIP](https://www.argentina.gob.ar/servicio/inscribir-un-responsable-de-bases-de-datos-personales-privadas) |
| **Art. 25 y Decreto, art. 25** | Quien trata datos **por cuenta de terceros** solo actúa según instrucciones del responsable, no los cede ni los usa para otros fines, y al terminar el servicio **los destruye**. Los contratos deben incluir seguridad y confidencialidad | Sí: Supabase, Azure, OpenAI/Gemini, Hostinger, Expo | InfoLEG; Decreto 1558 |
| **Decreto 1558/2001, art. 5** | El consentimiento es "informado" si se explica el art. 6 de forma adecuada al **nivel social y cultural** del titular. **Se puede revocar en cualquier momento, sin efectos retroactivos.** El decreto **no regula** el consentimiento de incapaces | Sí | Decreto 1558 |
| **Código Civil y Comercial, arts. 31, 32 y 43** | Toda persona se **presume capaz**, aunque esté en una institución. La capacidad solo se restringe por **sentencia judicial** y de forma excepcional; la sentencia designa **apoyos** (art. 43) o representantes | **Sí, y es la cuestión central** (ver 5.2) | Fuentes doctrinarias y fallos; verificar el texto en InfoLEG |
| **Código Civil y Comercial, art. 59** | Consentimiento informado para **actos médicos**. Si el paciente no puede expresarse, lo dan el representante, el apoyo, el cónyuge, el conviviente, un pariente o un allegado, **solo en emergencia con riesgo cierto e inminente** | No aplica directamente (no son actos médicos), pero muestra el límite de lo que un familiar puede decidir por otro | Fuentes doctrinarias |
| **Ley 26.529 (derechos del paciente)** | Obliga a profesionales e instituciones de salud | **No aplica directamente** a Aurora (vault, 19/07/2026). Sí si algún día se integra con una institución sanitaria | Investigación del vault |
| **Ley 24.240 (consumidor), art. 37; CCyC, arts. 988 y 989** | Cláusulas que limitan la responsabilidad por daños, restringen derechos del usuario o no son razonablemente previsibles **se tienen por no convenidas**. Aplica a contratos por adhesión | Sí, en cuanto haya términos de uso (hoy gratuito; relevante al comercializar) | [Fuente doctrinaria](https://abogados.com.ar/index.php/la-aplicacion-de-sanciones-por-la-inclusion-de-clausulas-abusivas-en-los-contratos-de-consumo/29983) |
| **ANMAT: Disposición 64/2025 (MERCOSUR GMC 25/21)** | El **software puede ser un producto médico** según la finalidad que le asigna el fabricante; si lo es, requiere clasificación por riesgo y registro ante el INPM | **Riesgo a descartar** (ver 5.9) | [Allende & Brea, 24/08/2026](https://www.allende.com/life-sciences/inteligencia-artificial-y-software-medico-en-argentina-desafios-regulatorios-para-el-regimen-de-productos-medicos-08-26-2026/) |
| **IA: Resolución AAIP 161/2023 y guía de 2024** | Programa de transparencia y protección de datos en el uso de IA; la guía recomienda transparencia, supervisión humana y rendición de cuentas. **No es obligatoria** | Orientación recomendable | [Resolución 161/2023](https://www.argentina.gob.ar/normativa/nacional/norma-389231/texto) |
| **Reforma de la Ley 25.326** | No hay ley sancionada. En julio de 2026 ingresó en Diputados el expediente **3397-D-2026** para derogar la 25.326. Propone cambiar la base del consentimiento y notificar incidentes de seguridad en 72 horas | Seguir; la 25.326 sigue vigente | Búsqueda del 12/10/2026 (fuentes secundarias) |

**Países adecuados según la AAIP** ([página oficial](https://www.argentina.gob.ar/transferencias-internacionales)): UE y EEE, Reino Unido, Suiza, Guernsey, Jersey, Isla de Man, Islas Feroe, Canadá (sector privado), Andorra, Nueva Zelanda, Uruguay e Israel (datos automatizados). **Estados Unidos y Brasil no figuran**, por lo que una transferencia a ellos requiere consentimiento expreso o cláusulas contractuales modelo (Resolución AAIP 198/2023).

---

## 3. Brechas del texto actual contra la ley

### 3.1 Checklist del art. 6 (información previa obligatoria)

| Elemento exigido | ¿Está en el texto actual? | Qué falta |
| ----- | ----- | ----- |
| Finalidad | 🟡 Parcial (sección 2) | "Adaptar las interacciones" es vago; falta nombrar cada finalidad |
| **Destinatarios** | 🔴 No | Habla de "proveedores necesarios" sin nombrarlos. Faltan Microsoft Azure, OpenAI/Gemini, Supabase, Hostinger y Expo |
| **Existencia del archivo y responsable (identidad y domicilio)** | 🔴 No | No dice quién es el responsable del tratamiento ni su domicilio |
| **Carácter obligatorio o facultativo** de los datos | 🔴 No | No distingue qué datos son indispensables y cuáles opcionales |
| **Consecuencias** de dar los datos, negarse o darlos inexactos | 🔴 No | No explica qué pasa si no se consiente (por ejemplo, que Aurora no puede funcionar) ni el riesgo de datos incorrectos (medicación) |
| Derechos de acceso, rectificación, supresión | 🟡 Parcial (sección 7) | Sin canal de contacto, sin plazos, sin mencionar la acción de hábeas data ni la AAIP |

### 3.2 Otras brechas

| # | Brecha | Gravedad |
| ----- | ----- | ----- |
| B1 | **No hay Términos y Condiciones de uso** (descripción del servicio, límites, responsabilidades del cuidador, qué pasa si falla una alerta) | Alta |
| B2 | **Consentimiento único y genérico.** Mezcla tratamiento de datos de salud, acceso por terceros y transferencia internacional en un solo checkbox. El consentimiento debe ser específico para cada finalidad y la transferencia debe nombrar los destinatarios | Alta |
| B3 | **El consentimiento no distingue quién lo da.** Hoy lo acepta el cuidador que crea la cuenta; no queda constancia de si el paciente también fue informado ni de qué vínculo tiene el cuidador | **Crítica** (ver 5.2) |
| B4 | **Desactualizado respecto del sistema real.** Habla de "lecturas biométricas" (fuera del MVP), no menciona que el **audio sale a Azure en EE. UU.** ni que se usan OpenAI o Gemini | Alta |
| B5 | **Evidencia insuficiente.** Guarda la versión pero no el texto exacto mostrado ni los datos del dispositivo. La fecha de aceptación viene del reloj del cliente | Media |
| B6 | **Revocación sin efectos definidos.** Dice que "puede revocarse" pero no qué se elimina ni cuándo (hay una propuesta en el archivo 07, sección 5.3) | Alta |
| B7 | **Sin nada sobre IA:** que el asistente es un sistema automatizado, que puede equivocarse y que no da consejo médico | Media |
| B8 | **Sin información sobre el tratamiento de la voz** (qué se envía, cuándo escucha, que no se guarda) | Alta |

---

## 4. Contratos con proveedores (art. 25)

Cada servicio que procesa datos de pacientes actúa como **encargado** y debe estar bajo un contrato que lo obligue a usarlos solo según las instrucciones del responsable y a mantener seguridad y confidencialidad.

| Proveedor | Qué trata | País | Contrato a documentar |
| ----- | ----- | ----- | ----- |
| Microsoft Azure Speech | Audio y texto de voz | EE. UU. (East US) | Términos de protección de datos de Azure `[VERIFICAR qué suscripción y términos se aceptaron; hoy es nivel gratuito]` |
| OpenAI y/o Gemini (vía Worker IA) | Texto de conversaciones y memorias | EE. UU. | Términos de API y de protección de datos `[VERIFICAR retención y entrenamiento]` |
| Supabase | Toda la base de datos y la autenticación | **EE. UU.** (región `us-east-1`, Virginia) | DPA de Supabase |
| Hostinger | VPS donde corren Core, Worker IA y n8n | **EE. UU.** (Boston) | Términos del proveedor |
| Expo (notificaciones push) | Token del dispositivo y el contenido de la notificación | EE. UU. | Términos de Expo; por eso las notificaciones no deben llevar datos personales (RF-98) |

La AAIP publicó cláusulas contractuales modelo para encargados (Resolución 198/2023). **No pude verificar** si Microsoft, OpenAI o Supabase las aceptan; en la práctica ofrecen sus propios acuerdos de procesamiento de datos, de inspiración europea. `[VALIDAR con asesor si alcanza el consentimiento expreso del titular o si conviene además documentar el acuerdo del proveedor]`.

---

## 5. Cuestiones de fondo y posición recomendada

### 5.1 ¿Con qué base legal se tratan los datos de salud?

* El art. 8 (datos de salud) habilita a **establecimientos sanitarios y profesionales** de la salud. Aurora no lo es.
* La base realista es el **consentimiento expreso, informado y por escrito (art. 5)** del titular.
* **Recomendación:** que el consentimiento sea el eje del diseño, sin apoyarse en excepciones. `[VALIDAR]` con un abogado que esta interpretación es suficiente para el art. 7.

### 5.2 ¿Quién consiente por un paciente con deterioro cognitivo? (cuestión crítica)

**Lo que dice el derecho:**
* Toda persona se **presume capaz** (CCyC, art. 31), aun con un diagnóstico de demencia. Solo una **sentencia judicial** la restringe, y esa sentencia designa un **apoyo** o un representante (arts. 32 y 43).
* **Un familiar o cuidador no tiene, por ese solo hecho, facultad para consentir por el paciente.** El art. 59 del CCyC admite que lo hagan parientes y allegados, pero solo para actos médicos y en una emergencia con riesgo cierto e inminente.
* El Decreto 1558/2001 **no regula** el consentimiento de incapaces.

**Consecuencia:** lo que escribí en el archivo 07 ("su representante legal, tutor, curador o **familiar con representación acreditada**") era impreciso. Un familiar sin designación judicial no tiene representación acreditable.

**Tres situaciones posibles y qué hacer:**

| Situación | Quién consiente | Qué se registra |
| ----- | ----- | ----- |
| **A. El paciente conserva capacidad** (lo normal en FAST ≤ 5, y mientras no haya sentencia) | **El paciente**, informado en lenguaje claro y adecuado a su nivel (Decreto 1558, art. 5), con el cuidador como acompañante | Que el paciente fue informado y aceptó; el cuidador figura como acompañante |
| **B. Hay sentencia de capacidad restringida con apoyo, o curador** | **El paciente con su apoyo**, o el curador si la sentencia le da esa facultad | Copia o referencia de la sentencia y quién ejerce el rol |
| **C. No puede comprender ni expresar una decisión y no hay sentencia ni apoyo** | **Nadie puede consentir válidamente de forma directa.** `[VALIDAR]` opciones con un abogado: iniciar el trámite judicial de apoyo, o limitar el uso | Aurora no debería activarse hasta resolverlo |

**Qué implica para el producto:**
1. El flujo de alta debe **preguntar cuál de las tres situaciones aplica** y registrar la respuesta.
2. El texto de consentimiento debe estar redactado en **lenguaje claro** y poder leerse o explicarse al paciente (Decreto 1558, art. 5). Conviene una versión breve, con pictogramas, para el paciente.
3. Hay que registrar el **consentimiento del cuidador por sus propios datos** (nombre, correo, cuenta) como un consentimiento aparte, porque él sí es titular de esos datos.
4. Como el perfil del paciente es de deterioro **leve a moderado**, la situación A será la más común. Es importante no tratar "tiene Alzheimer" como equivalente a "no puede consentir".
5. **Siempre que el paciente pierda capacidad, el consentimiento debe poder renovarse** con quien corresponda. Se recomienda una revisión periódica.

### 5.3 Transferencia internacional (Estados Unidos)

* **Todo el servicio, salvo Aurora Home, está en Estados Unidos:** la base de datos (Supabase, `us-east-1`, Virginia), los servidores (Hostinger, Boston), la voz (Azure, East US), el texto de las conversaciones (OpenAI o Gemini) y las notificaciones (Expo). **Estados Unidos no figura entre los países adecuados** de la AAIP. Es decir, **toda la información del paciente, incluidos los datos de salud almacenados, sale de Argentina**, no solo la voz.
* El mecanismo viable es el **consentimiento expreso** del titular a la cesión (Decreto 1558, art. 12). Para que sea válido debe ser **específico** y **nombrar los destinatarios** y el país.
* **Recomendación:** un **consentimiento separado** para la transferencia internacional, con una lista de destinatarios (nombre, país, qué datos). Si cambia un proveedor, se publica una **nueva versión** y se pide una nueva aceptación.
* **Reducción del riesgo:** la clasificación de la confirmación de medicación se hace localmente, el audio solo sale durante las ventanas de escucha, y las notificaciones push no llevan datos personales.
* **Región de la base de datos:** la región real es `us-east-1` (EE. UU.). La investigación del vault había recomendado **São Paulo** o la **UE**. Brasil tampoco es adecuado, pero **la UE sí lo es y deja la transferencia habilitada por la propia ley**, sin depender del consentimiento para ese destino.
* **Decisión del equipo (13/10/2026): la ubicación se mantiene en Estados Unidos** (Supabase `us-east-1`, Hostinger Boston, Azure East US). No se migra a la UE. La transferencia se cubre con el consentimiento expreso y **queda asentada en la Política de Privacidad y en el consentimiento 2** (sección 7), que nombran a cada proveedor y su ubicación. Si más adelante cambia un proveedor o una región, se publica una nueva versión y se pide una nueva aceptación. *(Alternativa descartada por ahora: migrar a la UE, que habría dejado la transferencia habilitada por la propia ley.)*
* **Consecuencia para el consentimiento:** como sin esta transferencia el servicio no puede funcionar, es un dato que **debe informarse como obligatorio** (art. 6) y su rechazo implica no poder usar Aurora.

### 5.4 Derechos del titular: plazos y canal

Lo que el archivo 07 proponía estaba **mal calibrado**. Los plazos legales son:

| Derecho | Plazo legal | Cómo se cuenta |
| ----- | ----- | ----- |
| **Acceso** | **10 días corridos** | Desde la intimación (art. 14). Gratuito al menos cada 6 meses |
| **Rectificación, actualización o supresión** | **5 días hábiles** | Desde el reclamo (art. 16). Mientras se verifica, el dato se bloquea o se marca "en revisión" |

El texto debe indicar un **canal de contacto real** (correo del responsable) y que el titular puede reclamar ante la **AAIP**, que es el órgano de control. La AAIP exige una leyenda estándar en los formularios que recolectan datos `[VERIFICAR el texto vigente de la leyenda de la Disposición DNPDP 10/2008]`.

### 5.5 Registro de la base de datos

* El art. 21 y el decreto exigen inscribir los archivos públicos y los **privados "destinados a dar informes"**, definidos como los que exceden el uso exclusivamente personal o buscan ceder o transferir datos, sea onerosa o gratuitamente. La inscripción se hace por TAD y es una declaración jurada.
* Aurora **no entrega informes sobre personas a terceros**, pero sí **cede datos a proveedores en el exterior** y opera una base propia.
* **Recomendación:** `[VALIDAR]` si corresponde. Para la etapa de piloto con personas reales, lo prudente es **inscribirla antes**. Para la entrega académica, alcanza con documentar la decisión y el criterio.

### 5.6 Conservación y destrucción

* El art. 4 exige destruir los datos cuando dejan de ser necesarios. El art. 25 exige que el encargado destruya los datos al terminar el servicio.
* La política del archivo 07 (sección 4) es coherente con eso. Falta que el **texto al usuario** la explique (qué se conserva, cuánto y por qué) y que exista el proceso de depuración (RF-96), que hoy no está implementado.

### 5.7 Seguridad e incidentes

* El art. 9 obliga a medidas de seguridad; la ley vigente **no obliga a notificar incidentes**, pero el proyecto 3397-D-2026 propone 72 horas.
* **Recomendación:** definir igual un protocolo interno de incidentes (quién decide, a quién se avisa, en qué plazo) y mencionarlo en el texto.
* El texto actual dice que no afirma que las medidas estén implementadas. Antes de usar datos reales hay que **verificar cada medida** (archivo 07, RNF-44 a RNF-52) y que el texto describa solo lo que existe. **No debe prometer controles que no estén implementados**: hacerlo es riesgoso en términos de defensa del consumidor.

### 5.8 Inteligencia artificial

* No hay una ley argentina de IA. La AAIP recomienda (no obliga) transparencia, supervisión humana y rendición de cuentas.
* **Recomendación para el texto:** informar que el asistente es un **sistema automatizado**, que **puede equivocarse**, que **no da consejo médico** y que las decisiones sobre la salud las toman las personas. Esto se alinea con las reglas de negocio 4 y 13.

### 5.9 ¿Es Aurora un producto médico? (ANMAT)

* La Disposición ANMAT 64/2025 incorporó la norma MERCOSUR que define el **software como producto médico según la finalidad que le asigna el fabricante**. Si lo es, requiere clasificación y registro ante el INPM.
* **No encontré una guía pública** que diga cuándo un software de bienestar o de recordatorios queda fuera.
* **Lo que ayuda a Aurora:** el MVP **no diagnostica, no recomienda tratamientos y no modifica medicación**; los recordatorios y registros son funciones de asistencia.
* **Lo que preocupa:** el Estudio Inicial dice que Aurora busca "ayudar a la **rehabilitación cognitiva**", y menciona "terapias", "monitoreo biométrico" y "detección de eventos de riesgo". Esas expresiones podrían interpretarse como una **finalidad médica**.
* **Recomendaciones:**
  1. Declarar la **finalidad prevista** como *"acompañamiento y apoyo a la rutina; no es un producto médico ni reemplaza la atención profesional"* y usarla de forma consistente en el Estudio Inicial, el Plan, la app y cualquier material.
  2. Revisar el vocabulario ("rehabilitación", "terapia", "tratamiento") en los documentos, tal como pidió la profe con el límite de diagnóstico y tratamiento (punto 3).
  3. `[VALIDAR]` con el INPM o un abogado si el producto, tal como se presenta, queda fuera del régimen, **antes** de cualquier etapa comercial o de las funciones de futuras versiones (detección de caídas, agitación, biometría), que sí se acercan a una finalidad médica.

### 5.10 Términos y Condiciones de uso (consumidor)

* Hoy el servicio es gratuito y de investigación, pero conviene tener términos desde ahora y que sean consistentes con la defensa del consumidor para la etapa comercial.
* Una cláusula que **limite la responsabilidad por daños** o **exima de culpa por adelantado** puede considerarse abusiva y tenerse por no convenida (Ley 24.240, art. 37; CCyC, art. 988). Lo que sí corresponde es **informar con claridad las limitaciones reales** del servicio, no eximirse.
* **Lo más importante para el usuario de Aurora:** el servicio **no es un servicio de emergencias** y las alertas dependen de la conectividad y de que el cuidador reciba y lea la notificación. Debe estar dicho con claridad, con destacado visual, en el alta.

### 5.11 Forma del consentimiento y prueba

* El art. 5 exige consentimiento "por escrito o por un medio equivalente". El decreto delega en la autoridad los requisitos de los medios no escritos, que deben asegurar **autoría e integridad**.
* **Recomendación:** guardar la versión, el **texto exacto o su huella digital (*hash*)**, el usuario, el momento según el servidor, el dispositivo y el idioma. Una aceptación electrónica se considera firma electrónica y, si se la desconoce, quien la invoca debe probar su validez (Ley 25.506, art. 5) `[VERIFICAR]`: por eso importa la calidad de la evidencia.

### 5.12 ¿Quién es el responsable del tratamiento?

La Ley 25.326 llama **responsable** a la persona, física o jurídica, titular del archivo o base de datos, es decir, **quien decide para qué y cómo se usan los datos** (art. 2). El art. 6 exige informar a quien da sus datos **quién es ese responsable, con nombre y domicilio**. También es quien responde ante un reclamo del titular, quien recibe los pedidos de acceso y supresión, y quien firmaría la inscripción de la base ante la AAIP (con clave fiscal).

Hoy el texto de Care no lo dice, y el equipo **no es una persona jurídica**: son cinco estudiantes de un proyecto de tesis. Eso obliga a decidir quién figura. `[VALIDAR con la cátedra]`

| Opción | Cómo funcionaría | Ventajas | Riesgos |
| ----- | ----- | ----- | ----- |
| **A. La UTN-FRC como institución** | La facultad avala el piloto y figura como responsable, con el equipo como ejecutor | Respaldo institucional; la responsabilidad no recae en una persona | Requiere autorización formal de la facultad; puede no estar dispuesta |
| **B. Un integrante designado** (por ejemplo, el Project Manager) | Una persona figura con su nombre y domicilio, y el correo de contacto es del proyecto | Es simple y se puede hacer ya | Esa persona responde personalmente. Además su domicilio queda publicado |
| **C. Los cinco integrantes en conjunto** | Los cinco figuran como corresponsables | Reparte la responsabilidad | Cinco domicilios publicados; poco práctico para recibir pedidos |
| **D. Una entidad creada para el proyecto** (por ejemplo, una SAS) | Se constituye una sociedad que será titular | Es la forma correcta para la etapa comercial | Costo y trámites. No es realista para una tesis con un piloto chico |

**Recomendación:** para el piloto académico, consultar a la cátedra si la **opción A** es posible. Si no, la **B** con un correo de contacto del proyecto (no personal), documentando que es temporal. La **D** queda para la etapa comercial. En cualquier caso hay que dejarlo escrito en la Política de Privacidad (punto 1 de la sección 7) y en la ficha del registro de la base, si se decide inscribirla.

> **Estado (13/10/2026): en averiguación.** Por decisión del equipo, esta figura **no se incluye todavía en el borrador** de la política (queda como pendiente en el punto 1 de la sección 7).

Este dato también determina quién firma los acuerdos con proveedores (sección 4) y quién ejerce las atribuciones del Product Owner y del Scrum Master frente a un reclamo.

---

## 6. Qué cambiar en Aurora Care

### 6.1 Documentos a separar

| Documento | Contenido | Aceptación |
| ----- | ----- | ----- |
| **Términos y Condiciones de Uso** (nuevo) | Servicio, límites, responsabilidades, IA, disponibilidad, baja | Checkbox propio, al crear la cuenta |
| **Política de Privacidad** (reemplaza a *Privacidad MVP v0.1*) | Art. 6 completo: responsable, finalidades, destinatarios, derechos, plazos | Se informa, se lee |
| **Consentimiento informado, datos de salud** | Tratamiento de datos sensibles del paciente | Checkbox propio, **dado por el titular o quien corresponda** |
| **Consentimiento, transferencia internacional** | Destinatarios nombrados, país y datos | Checkbox propio |
| **Consentimiento del cuidador** (nuevo) | Tratamiento de sus propios datos | Checkbox propio |

*El consentimiento de datos no puede estar atado a la aceptación de los términos del servicio: son decisiones distintas.*

### 6.2 Cambios técnicos

| # | Cambio | Dónde |
| ----- | ----- | ----- |
| 1 | Nueva versión del texto (`privacy-v1.0`) y retiro del aviso "versión informativa" solo después de la validación legal | Care: `privacyConsent.ts`, `app/privacy.tsx` |
| 2 | Pantalla de **Términos y Condiciones** y su aceptación | Care: nueva pantalla |
| 3 | Tres consentimientos separados con tipos propios (datos de salud, transferencia internacional, cuidador) | Care y Core: `consent_type` |
| 4 | Campo **"quién consiente"** (paciente / apoyo / curador) y vínculo; y paso del alta que pregunta la situación A/B/C | Care y Core: modelo de consentimiento |
| 5 | Guardar **huella (*hash*) del texto** mostrado y momento del servidor | Core |
| 6 | Mostrar la **lista de destinatarios** en la transferencia internacional | Care |
| 7 | Texto en **lenguaje claro** y versión breve para el paciente | Care / diseño UX |
| 8 | Leyenda de la AAIP y canal de contacto | Care |
| 9 | Quitar de la información al usuario las menciones a biometría | Care |

---

## 7. Política de Privacidad y textos de consentimiento (borrador v1.0)

> **Estado del borrador (13/10/2026):**
> * El **responsable del tratamiento** queda **pendiente**: el equipo está averiguando qué figura corresponde (ver 5.12). No se incluye en el texto hasta definirlo. **No publicar hasta completar ese punto.**
> * La **ubicación de los datos queda tal como está**: Supabase en `us-east-1` (Virginia), Hostinger en Boston y Azure en East US. No se migra a la UE. La decisión se cubre con el consentimiento expreso y **queda asentada en las políticas** (puntos 5, 6 y 11 de la política y los textos de consentimiento de 7.2).
> * Este texto es un borrador para revisar con un abogado o la cátedra. Los datos entre corchetes los completa el equipo.

### 7.1 Política de Privacidad

**1. Responsable del tratamiento.** `[PENDIENTE: nombre, domicilio y correo. A definir; no publicar sin completar]`

**2. Qué datos tratamos.**
* *Del cuidador:* nombre, correo electrónico y pertenencia al hogar.
* *De la persona acompañada:* nombre, DNI, fecha de nacimiento, nivel funcional, contactos de emergencia, rutinas, medicación, recuerdos y vínculos familiares, respuestas a los recordatorios, eventos, alertas, y **el audio y la transcripción de sus conversaciones con Aurora Home durante las ventanas de interacción**.
* Muchos de estos datos son **sensibles** porque revelan información de salud.

**3. Para qué los usamos.** Emitir recordatorios; registrar si se cumplieron; avisar al cuidador cuando una medicación o rutina importante no se confirma; proponer actividades de estimulación y reminiscencia; ajustar la dificultad de las actividades; y mantener un historial para el cuidador. **No usamos los datos para publicidad ni para entrenar modelos de inteligencia artificial.**

**4. Qué datos son obligatorios y qué pasa si no los das.**
* Son **obligatorios** los datos del cuidador, del hogar, del paciente y de sus rutinas y medicación: sin ellos Aurora no puede prestar el servicio.
* Son **opcionales** los recuerdos y los datos biográficos; si no los cargás, las conversaciones serán menos personalizadas.
* Si un dato es **inexacto** (por ejemplo, un horario de medicación), los recordatorios y las alertas serán incorrectos. Mantenerlos al día es responsabilidad del cuidador.
* Si **no das el consentimiento** para tratar los datos de salud o para su transferencia a Estados Unidos (puntos 5 y 6), **no podemos activar Aurora**.

**5. Con quién compartimos los datos.** Aurora usa estos proveedores, que tratan los datos solo siguiendo nuestras instrucciones:

| Proveedor | Para qué | Datos | Ubicación |
| ----- | ----- | ----- | ----- |
| **Supabase** | Base de datos y cuentas de usuario | Todos los datos de la cuenta y del paciente | **Estados Unidos** (región `us-east-1`, Virginia) |
| **Hostinger** | Servidores donde funciona Aurora | Todos los datos que pasan por el sistema | **Estados Unidos** (Boston) |
| **Microsoft Azure** | Convertir voz a texto y texto a voz | Audio de las conversaciones y texto a sintetizar | **Estados Unidos** (región East US) |
| **`[OpenAI y/o Google (Gemini)]`** | Generar las respuestas del asistente | Texto de la conversación y datos de contexto (rutinas, medicación, recuerdos) | **Estados Unidos** |
| **Expo** | Enviar notificaciones al celular del cuidador | Identificador del dispositivo; el mensaje no contiene datos personales | **Estados Unidos** |

**6. Dónde se almacenan y procesan tus datos (transferencia internacional).**
* **Los datos del paciente y del cuidador se almacenan y procesan en servidores ubicados en Estados Unidos.** Solo Aurora Home, el dispositivo que está en el domicilio, queda en Argentina.
* La autoridad argentina de protección de datos **no reconoce a Estados Unidos** como un país con nivel de protección adecuado. Por eso, la ley permite esta transferencia **solo con tu consentimiento expreso**, que se pide por separado (ver 7.2).
* Si no lo das, Aurora no puede funcionar, porque el servicio completo depende de esos proveedores.
* Si cambiamos de proveedor o de ubicación, te mostraremos la nueva versión y te pediremos una nueva aceptación.

**7. Cuándo escucha Aurora.** Aurora Home **no escucha de forma ambiental ni continua**. Solo abre el micrófono durante un recordatorio o una actividad. Ese audio se envía a Microsoft Azure para convertirlo en texto y **no lo guardamos nosotros**. Microsoft declara que, en el modo en tiempo real, no retiene ni almacena el audio. Sin conexión a internet, la voz se procesa dentro del dispositivo.

**8. Inteligencia artificial.** El asistente es un **sistema automatizado**. Puede equivocarse. **No da diagnósticos, no recomienda tratamientos ni modifica la medicación**, y ante dudas te remite al cuidador. Las decisiones sobre la salud las toman las personas.

**9. Cuánto tiempo conservamos los datos.**

| Dato | Plazo |
| ----- | ----- |
| Audio | No se almacena (buffer en el dispositivo de hasta 5 minutos) |
| Transcripciones de conversaciones | 6 meses |
| Respuestas a recordatorios, eventos y alertas | 2 años |
| Rutinas, medicación, recuerdos, datos del paciente y del cuidador | Mientras dure el uso del servicio + 90 días |
| Registro de consentimientos y revocaciones | Mientras dure el uso del servicio + 5 años (sin datos del paciente) |
| Registro de solicitudes de derechos | 2 años |

Al vencer el plazo, los datos se eliminan o se anonimizan. `[Confirmar con el equipo que el proceso automático de depuración esté implementado antes de publicar este punto]`

**10. Tus derechos.**
* **Acceso:** podés pedir que te informemos qué datos tenemos. Respondemos en **10 días corridos**. Es gratuito al menos cada 6 meses.
* **Rectificación, actualización o supresión:** respondemos en **5 días hábiles**. Mientras verificamos tu pedido, el dato queda bloqueado o marcado como "en revisión".
* **Cómo ejercerlos:** escribiendo a `[correo de contacto]`.

**11. Revocación del consentimiento.** Podés revocarlo en cualquier momento desde *Ajustes → Privacidad*. No afecta lo tratado antes de revocar. Al revocar:
* En 24 horas Aurora deja de capturar voz y de procesar datos, y se suspenden los recordatorios y las notificaciones.
* Durante 90 días podés exportar tus datos.
* Pasados los 90 días, eliminamos los datos del paciente y del cuidador. Solo conservamos la constancia de que existió un consentimiento y de que se revocó.
* **Si revocás el consentimiento de transferencia a Estados Unidos, Aurora deja de funcionar**, porque el servicio depende de esos proveedores.

**12. Seguridad.** Estas son las medidas que hoy están implementadas:
* **Nombre, DNI y datos de los contactos de emergencia se almacenan cifrados** en la base de datos.
* Las comunicaciones usan **conexiones cifradas (HTTPS)**.
* Cada cuidador solo accede a los hogares a los que fue asociado.
* Las **modificaciones** de datos relevantes quedan registradas.
* Cada Aurora Home usa **su propia credencial** para comunicarse con el sistema.

`[NOTA INTERNA, no publicar: verificar antes de agregar. (a) Los datos de salud (medicación, rutinas, recuerdos) no tienen cifrado a nivel de campo; solo lo tienen los datos identificatorios. Confirmar si el proveedor de base de datos cifra en reposo. (b) El registro de accesos existe como tabla y como consulta, pero no encontré que se complete: no afirmarlo hasta implementarlo. (c) Copias de respaldo: no confirmadas.]`

**13. Reclamos.** *"La AGENCIA DE ACCESO A LA INFORMACIÓN PÚBLICA, en su carácter de Órgano de Control de la Ley N° 25.326, tiene la atribución de atender las denuncias y reclamos que interpongan quienes resulten afectados en sus derechos por incumplimiento de las normas vigentes en materia de protección de datos personales."* `[VERIFICAR el texto vigente]`

**14. Cambios y versión.** Versión `privacy-v1.0`. Si el documento cambia (por ejemplo, un proveedor o una ubicación), te mostraremos la nueva versión y te pediremos una nueva aceptación.

### 7.2 Textos de consentimiento (cada uno con su propia casilla)

Los tres son **independientes** y ninguno está atado a la aceptación de los Términos y Condiciones.

#### Consentimiento 1: tratamiento de datos de salud (lo da el titular o quien corresponda, ver 5.2)

> **Consentimiento para tratar datos de salud**
> Entiendo que Aurora va a tratar información sobre mi salud (mi medicación, mis rutinas, mis recuerdos y mis conversaciones con Aurora Home) para recordarme actividades, avisar a mi cuidador y guardar un historial. Sé que estos datos son sensibles, que puedo no darlos, y que sin ellos Aurora no puede funcionar. Puedo retirar este consentimiento cuando quiera.
> ☐ **Acepto**

#### Consentimiento 2: almacenamiento y procesamiento en Estados Unidos (transferencia internacional)

> **Consentimiento para almacenar y procesar mis datos en Estados Unidos**
> Entiendo que mis datos, incluidos los de salud, se **guardan y procesan en servidores de Estados Unidos**, de estas empresas:
> * **Supabase** (base de datos, Virginia)
> * **Hostinger** (servidores, Boston)
> * **Microsoft Azure** (voz, East US)
> * **`[OpenAI y/o Google]`** (respuestas del asistente)
> * **Expo** (notificaciones)
>
> Sé que Argentina no reconoce a Estados Unidos como un país con nivel de protección adecuado, y que doy mi consentimiento expreso a esta transferencia. Sé que si no lo doy, Aurora no puede funcionar. Puedo retirarlo cuando quiera, y entonces Aurora deja de funcionar.
> ☐ **Acepto**

#### Consentimiento 3: datos del cuidador

> **Consentimiento para tratar mis datos como cuidador**
> Acepto que Aurora trate mi nombre, mi correo y mi pertenencia al hogar para darme acceso y enviarme avisos. Estos datos también se guardan en Estados Unidos, como indica el consentimiento 2.
> ☐ **Acepto**

### 7.3 Qué debe registrar el sistema en cada aceptación

| Dato | Para qué |
| ----- | ----- |
| Tipo de consentimiento (datos de salud, transferencia internacional, cuidador) | Distinguir qué se aceptó |
| **Versión** de la política y **huella (*hash*) del texto mostrado** | Probar exactamente qué se leyó |
| **Quién consiente**: paciente, paciente con apoyo, curador; y vínculo del acompañante | Validez del consentimiento (ver 5.2) |
| **Destinatarios y ubicaciones vigentes** al momento de aceptar (lista de proveedores y país) | Probar qué se informó sobre la transferencia |
| Momento según el **servidor**, dispositivo e idioma | Evidencia |
| Revocación (fecha) y qué efectos se ejecutaron | Cumplir el punto 11 |

**Regla de versionado:** cualquier cambio de proveedor, de región o de finalidad genera una versión nueva y obliga a una nueva aceptación.

### 7.4 Versión breve en lenguaje claro para el paciente

*(Se lee en voz alta o se muestra con pictogramas; el Decreto 1558/2001 pide explicar la información de forma adecuada al nivel del titular.)*

> **Qué es Aurora.** Es una ayuda para que te acuerdes de tus cosas del día: tus remedios, tus rutinas y algunos juegos. Tu cuidador va a saber cómo te va.
>
> **Qué guarda.** Guarda tu nombre, tus remedios, tus recuerdos y lo que charlás con Aurora.
>
> **Dónde.** Los guarda en computadoras de otra empresa, en Estados Unidos.
>
> **Quién lo ve.** Vos, tu cuidador y las empresas que hacen funcionar Aurora.
>
> **Vos decidís.** Podés decir que no. Si decís que no, Aurora no funciona. Y si cambiás de idea, lo podés cambiar cuando quieras.
>
> **Aurora no es un médico.** No te dice qué remedio tomar. Eso lo hablás con tu médico y tu cuidador.

---

## 8. Términos y Condiciones de Uso: esquema propuesto

| Sección | Contenido |
| ----- | ----- |
| 1. Qué es Aurora | Sistema de acompañamiento y apoyo a la rutina. **No es un producto médico, no diagnostica, no recomienda tratamientos ni reemplaza la atención profesional** |
| 2. **Aurora no es un servicio de emergencias** | Las alertas dependen de la conectividad, del dispositivo y de que el cuidador las reciba; pueden demorarse o fallar. **Ante una emergencia, llamar a los servicios de emergencia.** *(Información destacada, no una exención de responsabilidad)* |
| 3. Quién puede usarla | Mayores de edad, cuidadores del hogar. Una cuenta por hogar y un paciente por hogar |
| 4. Responsabilidades del cuidador | Mantener al día medicación y rutinas; atender las alertas; no compartir la cuenta; obtener el consentimiento correspondiente (regla de negocio 14) |
| 5. Uso de IA | Sistema automatizado, puede equivocarse, sin consejo médico |
| 6. Disponibilidad | Servicio en etapa de proyecto de tesis, sin garantía de disponibilidad continua `[ajustar al volverse comercial]` |
| 7. Datos | Remite a la Política de Privacidad |
| 8. Baja | Cómo se da de baja la cuenta y qué ocurre con los datos |
| 9. Ley aplicable y reclamos | Ley argentina; canal de contacto; derechos del consumidor |

> **Cuidado con las cláusulas de limitación de responsabilidad.** En una etapa comercial, la ley las considera abusivas si limitan la responsabilidad por daños de forma anticipada. Las secciones 1, 2 y 6 deben **informar** límites reales, no excluir toda responsabilidad.

---

## 9. Correcciones al archivo 07 que se desprenden de esta investigación

| En el archivo 07 | Cambiar por |
| ----- | ----- |
| **RNF-49**: "10 días hábiles" para acceso, rectificación y supresión | **Acceso: 10 días corridos. Rectificación, actualización o supresión: 5 días hábiles** (Ley 25.326, arts. 14 y 16) |
| **Sección 5.1**: "su representante legal (tutor, curador o familiar con representación acreditada)" | Reemplazar por las tres situaciones A, B y C de la sección 5.2 de este archivo |
| **Sección 8.4**: "evaluar si hay cláusulas contractuales modelo" | Dejar el consentimiento expreso como mecanismo principal y las cláusulas modelo de la Resolución 198/2023 como complemento a evaluar; Estados Unidos **confirmado como no adecuado** según la lista oficial de la AAIP |
| **RF-92**: un consentimiento | Tres consentimientos separados (datos de salud, transferencia internacional, cuidador) |

---

## 10. Preguntas para llevar a un abogado o a la cátedra

1. ¿Es suficiente el **consentimiento expreso por escrito** como base para tratar datos de salud (arts. 5 y 7), dado que Aurora no es un establecimiento sanitario?
2. Para una persona con deterioro cognitivo **sin sentencia de capacidad restringida**, ¿alcanza su consentimiento informado, acompañado por el cuidador? ¿Qué hacemos si no puede comprender? ¿Un familiar puede consentir el tratamiento de sus datos en su lugar?
3. ¿Es válido el **consentimiento expreso** para la transferencia a EE. UU. (Azure, OpenAI), o conviene también un acuerdo con el proveedor basado en las cláusulas modelo de la AAIP?
4. ¿Corresponde **inscribir la base de datos** en el Registro Nacional antes del piloto?
5. ¿Queda Aurora, tal como la presentamos, **fuera del régimen de productos médicos** de ANMAT? ¿Qué palabras debemos evitar?
6. ¿Qué **leyenda y qué contenido mínimo** exige hoy la AAIP en la política de privacidad?
7. ¿Cómo se distribuye la **responsabilidad** entre el equipo (responsable del tratamiento), los cuidadores y los proveedores?
8. Para la etapa comercial: ¿qué cláusulas de los términos serían **abusivas** y cuáles son aceptables?

---

## 11. Plan de acción priorizado

| Prioridad | Acción | Quién |
| ----- | ----- | ----- |
| **P0: antes de usar con personas reales** | Validación legal de las preguntas 1, 2 y 3 | Cátedra / abogado |
| P0 | Reescribir la Política de Privacidad (sección 7) y crear los Términos (sección 8) | Mateo / Nicolás (Care) + Product Owner |
| P0 | Nuevo flujo de consentimiento: tres consentimientos, quién consiente, huella del texto | Care + Core |
| P0 | ~~Región de Supabase y ubicación de Hostinger~~ (resuelto: ambos en EE. UU. y se mantienen; queda asentado en los consentimientos). Documentar los contratos con proveedores | Octavio / Jeremías |
| P0 | **Averiguar quién figura como responsable del tratamiento** (5.12) | Equipo / cátedra |
| P1 | Proceso de depuración de datos vencidos (RF-96) | Core |
| P1 | Token temporal para la credencial de Azure (RNF-52) | Core + Home |
| P1 | Declarar la finalidad prevista y revisar el vocabulario ("rehabilitación", "terapia") en todos los documentos | Product Owner |
| P2 | Decidir la inscripción en el Registro de bases de datos | Cátedra / abogado |
| P2 | Protocolo interno de incidentes | Jeremías (DevOps) |
| Seguimiento | Estado del proyecto de reforma 3397-D-2026 | Product Owner |

---

## 12. Fuentes

**Normativa y organismos oficiales**
* [Ley 25.326, texto actualizado (InfoLEG)](https://servicios.infoleg.gob.ar/infolegInternet/anexos/60000-64999/64790/texact.htm)
* [Decreto 1558/2001, texto actualizado (InfoLEG)](https://servicios.infoleg.gob.ar/infolegInternet/anexos/70000-74999/70368/texact.htm)
* [AAIP: transferencias internacionales](https://www.argentina.gob.ar/transferencias-internacionales)
* [AAIP: inscripción de responsables de bases de datos privadas](https://www.argentina.gob.ar/servicio/inscribir-un-responsable-de-bases-de-datos-personales-privadas)
* [Resolución AAIP 161/2023 (IA)](https://www.argentina.gob.ar/normativa/nacional/norma-389231/texto)

**Secundarias (verificar el texto original antes de citar)**
* [Allende & Brea: software médico e IA en Argentina (LA LEY, 24/08/2026)](https://www.allende.com/life-sciences/inteligencia-artificial-y-software-medico-en-argentina-desafios-regulatorios-para-el-regimen-de-productos-medicos-08-26-2026/)
* [Cláusulas abusivas en contratos de consumo (abogados.com.ar)](https://abogados.com.ar/index.php/la-aplicacion-de-sanciones-por-la-inclusion-de-clausulas-abusivas-en-los-contratos-de-consumo/29983)
* Capacidad y apoyos (CCyC arts. 31, 32, 43 y 59): jurisprudencia y doctrina; **verificar el texto de los artículos en InfoLEG**.
* Reforma de la Ley 25.326 (expediente 3397-D-2026): notas de estudios jurídicos; **confirmar en el sistema de proyectos de la Cámara de Diputados**.
* Investigación previa del vault: *Investigación — Almacenamiento de Datos y Ley 25.326* (19/07/2026).
